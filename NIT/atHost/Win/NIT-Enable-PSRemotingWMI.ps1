<#
.SYNOPSIS
    Tis Script will Enable WinRM on Windows Computer
    %COMPUTERNAME0% via WMI
.DESCRIPTION
    Tis Script will Enable WinRM on Windows Computer via WMI
.NOTES
    File name: NIT-Enable-PSRemotingWMI.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-08-15
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-08-15) Script created
    1.0.1 - 
#>

# Name of a Computer is Checked (may be changed)
$COMPUTERNAME0='localhost'

# Get Windows Computer Credentials (May Be Changed)
$myCred = Get-Credential

# Get Session Args

$SessionArgs = @{
#     ComputerName  = 'ServerB'
     ComputerName  = $COMPUTERNAME0
     Credential    = $myCred
     SessionOption = New-CimSessionOption -Protocol Dcom
 }

 # Get MethodArgs

 $MethodArgs = @{
     ClassName     = 'Win32_Process'
     MethodName    = 'Create'
     CimSession    = New-CimSession @SessionArgs
     Arguments     = @{
         CommandLine = "powershell Start-Process powershell -ArgumentList 'Enable-PSRemoting -Force'"
     }
 }

 # Run Payloads

 Invoke-CimMethod @MethodArgs