#####
# RunFromFolderSchedule.installscripts.ps1
#####

# Set Variables
#
$URI='http://file.netip4.ru/PROGS/NIT/RunFromFolderSchedule/install.package.cmd'
$OutDir='C:\pub1\Distrib\Zlovred'

### Check Integrity
#

if( -not (Test-Path -Path $OutDir -PathType Container)) {
    Write-Host "The Derectory $OutDir does not exist!"
    Exit 1
}

if( -not (Test-Path -Path 'C:\Util' -PathType Container)) {
    Write-Host "The Derectory 'C:\Util' does not exist!"
    Exit 1
}

$OutFile = Join-Path -Path $OutDir -ChildPath "RunFromFolderInstall.cmd"

# Run Payloads
if( Test-Path -Path $OutFile ) {
    ri $OutFile -Force
}

### Download Payloads
$wc = New-Object System.Net.WebClient

$wc.DownloadFile($URI, $OutFile)
## iwr -Uri $URI -OutFile $OutFile

### Run Payloads

& $OutFile

### The End
Write-Host "The End of the Script RunFromFolderSchedule.installscripts.ps1"
Exit 0
