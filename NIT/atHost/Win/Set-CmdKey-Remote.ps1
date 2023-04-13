###########################################################
# Set-CmdKey-Remote.ps1
# This Script is a Template of Adding Permanently
# Credentials to Remote Computer from Remote Host
#
# Some Parameters must be Edited
###########################################################

#### Specifying some parameters ####
##

# Composing cmdkey parameters
#
# Target (a Second Computer) Name
$target = "win.netip4.ru"

# User Login Name of the Second Computer)
#
$usrName = "WIN\mssqlsr"

# a Password of Second Computer User
#
$usrPwd = "Adin01234"

# Set a Remote Node for CmdKey (Name of First Remote Computer)
$sqlNode    = "w2k22-hv"

# Set a CmdKey User Name (User Login of the First Remote Computer)
$sqlSvc     = "w2k22\Администратор"

# Set a CmdKey Password (User Password of the First Remote Computer)
$sqlSvcPwd  = Read-Host -Prompt "0A9s8d7F" -asSecureString

##
#### The End Specifying parameters ####

$cmdKeyArgs = @()
$cmdKeyArgs += "/add:$($target)"
$cmdKeyArgs += "/user:$($usrName)"
$cmdKeyArgs += "/pass:$($usrPwd)"

# Add SQL service account to remote - this manage the "logon as a batch job" requiment
Invoke-Command -ComputerName $sqlNode `
    -ScriptBlock { 
        Add-LocalGroupMember -Group "Администраторы" `
            -Member $sqlSvc 
    }

# Create a scheduled task action to call the cmdkey command
$sta = New-ScheduledTaskAction "cmdkey" `
            -Argument ($cmdKeyArgs -join " ") `
            -CimSession $cimSession

# Register a scheduled tasks that can be called 
Register-ScheduledTask -TaskName "cmdKeySvcAccnt" `
    -Action $sta `
    -User $sqlSvc `
    -Password $sqlSvcPwd `
    -RunLevel Highest `
    -CimSession $cimSession

# Trigger the execution of the scheduled task
Get-ScheduledTask -TaskName "cmdKeySvcAccnt" -CimSession $cimSession | 
    Start-ScheduledTask

# Clean up the remote environment
Get-ScheduledTask -TaskName "cmdKeySvcAccnt" -CimSession $cimSession | 
    Unregister-ScheduledTask -Confirm:$false

# Delete Specified User from Local Administrator (Be Very Carefully!!!)
# Default is Commented
#   
#Invoke-Command -ComputerName $sqlNode `
#    -ScriptBlock { 
#        Remove-LocalGroupMember -Group "Администраторы" `
#            -Member $sqlSvc 
#    }