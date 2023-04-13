###
# This Script Check If Computer 'win.netip4.ru' Needs Restart
# after Windows Updates and Drivers/Programs Installing
##

###
#
# Test-IsWindowsUpdateRebootRequired function
# This Function Check if Windows Computer Needs Reboot
# after Installing Drivers and Windows Updates
#
# Function must Use in other Modules and Standalone Scripts
#
##

function Test-IsWindowsUpdateRebootRequired
{
    Param(
        [Parameter(ValueFromPipeline=$True)]
        [string[]]$ComputerName = 'localhost',
        [switch]$Restart,
        [switch]$YesRestart,
        [switch]$ShowInaccessible
    )

    begin
    {
        $Inaccessible = @()
        $WMI = Get-WmiObject -Class Win32_ComputerSystem
        $Name = $WMI.Name
        $Domain = $WMI.Domain
    }

    process
    {
        foreach ($c in $ComputerName)
        {
            Write-Progress -Activity «Testing computers» -CurrentOperation $c
            
            if(($c -eq 'localhost') -or ($c -eq $Name) -or ($c -eq $($Name, $Domain -join '.')))
            {
                $CBS = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending'
                $WU = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'
            }


            else
            {
                if($sess = New-PSSession -ComputerName $c -ErrorAction SilentlyContinue)
                {
                    $CBS = Invoke-Command -ScriptBlock {Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending'} -Session $sess
                    $WU = Invoke-Command -ScriptBlock {Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'} -Session $sess

                    if($Restart -and $YesRestart -and ($CBS -or $WU))
                    {
                        Invoke-Command -ScriptBlock {Restart-Computer -Force} -Session $sess
                    }
                    
                    Remove-PSSession -Session $sess
                }
                else
                {
                    $Inaccessible += $c
                    continue
                }

            }

            New-Object -TypeName PSCustomObject -Property $([ordered]@{
                ComputerName = $c
                ComponentBasedServicing = $CBS
                WindowsUpdate = $WU
            })
        }
    }


    end
    {
        if($ShowInaccessible)
        {
            foreach($i in $Inaccessible)
            {
                New-Object -TypeName PSCustomObject -Property $([ordered]@{
                ComputerName = $i
                ComponentBasedServicing = 'Inaccessible'
                WindowsUpdate = 'Inaccessible'
                })
            }
        }
    }
}

###
# Start function for computer 'win.netip4.ru'
##
$compname1 = 'win.netip4.ru'

Test-IsWindowsUpdateRebootRequired -ComputerName $compname1
