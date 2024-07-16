#####
# NIT-MsSettings.WindowsUpdate.ps1
# Open WindowsUpdate Settings
#####

### Set a variables

# $MyScript=[Environment]::GetCommandLineArgs()[0]
$MyScript=$MyInvocation.InvocationName

$pathCMD=$env:SystemRoot+"\System32"
$EXPLOREREXE=$env:SystemRoot+"\explorer.exe"


### Check Integrity

If( !( Test-Path -Path $EXPLOREREXE )) {
    Write-Host "$EXPLOREREXE is not Found!"
    Exit 1
}

# Run Payload....

& $EXPLOREREXE ms-settings:windowsupdate

# End
Write-Host "The End of the Script $MyScript"
Exit 0
