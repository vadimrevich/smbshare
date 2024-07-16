#####
# msedge-smartscreen.disable.ps1
# Disable Microsoft SmartScreen at Microsoft Edge
#####

### Set a variables

# $MyScript=[Environment]::GetCommandLineArgs()[0]
$MyScript=$MyInvocation.InvocationName

$pathCMD=$env:SystemRoot+"\System32"
$REGEXE=$pathCMD+"\reg.exe"
$HKEYPATH="HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$HKEYNAME="EnabledV9"
$HKEYVALUE=0
$HKEYTYPE="REG_DWORD"
$HKEYPATH1="HKLM\SOFTWARE\Policies\Microsoft\Edge\Recommended"
$HKEYNAME1="SmartScreenEnabled"
$HKEYNAME1_1="SmartScreenPuaEnabled"
$HKEYVALUE1=0
$HKEYTYPE1="REG_DWORD"


### Check Integrity

If( !( Test-Path -Path $REGEXE )) {
    Write-Host "$REGEXE is not Found!"
    Exit 1
}

& $REGEXE ADD $HKEYPATH /v $HKEYNAME /t $HKEYTYPE /d $HKEYVALUE /f
& $REGEXE ADD $HKEYPATH1 /f
& $REGEXE ADD $HKEYPATH1 /v $HKEYNAME1 /t $HKEYTYPE1 /d $HKEYVALUE1 /f
& $REGEXE ADD $HKEYPATH1 /v $HKEYNAME1_1 /t $HKEYTYPE1 /d $HKEYVALUE1 /f

# End
Write-Host "The End of the Script $MyScript"
Exit 0
