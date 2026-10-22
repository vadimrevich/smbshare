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
 
$InputString = 'I1dyaXRlLUhvc3QgLU5vTmV3TGluZSAnUHJlc3MgYW55IGtleSB0byBjb250aW51ZS4uLic7DQojV3JpdGUtSG9zdCAtTm9OZXdMaW5lICfN4Obs6PLlIOv+4fP+IOrr4OLo+PMg5Ov/IO/w7uTu6+bl7ej/Li4uJzsNCldyaXRlLUhvc3QgJ1ByZXNzIGFueSBrZXkgdG8gY29udGludWUuLi4nOw0KV3JpdGUtSG9zdCAnzeDm7Ojy5SDr/uHz/iDq6+Di6PjzIOTr/yDv8O7k7uvm5e3o/y4uLic7DQojICRudWxsID0gJEhvc3QuVUkuUmF3VUkuUmVhZEtleSgnTm9FY2hvLEluY2x1ZGVLZXlEb3duJyk7DQo='

function Invoke-PS1PayloadsTemplate() {

	# Convert base64 string to byte array
 	$PEBytes = [System.Text.Encoding]::GetEncoding(1251).GetString([System.Convert]::FromBase64String($InputString))

	# Run EXE in memory
	#Write-Host $PEBytes
	Invoke-Expression $PEBytes

}

Invoke-PS1PayloadsTemplate