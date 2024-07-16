
#requires -version 5.1
Function Test-IsWindowsTerminal {
    [cmdletbinding()]
    [Outputtype([Boolean])]

    Param()

    Write-Verbose "Testing processid $pid"

    if ($PSVersionTable.PSVersion.major -ge 6) {
        #PowerShell Core has a Parent property for process objects
        Write-Verbose "Using Get-Process"
        $parent = (Get-Process -id $pid).Parent
        Write-Verbose "Parent process ID is $($parent.id) ($($parent.processname))"
        if ($parent.ProcessName -eq "WindowsTerminal") {
            $True
        }
        Else {
            #check the grandparent process
            $grandparent = (Get-Process -id $parent.id).parent
            Write-Verbose "Grandarent process ID is $($grandparent.id) ($($grandparent.processname))"
            if ($grandparent.processname -eq "WindowsTerminal") {
                $True
            }
            else {
                $False
            }
        }
    } #if Core or later
    else {
        #PowerShell 5.1 needs to use Get-CimInstance
        Write-Verbose "Using Get-CimInstance"

        $current = Get-CimInstance -ClassName win32_process -filter "processid=$pid"
        $parent = Get-Process -id $current.parentprocessID
        Write-Verbose "Parent process ID is $($parent.id) ($($parent.processname))"
        if ($parent.ProcessName -eq "WindowsTerminal") {
            $True
        }
        Else {
            #check the grandparent process
            $cimGrandparent = Get-CimInstance -classname win32_process -filter "Processid=$($parent.id)"
            $grandparent = Get-Process -id $cimGrandparent.parentProcessId
            Write-Verbose "Grandarent process ID is $($grandparent.id) ($($grandparent.processname))"
            if ($grandparent.processname -eq "WindowsTerminal") {
                $True
            }
            else {
                $False
            }
        }
    } #PowerShell 5.1
} #close function

Test-IsWindowsTerminal
