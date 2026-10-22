#Requires -Version 5.1
#Requires -RunASAdministrator

####
# NIT.Add-Firewall.defrev.Rules.ps1
# Add Firewall Rules
####

# Set variables

$NETSHEXE = Join-Path -Path $env:SystemRoot -ChildPath "system32\netsh.exe"
$RuleName = "Set_DefRev_Rules_Out"
$SETPORT = "45454"
$PROPATH01 = "C:\pub1\Distrib\Zlovred\defrevr1234.exe"
$PROPATH02 = "C:\pub1\Distrib\Zlovred\defrevl1234.exe"

# Check Integrity
if( -not (Test-Path -Path $NETSHEXE -PathType Leaf)) {
    Write-Host "$NETSHEXE is not found!"
    Exit 1
}

# Run Payload

& $NETSHEXE advfirewall firewall delete rule name=$RuleName
& $NETSHEXE advfirewall firewall add rule name=$RuleName dir=out action=block protocol=TCP remoteport=$SETPORT enable=yes
& $NETSHEXE advfirewall firewall add rule name=$RuleName dir=out action=allow program=$PROPATH01 enable=yes
& $NETSHEXE advfirewall firewall add rule name=$RuleName dir=out action=allow program=$PROPATH02 enable=yes

# The End
Exit 0
