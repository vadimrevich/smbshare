####
# Get-ComputerDomainWorkgroup.ps1
# This Script will Check if Computer is Member of
# Doman and in what Domain/Workgroup it is Consist
####
(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
(Get-WmiObject Win32_ComputerSystem).domain
