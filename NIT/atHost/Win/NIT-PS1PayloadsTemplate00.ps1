<#
    .SYNOPSIS
        This Script will Deconvert and Run Payload
    .DESCRIPTION
        This Script will Deconvert Converted to Base64Encoder Payload
	to System Variable and
    .NOTES
    	File name: NIT-PS1PayloadsTemplate00.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-12-21
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-12-21) Script created
    	1.0.1 - 
#>

# Your base64 encoded binary
 
$InputString = '...........'

function Invoke-PS1PayloadsTemplate() {

	# Convert base64 string to byte array
 	$PEBytes = [System.Text.Encoding]::GetEncoding(1251).GetString([System.Convert]::FromBase64String($InputString))

	# Run EXE in memory
	#Write-Host $PEBytes
	Invoke-Expression $PEBytes

}

Invoke-PS1PayloadsTemplate