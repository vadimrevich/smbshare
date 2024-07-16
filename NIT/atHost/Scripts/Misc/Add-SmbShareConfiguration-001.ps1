###
# Add-SmbShareConfiguration-001.ps1
# This Script Add a smbshare Configuration from
# WIN.netip4.ru Server
# This Redaction is a Test and will not Work
###

# Specifying some parameters
$aDomainName   = "WIN.netip4.ru"
$aUserLogin    = "MSSQLSR"
$aUserDomain   = "WIN"
$aUserPasswd   = "Admin01234"
$aShareName    = "smbshare"
$aTargetNode   = "192.168.252.48"
$aTargetUser   = "win2k8r2\vagrant"
# $aTargetPasswd = Read-Host -Prompt "vagrant password" -asSecureString
$aTargetPlain  = "vagrant"

# Set Credentials
$aTargetPasswd = $aTargetPlain | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential `
     -ArgumentList $aTargetUser, $aTargetPasswd

# Open a cim session on the target remote node
$cimSession = New-CimSession -ComputerName $aTargetNode -Credential $Credentials

# Composing cmdkey parameters
$target = $aDomainName
$usrName = "$aUserDomain\$aUserLogin"
$usrPwd = $aUserPasswd

$cmdKeyArgs = @()
$cmdKeyArgs += "/add:$($target)"
$cmdKeyArgs += "/user:$($usrName)"
$cmdKeyArgs += "/pass:$($usrPwd)"

# Add SQL service account to remote - this manage the "logon as a batch job" requiment
Invoke-Command -ComputerName $aTargetNode `
    -Credential $Credentials `
    -ScriptBlock { 
        Add-LocalGroupMember -Group "Administrators" `
            -Member $aTargetUser 
    }

# Create a scheduled task action to call the cmdkey command
$sta = New-ScheduledTaskAction "cmdkey" `
            -Argument ($cmdKeyArgs -join " ") `
            -CimSession $cimSession

# Register a scheduled tasks that can be called 
Register-ScheduledTask -TaskName "cmdKeySvcAccnt" `
    -Action $sta `
    -User $aTargetUser `
    -Password $aTargetPasswd `
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
#Invoke-Command -ComputerName $aTargetNode `
#    -Credential $Credentials `
#    -ScriptBlock { 
#        Remove-LocalGroupMember -Group "Administrators" `
#            -Member $aTargetUser 
@    }