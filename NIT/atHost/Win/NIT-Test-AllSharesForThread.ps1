<#
.SYNOPSIS
    Test All Open Share for Thread
.DESCRIPTION
    Test All Open Share for Thread
    on Windows 10.0 Local Computer
.NOTES
    File name: NIT-Test-AllSharesForThread.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-08
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-08) Script created
    1.0.1 - 
#>

### Set Variables
#


### Set a Function
#
### Run Payloads
#

# Установка английского языка для корректной работы
$prevCulture = [Threading.Thread]::CurrentThread.CurrentCulture
# [Threading.Thread]::CurrentThread.CurrentCulture = 'en-US'

# Получаем IP машины
$ipAddress = (Test-Connection -ComputerName $env:COMPUTERNAME -Count 1).IPV4Address.IPAddressToString

# Получаем имя компьютера
$computerName = $env:COMPUTERNAME

# Генерируем рандомное число
$randomNumber = Get-Random -Minimum 1 -Maximum 10000

# Создадим локальный файл  в Temp
$localFolderPath = "C:\Temp"
$fileName = "$($randomNumber)_$($ipAddress)_$($computerName)_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').txt"
# $localFilePath = "$localFolderPath\$fileName"
$localFilePath = Join-Path -Path $localFolderPath -ChildPath $fileName

# Отладочная информация
Write-Host "File will be created at $localFilePath"

# Функция для получения прав доступа и замена на читабельные данные
function Get-AccessRights {
    param($path)
    [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('cp866')
    $accessRights = & icacls $path | Out-String
    $accessRights = $accessRights -replace '\(OI\)', '/Owner'  # Owner object
    $accessRights = $accessRights -replace '\(CI\)', '/Container'  # Container
    $accessRights = $accessRights -replace '\(F\)', '/Full access'  # Full access
    $accessRights = $accessRights -replace '\(RX\)', '/Read and execute'  # Read and execute
    return $accessRights
}

# Получаем список общих сетевых папок на текущем компьютере
$networkFolders = Get-WmiObject -Class Win32_Share | Where-Object { $_.Path -ne $null -and $_.Type -eq 0 }

# Если есть открытые сетевые папки, записываем информацию в файл
if ($networkFolders) {
    $outputData = @()
    $outputData += "$ipAddress \ $computerName \ `"Number of open folders:`" $($networkFolders.Count)"
    $outputData += "Path to folders:"

    foreach ($folder in $networkFolders) {
        $folderPath = $folder.Path
        $outputData += "$folderPath"#

        # Получаем информацию о правах доступа и сам процесс для записи в файл
        $accessRights = Get-AccessRights -path $folderPath
        $outputData += $accessRights
    }

    $outputData | Out-File -FilePath $localFilePath -Encoding UTF8
    # Write-Host $outputData
} else {
    # Если открытых сетевых папок нет, выводим сообщение об этом
    "IP Address: $ipAddress `nComputer Name: $computerName `nNetwork folders not found." | Out-File -FilePath $localFilePath -Encoding UTF8
    # Write-Host "No Networks Data"
}

# Выводим сообщение об успешном выполнении задачи

Write-Host "Information gathered and saved to $localFilePath."

# Восстановить предыдущую настройку кодировки
[Threading.Thread]::CurrentThread.CurrentCulture = $prevCulture
