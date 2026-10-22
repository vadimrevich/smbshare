#Requires -Version 5.1

#####
# NIT.Get-VCRedist.ps1
# This Script will get Visual Studio C++ Redistributible Versions
# on Microsoft Windows server operation systems
#
#####

#### Set Variables ####

#### Run Payloads ####

### Warning! VcRedist Module must be Install!

# Install-Module -Name VcRedist

Get-InstalledVcRedist -ExportAll | Select Name, Version, Release, Architecture | Sort-Object -Property Architecture, Release
