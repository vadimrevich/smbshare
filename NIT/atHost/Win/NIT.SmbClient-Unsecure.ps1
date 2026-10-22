#####
# NIT.SmbClient-Unsecure.ps1
# This Script make unsecure Samba Client Connection from Windows 11
# Run only with Elevated Privileges!
#####

Set-SmbClientConfiguration -RequireSecuritySignature $false
Set-SmbClientConfiguration -EnableInsecureGuestLogons $true

### The End ###
