<#
.SYNOPSIS
    This Script will Get a GPS Deviñe Latitude and Longitude
    for Windows 10 Computer
.DESCRIPTION
    This Script will Get Latitude and Longitude
.NOTES
    File name: Get-System.Device.Location.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-01-26
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-01-26) Script created
    1.0.1 - 
#>

Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace
$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher #Create the required object
$GeoWatcher.Start() #Begin resolving current locaton

while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
    Start-Sleep -Milliseconds 100 #Wait for discovery.
}  

if ($GeoWatcher.Permission -eq 'Denied'){
    Write-Error 'Access Denied for Location Information'
} else {
#    $GeoWatcher.Position.Location | Select Latitude,Longitude #Select the relevent results.
    $GeoWatcher.Position.Location
}