###########################################################
# w2k22-ato.ps1
# Activation of a Windows Server 2022 Datacenter Rus
###########################################################

# Set a Variables
$aServer='lin.netip4.ru'
$aWinKey='WX4NM-KYWYW-QJJR4-XV3QB-6VM33'

### Derivative Variables
#
$CSCRIPTEXE = Join-Path -Path ${env:SystemRoot} -ChildPath "system32\cscript.exe"
$SLMGRVBS = Join-Path -Path ${env:SystemRoot} -ChildPath "system32\SLMGR.vbs"

### Check Integrity
#
if( -not (Test-Path $CSCRIPTEXE) ) {
    Write-Host "Error: $CSCRIPTEXE is not found"
    Exit 1
}

if( -not (Test-Path $SLMGRVBS) ) {
    Write-Host "Error: $SLMGRVBS is not found"
    Exit 1
}

# Run Payloads
#
& $CSCRIPTEXE //NoLogo $SLMGRVBS /dli
& $CSCRIPTEXE //NoLogo $SLMGRVBS /ipk $aWinKey
& $CSCRIPTEXE //NoLogo $SLMGRVBS /skms $aServer
& $CSCRIPTEXE //NoLogo $SLMGRVBS /ato
& $CSCRIPTEXE //NoLogo $SLMGRVBS /dli

Write-Host "The End of the Script"
Exit 0
