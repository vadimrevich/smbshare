<#
.SYNOPSIS
    This Script will Decode a file by XOR and base64
.DESCRIPTION
    This Script will Decode a file by XOR and base64
    on Windows Local Computer
.NOTES
    File name: fromXorBase64.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-07-19
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-07-19) Script created
    1.0.1 - 
#>
param(
    [parameter(Mandatory=$true, Position=0)][string] $infile,
    [parameter(Mandatory=$true, Position=1)][string] $outfile
)

$in = (resolve-path $infile).Path
$out = (pwd).Path + "\" + $outfile

$plainPass = "4QxaLPWM5I0g" # a Plain Text Password
$p = ConvertTo-SecureString -AsPlainText $plainPass -Force

function frox00 (
    [byte[]] $t,
    [System.Security.SecureString] $p
){
    $tind = $t.length - 1
    $sha512 = [System.Security.Cryptography.SHA512]::Create()
    $hashBytes = $sha512.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($p))
    $byteArray = [byte[]] (0.. $tind)

    for($i=0;$i -lt $t.length; $i++){
        [byte]$tbyte = 0
        $ind = $i % $hashBytes.length
        if (($ind -eq 0) -and ($i -ne 0)){
            $hashBytes = $sha512.ComputeHash($hashBytes)
            $tbyte = $t[$i] -bxor $hashBytes[$ind]
	        $byteArray[$i] = $tbyte
        } else {
            $tbyte = $t[$i] -bxor $hashBytes[$ind]
	        $byteArray[$i] = $tbyte
        }
    }
    return $byteArray
}

function toXorBase64 (
    [string] $in,
    [string] $out,
    [System.Security.SecureString] $p
){
    $inStr = Get-Content -Path $in
    [byte[]]$t = [System.Text.Encoding]::UTF8.GetBytes($inStr)
    [byte[]]$byteArray = frox00 -t $t -p $p
    [string] $outStr = [System.Convert]::ToBase64String($byteArray)
    Set-Content -Value $outStr -Path $out
}


function fromXorBase64 (
    [string] $in,
    [string] $out,
    [System.Security.SecureString] $p
){
    [string]$outStr = Get-Content -Path $in
    [byte[]] $t = [System.Convert]::FromBase64String($outStr)
    [byte[]]$byteArray = frox00 -t $t -p $p
    $stringFromBase64 = [System.Text.Encoding]::UTF8.GetString($byteArray)
    Set-Content -Path $out -Value $stringFromBase64
}

# Run Payload

# toXorBase64 -in $in -out $out -p $p
fromXorBase64 -in $in -out $out -p $p



