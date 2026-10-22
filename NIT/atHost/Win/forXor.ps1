<#
.SYNOPSIS
    This Script will Encode a file by XOR
.DESCRIPTION
    This Script will Encode a file by XOR
    on Windows Local Computer
.NOTES
    File name: forXor.ps1
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
    [System.Security.SecureString] $p,
    [System.IO.FileStream] $fstr
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
        # $fstr.WriteByte($tbyte);
    }
    return $byteArray
}


[byte[]]$t = [System.IO.File]::ReadAllBytes($in);
$fstr = New-Object IO.FileStream($out,'Create');

[byte[]]$byteArray = frox00 -t $t -p $p -fstr $fstr

$fstr.Write($byteArray, 0, $byteArray.length)
$fstr.Close();
