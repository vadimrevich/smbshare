###########################################################
# w2k12-ato.ps1
# Activation of a Windows Server 2012 Datacenter Rus
###########################################################

# Set a Variables
$aServer='lin.netip4.ru'
$aWinKey='W3GGN-FT8W3-Y4M27-J84CP-Q3VJ9'

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
