#requires -version 4.0

#search WMI for a class
Function Find-CimClass {
    [CmdletBinding()]
    [OutputType([Microsoft.Management.Infrastructure.CimClass])]

    Param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "Enter the name of a CIM/WMI class. Wildcards are permitted.")]
        [ValidateNotNullOrEmpty()]
        [string]$Classname,

        [Parameter(HelpMessage = "Enter a pattern for class names to EXCLUDE from the results. You can use wildcards or regular expressions.")]
        [string]$Exclude,

        [Parameter(HelpMessage = "Enter the name of a computer to search.")]
        [ValidateNotNullOrEmpty()]
        [string]$Computername = $env:COMPUTERNAME
    )

    Write-Verbose "Starting $($myinvocation.MyCommand)"

    #define a hashtable of parameters to splat to Write-Progress
    $progParams = @{
        Activity         = $myinvocation.MyCommand
        PercentComplete  = 0
        Status           = "Enumerating namespaces on $($Computername.ToUpper())"
        CurrentOperation = "Creating temporary CIMSession"
    }

    Write-Progress @progParams
    Write-Verbose "Creating a temporary CIMSession to $($Computername.ToUpper())."

    Try {
        $cs = New-Cimsession -ComputerName $computername -ErrorAction Stop
    }
    Catch {
        Write-Warning "Failed to connect to $($Computername.ToUpper())"
        Write-Warning $_.exception.Message
        #bail out of the function
        return
    }

    $progParams.CurrentOperation = "Building namespace list"
    #build a list of namespaces
    Function _enumnamespace {
        [cmdletbinding()]
        Param(
            [string]$Namespace = "Root",
            [cimsession]$session
        )
    
        Get-CimInstance -Namespace $namespace -ClassName __Namespace -cimsession $session |
            Foreach-object { 
            $n = Join-Path $Namespace $_.Name 
            #write the namespace path to the pipeline
            $n
            #recurse through each namespace
            _enumnamespace -Namespace $n -session $session
        }
    }
    #build a list of namespaces
    $namespaces = _enumnamespace -session $CS | Sort-Object

    #enumerate namespaces and search for the class
    Write-Verbose "Searching for class $class"
    if ($Exclude) {
        Write-Verbose "Using an exclude pattern of $Exclude"
    }
    $i = 0
    foreach ($ns in $namespaces) {
        $i++
        $pct = ($i / $namespaces.count) * 100
        $progParams.PercentComplete = $pct
        $progParams.Status = "Searching for class $classname in $($namespaces.count) namespaces"
        $progParams.CurrentOperation = "processing \\$($computername.toUpper())\$ns"
        Write-Progress @progparams
        Write-Verbose $ns
        Try {
            $classes = Get-Cimclass -Namespace $ns -ClassName $classname -CimSession $cs -ErrorAction Stop
            if ($classes -AND $Exclude) {
                $classes.Where({$_.cimclassname -notmatch $Exclude }) | Sort-Object -Property CimClassName
            }
            else {
                $classes | Sort-Object -Property CimClassName
            }
        }
        Catch {
            #ignore error if class not found
        }
    } #foreach ns

    Write-Verbose "Removing tempory CIMSession"
    $cs | Remove-CimSession

    Write-Verbose "Ending $($myinvocation.MyCommand)"

} #close function