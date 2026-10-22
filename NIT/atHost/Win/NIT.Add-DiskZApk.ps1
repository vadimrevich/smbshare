<#
.SYNOPSIS
    This Script wil Add disk z: with Yandex Disk Files
.DESCRIPTION
    This Script wil Add disk z: with Yandex Disk Files
    on Windows 10 Local Computer
.NOTES
    File name: NIT.Add-DiskZApk.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-09-13
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-09-13) Script created
    1.0.1 - 
#>

# Set vaiable
$aDomain="webdav.yandex.ru"
$aPort="ssl"
$aUser="yudenisov@yandex.ru"
$aPass="eoxmguwfpqdtzspc"

$aDiskLetter="z:"

# Run Payload
& net.exe use $aDiskLetter \\$aDomain@$aPort\Загрузки\DavWWWRoot $aPass /USER:$aUser

# End
Exit 0
