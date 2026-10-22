###########################################################
# Load-NIT.Win.Adjust.ps1
# This Script will Load Adjusting Scripts
# For Windows Core Server Computers
###########################################################


### Set Variables
#

# Set Powershell File
$aFile00 = 'nit.main.windows.adjust.00.exe'
$aFile01 = 'nit.main.windows.adjust.01.exe'
$aFile02 = 'nit.main.windows.adjust.02.exe'
$aFile03 = 'nit.main.windows.adjust.03.exe'
$aPureURL = 'http://lin.netip4.ru:18080/~vagrant/PROGS/LIB-RUN/PS1/'

### Set Functions
#

Function Check-DownloadShellFolder() {
    try {
        $DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    }
    catch {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "Download Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}


Function Check-MyDocumentsShellFolder() {
    try {
        $DownloadShellFolder=Get-MyDocumentsShellFolder
    }
    catch {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

Function Check-UserProfileShellFolder() {
    try {
        $DownloadShellFolder=Get-UserProfileShellFolder
    }
    catch {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "User Profile  Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

## Set System Objects
$wc = New-Object System.Net.WebClient
if( Check-DownloadShellFolder ) {
    $DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}
else {
    Write-Host "Check Integrity Error! Download Folder is not Found."
    Exit 1
}

### Set Url and Output
#
$anUrl00 = $aPureURL + $aFile00
$anOutput00 = Join-Path -Path $DownloadsDir -ChildPath $aFile00
$anUrl01 = $aPureURL + $aFile01
$anOutput01 = Join-Path -Path $DownloadsDir -ChildPath $aFile01
$anUrl02 = $aPureURL + $aFile02
$anOutput02 = Join-Path -Path $DownloadsDir -ChildPath $aFile02
$anUrl03 = $aPureURL + $aFile03
$anOutput03 = Join-Path -Path $DownloadsDir -ChildPath $aFile03

if( Test-Path -Path $anOutput00 ) {
    ri -Path $anOutput00 -Force
}

if( Test-Path -Path $anOutput01 ) {
    ri -Path $anOutput01 -Force
}

if( Test-Path -Path $anOutput02 ) {
    ri -Path $anOutput02 -Force
}

if( Test-Path -Path $anOutput03 ) {
    ri -Path $anOutput03 -Force
}

# $wc.DownloadFile($anUrl00, $anOutput00)
# & $anOutput00
$wc.DownloadFile($anUrl01, $anOutput01)
# & $anOutput01
$wc.DownloadFile($anUrl02, $anOutput02)
# & $anOutput02
# $wc.DownloadFile($anUrl03, $anOutput03)
# & $anOutput03
