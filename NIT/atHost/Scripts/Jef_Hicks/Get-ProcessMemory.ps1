Function Get-ProcessMemory {
<#
.SYNOPSIS
Get a snapshot of a process' memory usage.
.DESCRIPTION
Get a snapshot of a process' memory usage based on its workingset value. You can get the same information using Get-Process or by querying the Win32_Process WMI class with Get-CimInstance. This command uses Invoke-Command to gather the information remotely. Many of the parameters are from that cmdlet.

.EXAMPLE
PS C:\> get-processmemory code,powershell*

Name                   Count Threads      AvgMB      SumMB      Computername
----                   ----- -------      -----      -----      ------------
Code                       9     154   112.8199  1015.3789         BOVINE320
powershell                 3      77   179.1367   537.4102         BOVINE320
powershell_ise             1      21   242.0586   242.0586         BOVINE320


The default output displays the process name, the total process count, the total number of threads, the average workingset value per process in MB and the total workingset size of all processes also formatted in MB.
.EXAMPLE
PS C:\> get-processmemory -computername srv1,srv2,dom1 -Name lsass -cred company\artd

Name                   Count Threads      AvgMB      SumMB     Computername
----                   ----- -------      -----      -----     ------------
lsass                      1      30    60.1719    60.1719             DOM1
lsass                      1       7    10.8594    10.8594             SRV1
lsass                      1       7     9.6953     9.6953             SRV2
.EXAMPLE
PS C:\> get-processmemory *ActiveDirectory* -Computername dom1 | select-object *

Name         : Microsoft.ActiveDirectory.WebServices
Count        : 1
Threads      : 10
Average      : 46940160
Sum          : 46940160
Computername : DOM1

This example uses a wildcard for the process name because the domain controller only has one related process. The output shows the raw values.
.EXAMPLE
PS C:\> get-processmemory *edge*,firefox,chrome | sort sum -Descending

Name                   Count Threads      AvgMB      SumMB     Computername
----                   ----- -------      -----      -----     ------------
firefox                    6     189   180.4134  1082.4805        BOVINE320
chrome                     8     124    67.1377   537.1016        BOVINE320
MicrosoftEdgeCP            4     171    66.1846   264.7383        BOVINE320
MicrosoftEdge              1      37    70.1367    70.1367        BOVINE320
MicrosoftEdgeSH            1      10     8.2734     8.2734        BOVINE320

Get browser processes and sort on the underlying SUM property in descending order.
.NOTES
    Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/
.LINK
Get-Process
Invoke-Command
.INPUTS
[string[]]
#>

    [CmdletBinding()]
    [OutputType("myProcessMemory")]

    Param
    (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [string[]]$Name,
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername = $env:COMPUTERNAME,
        [PSCredential]$Credential,
        [switch]$UseSSL,
        [Int32]$ThrottleLimit,
        [ValidateSet('Default', 'Basic', 'Credssp', 'Digest', 'Kerberos', 'Negotiate', 'NegotiateWithImplicitCredential')]
        [ValidateNotNullorEmpty()]
        [string]$Authentication = "default"
    )

    Begin {

        Write-Verbose "Starting $($MyInvocation.Mycommand)"

        $sb = {
            Param([string[]]$ProcessName)

            # a process might have multiple instances so get each one by name
            #group the processes to accomodate the use of wildcards
            $data = Get-Process -Name $ProcessName | Group-Object -Property Name
            foreach ($item in $data) {
                $item.group | Measure-Object -Property WorkingSet -Sum -Average |
                    Select-Object -Property @{Name = "Name"; Expression = {$item.name}},
                Count,
                @{Name = "Threads"; Expression = {$item.group.threads.count}},
                Average, Sum,
                @{Name = "Computername"; Expression = {$env:computername}}
            }
        } #close ScriptBlock

        #update PSBoundparamters so it can be splatted to Invoke-Command
        $PSBoundParameters.Add("ScriptBlock", $sb) | Out-Null
        $PSBoundParameters.add("HideComputername", $True) | Out-Null

    } #begin

    Process {

        $PSBoundParameters.Remove("Name") | Out-Null
        Write-Verbose "Querying processes $($name -join ',') on $($Computername -join ',')"

        #need to make sure argument is treated as an array
        $PSBoundParameters.ArgumentList = , @($Name)
        if (-Not $PSBoundParameters.ContainsKey("Computername")) {
            #add the default value if nothing was specified
            $PSBoundParameters.Add("Computername", $Computername) | Out-Null
        }
        $PSBoundParameters | Out-String | Write-Verbose

        Invoke-Command @PSBoundParameters | Select-Object -Property * -ExcludeProperty RunspaceID, PS* |
            ForEach-Object {
            #insert a custom type name for the format directive
            $_.psobject.typenames.insert(0, "myProcessMemory") | Out-Null
            $_
        }

    } #process

    End {

        Write-Verbose "Ending $($MyInvocation.Mycommand)"

    } #end

} #close function

#region formatting directives for the custom object
[xml]$format = @'
<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
    <ViewDefinitions>
        <View>
            <Name>default</Name>
            <ViewSelectedBy>
                <TypeName>myProcessMemory</TypeName>
            </ViewSelectedBy>
            <TableControl>
            <!-- ################ TABLE DEFINITIONS ################ -->
                <TableHeaders>
                    <TableColumnHeader>
                        <Label>Name</Label>
                        <Width>20</Width>
                        <Alignment>left</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>Count</Label>
                        <Width>7</Width>
                        <Alignment>right</Alignment>
                    </TableColumnHeader>
                     <TableColumnHeader>
                        <Label>Threads</Label>
                        <Width>7</Width>
                        <Alignment>right</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>AvgMB</Label>
                        <Width>10</Width>
                        <Alignment>right</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>SumMB</Label>
                        <Width>10</Width>
                        <Alignment>right</Alignment>
                    </TableColumnHeader>
                    <TableColumnHeader>
                        <Label>Computername</Label>
                        <Width>16</Width>
                        <Alignment>right</Alignment>
                    </TableColumnHeader>
                 </TableHeaders>
                <TableRowEntries>
                    <TableRowEntry>
                        <TableColumnItems>
                            <TableColumnItem>
                                <PropertyName>Name</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Count</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Threads</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>[math]::Round($_.average/1MB,4)</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>[math]::Round($_.sum/1MB,4)</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Computername</PropertyName>
                            </TableColumnItem>
                        </TableColumnItems>
                    </TableRowEntry>
                </TableRowEntries>
            </TableControl>
        </View>
    </ViewDefinitions>
</Configuration>
'@

$format.Save("$env:temp\myProcessMemory.format.ps1xml")

Update-FormatData -AppendPath $env:temp\myProcessMemory.format.ps1xml

#endregion