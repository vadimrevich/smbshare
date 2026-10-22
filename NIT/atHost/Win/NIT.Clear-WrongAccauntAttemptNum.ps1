#Requires -Version 2
#Requires -RunAsAdmin
<#
.SYNOPSIS
    This Script will Clear Defence from Wrong Account Attempts
.DESCRIPTION
    This Script will Clear Defence from Wrong Account Attempts
.NOTES
    File name: NIT.Clear-WrongAccauntAttemptNum.ps1
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

$NETEXE = Join-Path -Path $env:SystemRoot -ChildPath "System32\net.exe"

$UserLockout=10
$SystemLockuot=30
$UserDuration=10
$SystemDuration=30
$UserAttempts=10
$SystemAttempts=3
$CurrentAttepts=0

# Run Payloads

# Clear Attempts
& $NETEXE accounts /lockoutthreshold:$CurrentAttepts
& $NETEXE accounts /lockoutduration:$UserDuration
& $NETEXE accounts /lockoutwindow:$UserLockout

# Reset Default Attempts
# & $NETEXE accounts /lockoutthreshold:$UserAttempts

## Reset System Attempts
# & $NETEXE accounts /lockoutthreshold:$SystemAttempts
# & $NETEXE accounts /lockoutduration:$SystemDuration
# & $NETEXE accounts /lockoutwindow:$SystemLockuot
