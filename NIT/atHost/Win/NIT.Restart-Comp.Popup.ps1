<#
.SYNOPSIS
    This Script will Send a Popup with Restart Message
.DESCRIPTION
    This Script will Send a Popup with Restart Message
    on Windows 10 Local Computer
.NOTES
    File name: NIT.Restart-Comp.Popup.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-10-18
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-10-18) Script created
    1.0.1 - 
#>

### Set Variables

$aTimeOut = 40 # Seconds
$theTextMessage = "Обновления готовы к установке.`n`nВнимание! Ваш компьютер будет принудительно перезапущен в течение " + $aTimeOut + " секунд.`nСохраните все несохранённые данные и закройте приложения."
$theTextMessage01 = "Обновления готовы к установке.`nКомпьютер перезагрузится через " + $aTimeOut + " секунд. Сохраните занные"
$theUserTitle ="Внимание $Env:USERNAME"
$theTextMessage02 = "Компьютер обновляется. Перезагрузка через " + $aTimeOut + " с."

### Set Functions

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Get-TheWindowsPopupMessage {
	$wshell = New-Object -ComObject Wscript.Shell
	$Output = $wshell.Popup($theTextMessage, $aTimeOut, $theUserTitle, 0+48)
}

function Get-TheTrayPopupMessage {
	Add-Type -AssemblyName System.Windows.Forms
	$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
	$path = (Get-Process -id $pid).Path
	$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
	$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning
	$balmsg.BalloonTipText = $theTextMessage01
	$balmsg.BalloonTipTitle = $theUserTitle
	$balmsg.Visible = $true
	$balmsg.ShowBalloonTip($aTimeOut * 1000)
}

function Restart-WindownComputer {
    & shutdown.exe /r /t $aTimeOut /c "$theTextMessage02"
}

### Test Integrity

### Run Payloads

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
##        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'
Get-TheWindowsPopupMessage
Get-TheTrayPopupMessage

Restart-WindownComputer

### The End
Exit 0
