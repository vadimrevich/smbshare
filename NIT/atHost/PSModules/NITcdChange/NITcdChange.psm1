#Requires -Version 2.0
###########################################################
# NITcdChange
# This Module will Contain Functions for Quick
# changing Directory
###########################################################

#### Set Temprorary Functions

<#
 .SYNOPSIS
  Temprorary Function for check if the Folder present

 .DESCRIPTION
  Temprorary Function for check if the Folder present
  Function Returns a $true or a $false

 .PARAMETER Folder
  Full Folder Path for testing

 .EXAMPLE
   # Return $true if Folder Exist
   Check-IfFolderExist -Folder $env:USERPROFILE

 .EXAMPLE
   # Return $true if Folder Exist
   Check-IfFolderExist $env:USERPROFILE

#>

function Check-IfFolderExist {
	param (
		[Parameter(Mandatory=$true,Position=0)]
		[string]$Folder
	)
	$res = Test-Path -Path $Folder -PathType Container
    return $res
}

<#
 .SYNOPSIS
  Function for Change Directory to Desktop\Hidden

 .DESCRIPTION
  Function for Change Directory to Desktop\Hidden
  Function does notreturn anymore
  Tu return at previous folder use Pop-Location

 .EXAMPLE
   # Return $true if Folder Exist
   Cd.Desktop.Hidden

#>

function Cd.Desktop.Hidden {

    #### Set a Variable
    $CMDFOLDER1 = (New-Object -ComObject Shell.Application).NameSpace('shell:Desktop').Self.Path
    $CMDFOLDER = Join-Path -Path $CMDFOLDER1 -ChildPath 'Hidden'

    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

<#
 .SYNOPSIS
  Function for Change Directory to LIBSCRIPT

 .DESCRIPTION
  Function for Change Directory to LIBSCRIPT
  Function does notreturn anymore
  Tu return at previous folder use Pop-Location

 .EXAMPLE
   # Return $true if Folder Exist
   Cd.LIBSCRIPT

#>

function Cd.LIBSCRIPT {

    #### Set a Variable
    $CMDFOLDER="C:\pub1\Distrib\LIBSCRIPT"


    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

<#
 .SYNOPSIS
  Function for Change Directory to UserProfile

 .DESCRIPTION
  Function for Change Directory to UserProfile
  Function does notreturn anymore
  Tu return at previous folder use Pop-Location

 .EXAMPLE
   # Run Function
   Check-IfFolderExist -Folder $env:USERPROFILE

 .EXAMPLE
   # Return $true if Folder Exist
   Cd.UserPr

#>

function Cd.UserPr {

    #### Set a Variable
    $CMDFOLDER=$env:USERPROFILE

    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

<#
 .SYNOPSIS
  Function for Change Directory to Vagrant

 .DESCRIPTION
  Function for Change Directory to Vagrant
  Function does notreturn anymore
  Tu return at previous folder use Pop-Location

 .EXAMPLE
   # Run Function
   Check-IfFolderExist -Folder $env:USERPROFILE

 .EXAMPLE
   # Return $true if Folder Exist
   Cd.Vagrant

#>

function Cd.Vagrant{

    #### Set a Variable
    $CMDFOLDER="D:\yuden\Backup\Laptop\C\Users\vagrant"

    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

<#
 .SYNOPSIS
  Function for Change Directory to smbshare Win

 .DESCRIPTION
  Function for Change Directory to smbshare Win
  Function does notreturn anymore
  Tu return at previous folder use Pop-Location

 .EXAMPLE
   # Run Function
   Check-IfFolderExist -Folder $env:USERPROFILE

 .EXAMPLE
   # Return $true if Folder Exist
   Cd.SMB.Win

#>

function Cd.SMB.Win{

    #### Set a Variable
    $CMDFOLDER="c:\.BIN\smbshare\NIT\atHost\Win\"

    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

#### Set Variables
$atHostWin="c:\.BIN\smbshare\NIT\atHost\Win\"
$aVagrantF="D:\yuden\Backup\Laptop\C\Users\vagrant"
$CDeskF=[Environment]::GetFolderPath("CommonDesktopDirectory")

function Cd.CDeskF {

    #### Set a Variable
    $CMDFOLDER=$CDeskF

    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

$CProgsF=[Environment]::GetFolderPath("CommonPrograms")

function Cd.CProgsF {

    #### Set a Variable
    $CMDFOLDER=$CProgsF

    #### Run Payload
    #
    if( Check-IfFolderExist -Folder $CMDFOLDER ) {
        Push-Location -Path $CMDFOLDER
    }
}

$DnldF=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$DocF=(New-Object -ComObject Shell.Application).NameSpace('shell:Personal').Self.Path
$DeskF=(New-Object -ComObject Shell.Application).NameSpace('shell:Desktop').Self.Path

### Export Module Members

Export-ModuleMember -Function Check-IfFolderExist
Export-ModuleMember -Function Cd.Desktop.Hidden
Export-ModuleMember -Function Cd.LIBSCRIPT
Export-ModuleMember -Function Cd.UserPr
Export-ModuleMember -Function Cd.Vagrant
Export-ModuleMember -Function Cd.SMB.Win
Export-ModuleMember -Function Cd.CDeskF
Export-ModuleMember -Function Cd.CProgsF
Export-ModuleMember -Variable atHostWin, aVagrantF, CDeskF,DnldF, DnldF, DocF, DeskF, CProgsF
