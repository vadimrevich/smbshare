#requires -version 5.1
#this requires a windows platform

<#
This prompt function lets you see the results of your last command and then clears the screen.
The end result is that you run a single command at a time.
You can modify the value of the global variable PromptClear to toggle this feature.
#>
$global:PromptClear = $true

Function prompt {
  
    if ($global:PromptClear) {
        Pause
        Clear-Host
    }

    $charHash = @{
        Up          = [char]0x25b2
        Down        = [char]0x25bc 
        Delta       = [char]0x2206 
        Pointer     = [char]0x25BA
        TopLeft     = [char]0x250c
        TopRight    = [char]0x2510
        Border      = [char]0x2500
        BottomLeft  = [char]0x2514
        BottomRight = [char]0x2518
        Ohm         = [char]0x2126
        Mu          = [char]0x3bc
        disk        = [char]0x058d
        bps         = [char]0x20bf
    }

    Try {
        #verify there is a global hashtable variable
        Get-Variable -Name rsHash -Scope global -ErrorAction Stop | Out-Null
    }
    Catch {
        #create the runspace and synchronized hashtable
        $global:rsHash = [hashtable]::Synchronized(@{Computername = $env:computername; results = ""; date = (Get-Date); computers = @()})
        $newRunspace = [runspacefactory]::CreateRunspace()
        #set apartment state if available
        if ($newRunspace.ApartmentState) {
            $newRunspace.ApartmentState = "STA"
        }
        $newRunspace.ThreadOptions = "ReuseThread"         
        $newRunspace.Open()
        $newRunspace.SessionStateProxy.SetVariable("rsHash", $rsHash)  

        $pscmd = [PowerShell]::Create().AddScript( {                      
            
                #define the path to the list of computers
                $script:listPath = "C:\scripts\watch.txt"
            
                #define scriptblock to run remotely
                $sb = {
                
                    #define a list of performance counters    
                    $c = "\processor(_total)\% processor time",
                    "\physicaldisk(_total)\% disk time",
                    "\server\bytes total/sec",
                    "\system\file control operations/sec" 

                    Try {        
                        $mem = Get-CimInstance -ClassName win32_operatingsystem -Property TotalVisibleMemorySize, FreePhysicalMemory -ErrorAction Stop -OperationTimeoutSec 2
                        $memUsage = ($mem.FreePhysicalMemory / $mem.TotalVisibleMemorySize) * 100 -as [int]
                        $disk = Get-CimInstance -Classname win32_logicaldisk -filter "deviceID = 'c:'" -Property DeviceID, Size, FreeSpace -ErrorAction Stop -OperationTimeoutSec 2
                        $diskFree = ($disk.FreeSpace / $disk.Size) * 100 -as [int]
                        #get a count of all processes except idle and system and subtract 1 for the remote connection
                        $proc = (Get-Process).Where( {$_.name -notmatch 'Idle|system'}).count - 1
                        $os = Get-CimInstance -ClassName win32_operatingsystem -Property lastbootupTime
                        $isUp = $True

                        #create a hashtable of counters and values
                        get-counter -Counter $c | select-object -ExpandProperty countersamples |
                            foreach-object -Begin {$counterhash = @{}} -process {
                            $counterHash.add($_.Path.split("\\")[-1], [math]::round($_.CookedValue, 2))
                        }
                    }
                    catch {
                        #this will probably never be used
                        $memUsage = 0
                        $diskFree = 0
                        $isUp = $False
                        Processes = 0
                        OS = "" 
                        Counters - @{}
                    }
                    [pscustomobject]@{
                        Computername = $env:computername
                        MemoryUsage  = $memUsage
                        DiskFree     = $diskFree
                        Processes    = $proc
                        IsUp         = $IsUp
                        Uptime       = ((Get-Date) - $os.LastBootUpTime).toString("d\.hh\:mm\:ss")
                        Counters     = $counterhash
                    }
                } #end scriptblock
                
                #define a pssession option to speed up connections
                $opt = New-PSSessionOption -OpenTimeout 1000 -MaxConnectionRetryCount 1

                do {
                    #define the list of computers to test
                    #filter out blank lines and trim any spaces to clean up names.
                    #This should be a short list unless you increase the width of your console sessions
                    if (Test-Path -path $script:listPath ) {
                           $computers = Get-Content -Path $script:listpath |
                            Where-Object {$_ -match '\w+' -AND $_ -notmatch "#"} | Foreach-Object {$_.trim()} | Sort-Object
                    }
                    else {
                        #if path not found default to local computer
                        $computers = $env:computername
                    }

                    #make sure there are sessions for all computers in the list
                    $computers | Where-Object {(get-pssession).where( {$_.state -eq 'opened'}).computername -notcontains $_} |
                        ForEach-Object {
                        New-PSSession -ComputerName $_ -SessionOption $opt
                    }
                    #remove broken sessions
                    Get-PSSession | Where-Object {$_.state -eq 'broken'} | Remove-PSSession
                    $results = Invoke-Command -ScriptBlock $sb -HideComputerName  -Session (Get-PSSession) 

                    $global:rsHash.results = $results
                    $global:rsHash.date = Get-Date
                    $global:rshash.computers = $computers
                    #set a sleep interval between tests
                    Start-Sleep -Seconds 10
                } While ($True)
            }) # script
        $pscmd.runspace = $newrunspace
        [void]$psCmd.BeginInvoke()
    } #catch

    #guess at a line length

    # get longest name so shorter names can be padded
    $longest = ($global:rshash.computers |  sort-object length -Descending | select-object -first 1).length
    
    #account for a : after each name + character + value
    #you may have to tweak this value to get everything to line up
    #and it might depend on whether you are using the console or ISE
    $len = $longest + 75

    #display local computername and datetime
    $dt = "`n {2} {0} {1} " -f (get-date).toshortdatestring(), (get-date).TolongTimeString(), $env:computername
    Write-host $dt -ForegroundColor black -BackgroundColor gray
    
    Write-Host "$($charhash.topleft)" -NoNewline
    Write-Host ($($charHash.Border.ToString()) * $len ) -NoNewline
    Write-Host $charHash.topRight

    if ($global:rsHash.results) {
    
        #create a hashtable from the results
        $h = $global:rshash.results | Group-Object -Property Computername -AsHashTable -AsString

        #sort the results by computername
        foreach ($item in $global:rshash.computers) {

            if ($h[$item]) {
                $obj = $h[$item]
            }
            else {
                #create a temporary object for computer that is not running but in the list
                $obj = [pscustomobject]@{
                    Computername = $item.ToUpper()
                    Uptime       = (New-TimeSpan).toString()
                    DiskFree     = "00"
                    MemoryUsage  = "00"
                    Processes    = "00"
                    IsUp         = $false
                }
            }

            Write-Host " $($charhash.pointer) $(($obj.computername).padright($longest,' '))" -NoNewline            

            #only display results if computer is up
            
            if ($obj.IsUp) {
                Write-Host " $($charHash.Up)" -ForegroundColor green -NoNewline
                $upfg = "green"
            }
            else {
                Write-Host " $($charHash.down)" -ForegroundColor red -NoNewline
                $upfg = "red"
            }               
            
            if ($obj.IsUp) {
                if ($obj.DiskFree -le 20) {
                    $diskfg = "red"
                }
                elseif ($obj.DiskFree -le 75) {
                    $diskfg = "yellow"
                }
                else {
                    $diskfg = "green"
                }
                if ($obj.MemoryUsage -le 30) {
                    $memfg = "red"
                }
                elseif ($obj.MemoryUsage -le 60) {
                    $memfg = "yellow"
                }
                else {
                    $memfg = "green"
                }
                #format counter data
                $pctDiskTime = ("{0:N2}" -f $obj.counters.'% disk time').PadLeft(6, " ")
                $fileControl = ($obj.counters.'file control operations/sec').ToString().Padleft(9, " ")
                $pctProcTime = ("{0:N2}" -f $obj.counters.'% processor time').Padleft(6, " ")

                Write-Host $obj.Uptime.padleft(12,' ') -ForegroundColor $upfg -NoNewline
                Write-Host " $($charhash.disk)$(($obj.diskfree).toString().padleft(3,' '))%" -NoNewline -ForegroundColor $diskfg
                write-host " $($charHash.delta) $pctDiskTime" -NoNewline
                write-host " fc$filecontrol" -NoNewline
                write-host " $($charhash.ohm)$pctProcTime" -NoNewline
                Write-Host " $($charhash.mu)$($obj.MemoryUsage)%"-NoNewline -ForegroundColor $memfg 
                Write-Host " p$(($obj.Processes).tostring().padright(4,' '))"  -NoNewline
                write-host " $($charhash.bps) $($obj.counters.'bytes total/sec')"
            }
            else {
                write-host " "
            }
        } #foreach
    }
    else {
        Write-Host "Working..." -ForegroundColor yellow 
    }

    Write-Host $charHash.BottomLeft -NoNewline
    Write-Host ($($charHash.Border.ToString()) * $len ) -NoNewline
    Write-Host $charHash.BottomRight

    "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "

}
prompt
