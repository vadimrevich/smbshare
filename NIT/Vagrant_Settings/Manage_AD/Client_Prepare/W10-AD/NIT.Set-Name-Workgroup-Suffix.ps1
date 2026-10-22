#requires -RunAsAdministrator

###########################################################
# NIT.Set-Name-Workgroup-Suffix.ps1
# This Script will Set Compter's Name, Workgroup and Suffix
###########################################################

# Define Local Variables (must be changed)
$main_dns_suffix="yudenisov.internal"
$newcomputername="w10-ad"
$newworkgroup="WORKGROUP"

## Define Local Variables (must not be changed)
$pathcmd=Join-Path -Path $env:SystemRoot -ChildPath "System32"
$regkey01="SearchList"
$regkey02="Domain"
$regnode01="HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$oldcomputername=$env:COMPUTERNAME

$REGEXE = Join-Path -Path $pathcmd -ChildPath "reg.exe"

## run payload

Add-Computer -WorkgroupName $newworkgroup -Force
Rename-Computer -NewName $newcomputername -ComputerName $oldcomputername -Force

& $REGEXE Add $regnode01 /V $regkey01 /D $main_dns_suffix /F
& $REGEXE Add $regnode01 /V $regkey02 /D $main_dns_suffix /F 