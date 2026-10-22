<#
.SYNOPSIS
    This Script will Install and PreAdjust Cygwin Linux Emulator
.DESCRIPTION
    This Script will Install and PreAdjust Cygwin Linux Emulator
    on Windows 10 Local Computer
.NOTES
    File name: NIT.Install-CygWin.amd64.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-10-05
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-10-05) Script created
    1.0.1 - 
#>

### Set Variables

$chocoEXE=Join-Path -Path $env:ChocolateyInstall -ChildPath "bin\choco.exe"
#$cygInstallNameEXE="setup-x86_64.exe"
$cygInstallNameEXE="cygwinsetup.exe"
$cygwinRootPath=Join-Path -Path $env:ChocolateyToolsLocation -ChildPath "CygWin"
$cygInstallEXE=Join-Path -Path $cygwinRootPath -ChildPath $cygInstallNameEXE
$cygTerminal000BAT=Join-Path -Path $cygwinRootPath -ChildPath "CygWin.bat"
$cygBinDir=Join-Path -Path $cygwinRootPath -ChildPath "bin"
$cygBashEXE=Join-Path -Path $cygwinRootPath -ChildPath "bin\bash.exe"
$CurlEXE=Join-Path -Path 'c:\Util' -ChildPath "CURL.EXE"
$cygInstallUri="https://www.cygwin.com/" + $cygInstallNameEXE
$cygWgetEXE=Join-Path -Path $cygBinDir -ChildPath "wget.exe"
$cygInstall00EXE=Join-Path -Path $cygBinDir -ChildPath "install.exe"
$cygMinTTYEXE=Join-Path -Path $cygBinDir -ChildPath "mintty.exe"

### Set Functions

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

### Test Integrity

if( -Not (Test-Path -Path $chocoEXE -PathType Leaf) )
{
    Write-Host "Error! File $chocoEXE is not found!"
    Exit 1
}

if( -Not (Test-Path -Path $CurlEXE -PathType Leaf) )
{
    Write-Host "Error! File $CurlEXE is not found!"
    Exit 1
}

if( -Not (Test-Admin ) ) {
    Write-Host "Error! Script must be run with Elevated privileges"
    Exit 17
}

# Run Payload

if( Test-Path -Path $cygBashEXE -PathType Leaf ) {
    Write-Host "Packet CygWin has been already Installed"
}
else {
    & $chocoEXE install -y --ignore-checksum cygwin
    if( -Not (Test-Path -Path $cygBashEXE -PathType Leaf) ) {
        Write-Host "Packet CygWin has not been Installed"
        Exit 1
    }
}

if( -Not (Test-Path -Path $cygInstallEXE -PathType Leaf) ) {
    & $CurlEXE $cygInstallUri -o $cygInstallEXE
}

& $cygInstallEXE -q -P mc -P git -P lynx -P wget -P curl
& $cygInstallEXE -q -P zip -P unzip -P openssh -P openssl -P vim -P nano -P openssh-client
& $CurlEXE -O https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
& $cygInstall00EXE apt-cyg /bin
ri apt-cyg
# & $cygTerminal000BAT
# & $cygMinTTYEXE -i /Cygwin-Terminal.ico -

### The End
Exit 0
