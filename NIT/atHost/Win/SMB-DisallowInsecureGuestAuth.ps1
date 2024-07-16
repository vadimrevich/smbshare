#####
# SMB-DisallowInsecureGuestAuth.ps1
# Disallow Insecure Connections for SMBv2 and SMBv3 (Default Protection)
#####

### Set a variables

# $MyScript=[Environment]::GetCommandLineArgs()[0]
$MyScript=$MyInvocation.InvocationName

$pathCMD=$env:SystemRoot+"\System32"
$REGEXE=$pathCMD+"\reg.exe"


### Check Integrity

If( !( Test-Path -Path $REGEXE )) {
    Write-Host "$REGEXE is not Found!"
    Exit 1
}

# Run Payload....

& $REGEXE ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 0 /f
& $REGEXE ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v EnablePlainTextPassword /t REG_DWORD /d 0 /f

# End
Write-Host "The End of the Script $MyScript"
Exit 0
