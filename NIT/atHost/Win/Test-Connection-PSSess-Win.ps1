<#
.SYNOPSIS
    This Script will Connect to Windows Computer
    with PowerShell PSSession via Transport WinRM
.DESCRIPTION
    This Script will Connect to Windows Computer
.NOTES
    File name: Test-Connection-PSSess-Win.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-02-20
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-02-20) Script created
    1.0.1 - 
#>

### set a variables
#
$VMNAME="win.netip4.ru"
$VM_USER="vagrant"
$VM_PASS="0a9s8d7F"
$VM_SSHPORT="22"
$VM_WINRMPORT="5985"
$VM_COMMAND="cmd.exe"

### Derivative Variables
#
$Sec_VMPASS=ConvertTo-SecureString -AsPlainText $VM_PASS -Force
$VM_Cred=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $VM_USER,$Sec_VMPASS

### Test Ping Connection
#
$pingtest = Test-Connection -ComputerName $VMNAME -Quiet -Count 1 -ErrorAction SilentlyContinue
if($pingtest){
    Write-Host($VMNAME + " is online")
    $pingport = Test-NetConnection -ComputerName $VMNAME -Port $VM_WINRMPORT -ErrorAction SilentlyContinue
    if($pingport){
        Write-Host( "The Port " +$VM_WINRMPORT+" is open" )
        # $vmsess = New-PSSession -ComputerName $VMNAME -Port $VM_WINRMPORT -Credential $VM_Cred -Authentication Negotiate
        Exit 0
    }
    else {
        Write-Host( "The Port "+$VM_WINRMPORT+" is not reacable")
        Exit 2
    }
}
else{
    Write-Host($VMNAME + " is not reachable")
    Exit 2
}
     
