#Requires -Version 2
#Requires -RunAsAdmin

<#
.SYNOPSIS
    This Script will Restrict to Stop and Restart Computer with GUI
.DESCRIPTION
    This Script will Restrict to Stop and Restart Computer with GUI
.NOTES
    File name: NIT.Set-NoClose.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2026-04-19
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2026-04-19) Script created
    1.0.1 - 
#>

### Set Variables

$REGEXE = Join-Path -Path $env:SystemRoot -ChildPath "System32\reg.exe"

# Run Payloads

### Deny Shutdown and Restart Options
& $REGEXE add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d "145" /f
& $REGEXE add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoClose" /t REG_DWORD /d "1" /f
& $REGEXE add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "shutdownwithoutlogon" /t REG_DWORD /d "0" /f

# Restore ShutDown and Restart Options
# & $REGEXE add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d "145" /f
# & $REGEXE delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoClose" /f
# & $REGEXE add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "shutdownwithoutlogon" /t REG_DWORD /d "1" /f

