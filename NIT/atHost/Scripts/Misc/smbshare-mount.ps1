# *******************************************************
# smbshare-mount.ps1
# This Script Mounts X: a Drive with \\WIN\smbshare and
# Copies it at a Local System
# *******************************************************

$SMBSHARE="smbshare"
$WINUNC="WIN.netip4.ru"
$WINUSER="WIN\MSSQLSR"
$WINPASS="Admin01234"
$WINSMBSHARE0="smbshare0"

&md C:\.BIN
&md C:\.BIN\$SMBSHARE
# cd C:\.BIN\$SMBSHARE
&net.exe USE /PERSISTENT:No
## &cmdkey.exe /ADD:$WINUNC /USER:$WINUSER /PASS:$WINPASS
&net.exe USE X: \\$WINUNC\$SMBSHARE $WINPASS /USER:$WINUSER
&xcopy.exe x:\*.* C:\.BIN\$SMBSHARE\ /S /E /V
&net.exe USE X: /DELETE
&net.exe SHARE smbshare0=C:\.BIN\smbshare /UNLIMITED /CACHE:none /grant:Все,full /grant:Администратор,full
iex .\Set-ScriptAcl-003.ps1
## &net.exe SHARE smbshare0 \\localhost /Delete
