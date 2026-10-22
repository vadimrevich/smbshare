#Requires -Version 5.1
#Requires -RunAsAdministrator
###########################################################
# config.machine.ps1
# This file contains settings and metadata for
# Hyper-V Virtual Nachine
###########################################################
#### Set VM Name
$MetaVMName="w10-pro3"

#### Set Variables

### Users
$User_user = "user"
$User_MSSQLSR = "MSSQLSR"
$UserCheck=$User_user

# Passwords
$PlPass_Admin = "0A9s8d7F"
$PlPass_MSSQLSR = "Admin01234"
$PassCheck = $PlPass_Admin

# Credential
$CredCheck = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserCheck, $(ConvertTo-SecureString -AsPlainText $PassCheck -Force)


### Set Function

<#
 .SYNOPSIS
  Functions Check if VM Present at localhost Hyper-V

 .DESCRIPTION
  Functions Check if VM Present at localhost Hyper-V
  Function Return $null if Virtual Machine is absent

 .PARAMETER VMMeta
  Initial proposal of the Hyper-V VM Name

 .EXAMPLE
   # Return Same "w10-pro3" or $null if not Found
   Check-IsVMName-Valid -VMMeta "w10-pro3"

 .EXAMPLE
#>

function Check-IsVMNameValid {
    param (
        [string]$VMMeta
    )

    $a = $null
    $anObj = Get-VM -Name $VMMeta
    if( $anObj -eq $null ){
        $a = $null
    }
    else {
        $a = $VMMeta
    }
    # Write-Host "$$a = $a"
    return $a
}

<#
 .SYNOPSIS
  Functions Get VM NetInfo at localhost Hyper-V

 .DESCRIPTION
  Functions Get VM NetInfo at localhost Hyper-V
  Check Hyper-V Netwirk Adapter

 .PARAMETER VMName
  Name of the Virtual Machinw

 .EXAMPLE
   # Return "w10-pro3" VM Name, MAC Address, Switchname and Ip Addresses
   Get-VMNetInfo -VMName "w10-pro3"

 .EXAMPLE
#>

function Get-VMNetInfo {
    param (
        [string]$VMName
    )
    return Get-VM -Name $VMName | select -ExpandProperty networkadapters | select vmname, macaddress, name, switchname, ipaddresses
}

<#
 .SYNOPSIS
  Functions Get VM Internal IPv4 Address at localhost Hyper-V

 .DESCRIPTION
  Functions Get VM Internal IPv4 Address at localhost Hyper-V
  Check Hyper-V Netwirk Adapter
  The Virtual Machine must be started

 .PARAMETER VMName
  Name of the Virtual Machinw

 .EXAMPLE
   # Return "w10-pro3" Internal Ip Addresses
   Get-VMNetIP4 -VMName "w10-pro3"

 #>

function Get-VMNetIP4 {
    param (
        [string]$VMName
    )
    return (Get-VMNetInfo -VMName $VMName).IPAddresses.Item(0)
}

<#
 .SYNOPSIS
  Functions Get External IPv4 Address at local network

 .DESCRIPTION
  Functions Get External IPv4 Address at local network
  Check Hyper-V Netwirk Adapter

 .EXAMPLE
   # Return an external Ip Addresses or $null
   Get-ExternalIP

#>

function Get-ExternalIP {
    return (Invoke-WebRequest ifconfig.me/ip -UseBasicParsing).Content.Trim()
}

function Get-ComputerNameByIPAddr {
    param (
    [Parameter(Mandatory=$false, Position=0)]
    [string]$IPAddr="",
    [Parameter(Mandatory=$false, Position=1)]
    [PSCredential]$Credential=$null
    )
    if($IPAddr -eq "") {
        $NetName=[System.Net.Dns]::GetHostByAddress("127.0.0.1").Hostname.Trim()
        if($NetName -eq $null) {
            $NetName = ""
        }
        $WMIName=(Get-WmiObject Win32_ComputerSystem).Name.Trim()
        if($WMIName -eq $null) {
            $WMIName=""
        }
    }
    else {
        if($Credential -eq $null) {
            $NetName=[System.Net.Dns]::GetHostByAddress($IPAddr).Hostname.Trim()
            if($NetName -eq $null) {
                $NetName = ""
            }
            $WMIName=(Get-WmiObject Win32_ComputerSystem -ComputerName $IPAddr).Name.Trim()
            if($WMIName -eq $null) {
                $WMIName=""
            }
        }
        else {
            $NetName=[System.Net.Dns]::GetHostByAddress($IPAddr).Hostname.Trim()
            if($NetName -eq $null) {
                $NetName = ""
            }
            $WMIName=(Get-WmiObject Win32_ComputerSystem -ComputerName $IPAddr -Credential $Credential).Name.Trim()
            if($WMIName -eq $null) {
                $WMIName=""
            }
        }
    }
    $obg=[PSCustomObject]@{ 
        NetName = $NetName 
        WMIName = $WMIName
    }
    return $obg
}

# Run Payloads

$VMNameCheck=Check-IsVMNameValid -VMMeta $MetaVMName


if( $VMNameCheck -eq $null ){
    Write-Host "Hyper-V Virtual machine $MetaVMName is not found"
    Exit 1
}

Export-ModuleMember -Function Check-IsVMNameValid
Export-ModuleMember -Function Get-VMNetInfo
Export-ModuleMember -Function Get-VMNetIP4
Export-ModuleMember -Function Get-ExternalIP
Export-ModuleMember -Function Get-ComputerNameByIPAddr
Export-ModuleMember -Variable VMNameCheck, UserCheck, PassCheck, CredCheck
