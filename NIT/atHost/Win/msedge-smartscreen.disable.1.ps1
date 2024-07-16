#####
# msedge-smartscreen.disable.ps1
# Disable Microsoft SmartScreen at Microsoft Edge
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

& $REGEXE ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f
& $REGEXE ADD "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f
& $REGEXE ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f

# End
Write-Host "The End of the Script $MyScript"
Exit 0
