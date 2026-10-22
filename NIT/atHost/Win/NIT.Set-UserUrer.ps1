#Requires -RunAsAdmin

###########################################################
# NIT-Set-UserUser.ps1
###########################################################

# Set Variables
$UserLogin="user"
$UserPass="0A9s8d7F"
$AdminGroup="Администраторы"
$UsersGroup="Пользователи"

$NETEXE = Join-Path -Path $env:SystemRoot -ChildPath "System32\net.exe"

# Run Payloads

& $NETEXE user $UserLogin $UserPass /ADD
& $NETEXE localgroup $AdminGroup $UserLogin /ADD
& $NETEXE localgroup $UsersGroup $UserLogin /DELETE
& $NETEXE user $UserLogin $UserPass
