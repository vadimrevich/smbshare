<#
    .SYNOPSIS
        This Script will Get Register Antivirus Product Instance
    .DESCRIPTION
        This Script will Get Register Antivirus Product Instance
    .NOTES
    	File name: Get-NITAntivirusProduct02.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-09-13
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-09-13) Script created
    	1.0.1 - 
#>

## Define a Function
#
$computerList = "localhost", "localhost"
$filter = "antivirus"

$results = @()
foreach($computerName in $computerList) {

    $hive = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $computerName)
    $regPathList = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
                   "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

    foreach($regPath in $regPathList) {
        if($key = $hive.OpenSubKey($regPath)) {
            if($subkeyNames = $key.GetSubKeyNames()) {
                foreach($subkeyName in $subkeyNames) {
                    $productKey = $key.OpenSubKey($subkeyName)
                    $productName = $productKey.GetValue("DisplayName")
                    $productVersion = $productKey.GetValue("DisplayVersion")
                    $productComments = $productKey.GetValue("Comments")
                    if(($productName -match $filter) -or ($productComments -match $filter)) {
                        $resultObj = [PSCustomObject]@{
                            Host = $computerName
                            Product = $productName
                            Version = $productVersion
                            Comments = $productComments
                        }
                        $results += $resultObj
                    }
                }
            }
        }
        $key.Close()
    }
}

$results | ft -au