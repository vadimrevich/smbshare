<#
    .SYNOPSIS
        This Script will Deconvert and Run Payload
    .DESCRIPTION
        This Script will Deconvert Converted to Base64Encoder Payload
	to System Variable and
    .NOTES
    	File name: NIT-ExePayloadsTemplate00.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-11-21
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-11-21) Script created
    	1.0.1 - 
#>

# Your base64 encoded binary
 
$InputString = '...........'

function Invoke-ReflectivePEInjection
{
 
   ......
   ......
   ......
 
}
 
function NIT-ExePayloadsTemplate() {

	# Convert base64 string to byte array
 	$PEBytes = [System.Convert]::FromBase64String($InputString)

	# Run EXE in memory
	#Invoke-ReflectivePEInjection -PEBytes $PEBytes -ExeArgs "Arg1 Arg2 Arg3 Arg4"

}

NIT-ExePayloadsTemplate