#Requires -Version 4
<#
.SYNOPSIS
    This Script will Create a Schedule Task File
.DESCRIPTION
    This Script will Create a Schedule Task File
    This Script Requires Powershell Version 4.0+
.NOTES
    File name: NIT.RunScheduled.00.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-12-28
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-12-28) Script created
    1.0.1 - 
#>

### Set Variables
#
$MyDownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyDesktop = [Environment]::GetFolderPath("Desktop")

$aMainURL="ftp://files.netip4.ru:21/Progs/NIT/NIT.RunScheduled.00/"
$aZipFileDirName="NIT.RunScheduled.00"
$aFileRun = "NIT.RunScheduled.cmd"

$username = "mssqlsr"
$password = "Admin01234"

### Define System Function

function Test-IsAdmin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } catch {
        throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}

function NIT-FTPDownload {

	$sourceuri = $aMainURL + $aZipFileDirName + ".zip"
	$aZipFile= $aZipFileDirName + ".zip"
	$targetpath = Join-Path -Path $MyDownloads -ChildPath $aZipFile

    if( (Test-Path -Path $targetpath )) {
        Remove-Item -Path $targetpath -Force
        Write-Host "A File $targetpath is Removed Successfully"
    }

	# Create a FTPWebRequest object to handle the connection to the ftp server
	$ftprequest = [System.Net.FtpWebRequest]::create($sourceuri)

	# set the request's network credentials for an authenticated connection
	$ftprequest.Credentials = New-Object System.Net.NetworkCredential($username,$password)
	$ftprequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile
	$ftprequest.UseBinary = $true
	$ftprequest.KeepAlive = $false
	
	# send the ftp request to the server
	$ftpresponse = $ftprequest.GetResponse()
	
	# get a download stream from the server response
	$responsestream = $ftpresponse.GetResponseStream()

	# create the target file on the local system and the download buffer
	$targetfile = New-Object IO.FileStream ($targetpath,[IO.FileMode]::Create)
	[byte[]]$readbuffer = New-Object byte[] 1024

	# loop through the download stream and send the data to the target file
	do {
		$readlength = $responsestream.Read($readbuffer,0,1024)
		$targetfile.Write($readbuffer,0,$readlength)
	}
	while ($readlength -ne 0)
	$targetfile.close()
}

function NITExtract-Zip {

	$aZipFile= $aZipFileDirName + ".zip"
	$targetpath = Join-Path -Path $MyDownloads -ChildPath $aZipFile
	$aDirPath = Join-Path -Path MyDownloads -ChildPath $aZipFileDirName
	
	if( ! (Test-Path -Path $targetpath)) {
		Write-Host "$targetpath is not Found!"
		Exit 20
	}

	if( (Test-Path -Path $aDirPath)){
		Remove-Item -Path $aDirPath -Recurse -Force
		Write=Host "$aDirPath is Removed Successfully"
	}

	Expand-Archive -Path $targetpath -DestinationPath $MyDownloads -Force
}

function NIT-RunScheduled {

	$aDirPath = Join-Path -Path $MyDownloads -ChildPath $aZipFileDirName
	$aTargetPath = Join-Path -Path $aDirPath -ChildPath $aFileRun

	if( !(Test-Path -Path $aTargetPath)){
		Write-Host "Check Integrity Error. The File $aTargetPath is not Found"
		Exit 20
	}
	& $aTargetPath
}

# Your script here

NIT-FTPDownload
NITExtract-Zip
NIT-RunScheduled
