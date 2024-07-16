Param (
[Parameter (Mandatory=$true, Position=1)]
[string]$FilePath
)

<#
    .SYNOPSIS
        This Script will Convert a Binary Exe File to a Base64 Code
        and Write Result at stdin
    .DESCRIPTION
        This Script will Convert a Binary Exe File to a Base64 Code
    .NOTES
    	File name: NIT-ConvertBinaryToBase64.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-11-21
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-11-21) Script created
    	1.0.1 - 
#>

# [CmdletBinding()]

function Convert-BinaryToString {
 
   [CmdletBinding()] param (
 
      [string] $FilePath
 
   )
 
   try {
 
      $ByteArray = [System.IO.File]::ReadAllBytes($FilePath);
 
   }
 
   catch {
 
      throw "Failed to read file. Ensure that you have permission to the file, and that the file path is correct.";
 
   }
 
   if ($ByteArray) {
 
      $Base64String = [System.Convert]::ToBase64String($ByteArray);
 
   }
 
   else {
 
      throw '$ByteArray is $null.';
 
   }
 
   Write-Output -InputObject $Base64String;
 
}

Convert-BinaryToString ($FilePath)
