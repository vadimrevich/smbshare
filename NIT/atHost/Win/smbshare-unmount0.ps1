# *******************************************************
# smbshare-unmount0.ps1
# This Script Deletes local share smbmount0 and
# all Local Files on It
# *******************************************************

$SMBSHARE="smbshare"
$WINSMBSHARE0="smbshare0"

Remove-SmbShare -Name $WINSMBSHARE0  -Confirm:$false
Remove-Item -Path C:\.BIN\$SMBSHARE -Recurse -Force -Confirm:$false

