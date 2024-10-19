<#
.SYNOPSIS
    This Script will Get Full Windows Version Information
    for Local Computer.
    This Script will automatically Running with Elevated
    Privileges (Restart if not).
.DESCRIPTION
    This Script will Get Full Windows Version Information
.NOTES
    File name: Get-Windows.Versions.WMI.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-07-18
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-07-18) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

###########################################################
# Get-Windows.Versions.WMI.ps1
###########################################################

# [WMI]'Win32_OperatingSystem=@'
# [WMI]'Win32_OperatingSystem=@' | Select-Object BuildNumber,Caption,Codeset,CSName,OSArchitecture,OSLanguage,RegisteredUser,Status,Version,WindowsDirectory,LocalDateTime
# [WMI]'Win32_OperatingSystem=@' | Select-Object BuildNumber,Caption,Codeset,CSName,OSArchitecture,OSLanguage,RegisteredUser,Status,Version,WindowsDirectory | ft

# Get-ComputerInfo | Select-Object WindowsProductName,WindowsVersion,OsHardwareAbstractionLayer

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Function NIT-CheckPSVersionMajor() {
    $aPSVersionMajor=$PSVersionTable.PSVersion.Major.ToString()
    $aVar=[convert]::ToInt32($aPSVersionMajor, 10)
    # Write-Host "aVar: $aVar"
    if( $aVar -ge 4 ) { return $true }
    else {return $false }
}

Function NIT-GetOSLanguage(){
    $anOSLanguage=([WMI]'Win32_OperatingSystem=@').OSLanguage.ToString();
    if( $anOSLanguage -match "1049") {return "Russian"}
    else {
        if( $anOSLanguage -match "1033") {return "English"}
        else {return "Unknown"}
    }
}

Function NIT-IsOsServer() {
    $WinVersion=([WMI]'Win32_OperatingSystem=@').Caption.ToString() | Select-String "Server" | ForEach-Object {$_.Matches.Value}
    if( $WinVersion -match "Server") { return "Server" }
    else {return "Client"}
}

Function NIT-IsOsCore() {
    $isServet = NIT-IsOsServer
    if( $isServet -match "Server" ) {
        $WinVersion=([WMI]'Win32_OperatingSystem=@').Caption.ToString() | Select-String "Core" | ForEach-Object {$_.Matches.Value}
        if( $WinVersion -match "Core" ) { return "Core" }
    }
    return "Desktop"
}

Function NIT-GetOSVersion() {
    $OSType=NIT-IsOsServer
    $WinVersion=""
    if( NIT-CheckPSVersionMajor ) {
        if( $OSType -match "Client" ) {
            $WinVersion=([WMI]'Win32_OperatingSystem=@').Caption.ToString() | Select-String "Windows \S+" | ForEach-Object {$_.Matches.Value} | Select-String "\s\S+" |  ForEach-Object {$_.Matches.Value} | Select-String "\S+" | ForEach-Object {$_.Matches.Value}
        }
        else {
            if( $OSType -match "Server" ) {
                $WinVersion=([WMI]'Win32_OperatingSystem=@').Caption.ToString() | Select-String "Server \S+" | ForEach-Object {$_.Matches.Value} | Select-String "\s\S+" |  ForEach-Object {$_.Matches.Value} | Select-String "\S+" | ForEach-Object {$_.Matches.Value}
            }
            else {
                $WinVersion = "";
            }

        }
    }
    else {
        # Write-Host "Powershell Major Version < 4"
        $aVar=([WMI]'Win32_OperatingSystem=@').Caption.ToString()
        # Write-Host "Windows Caption: $aVar"
        return "Unknown"
    }
    if( $WinVersion -match "7" ) { return "7" }
    if( $WinVersion -match "8.1") { return "8.1" }
    if( $WinVersion -match "2008R2" ) { return "2008R2" }
    if( $WinVersion -match "2012R2" ) { return "2012R2" }
    if( $WinVersion -match "2016" ) { return "2016" }
    if( $WinVersion -match "2019" ) { return "2019" }
    if( $WinVersion -match "2022" ) { return "2022" }
    if( $WinVersion -match "10" ) { return "10" }
    if( $WinVersion -match "11" ) { return "11" }
    return "Unknown"    
    return $WinVersion
}

Function NIT-GetOSBuildNumber() {
    $WinNumber=([WMI]'Win32_OperatingSystem=@').BuildNumber.ToString()
    return $WinNumber
}

Function NIT-GetOsArchitecture() {
    if( NIT-CheckPSVersionMajor ) {
        $OSArch=([WMI]'Win32_OperatingSystem=@').OSArchitecture.ToString() | Select-String "^\d+" | ForEach-Object {$_.Matches.Value}
        if( $OSArch -match "64" ) {return "amd64"}
        if( $OSArch -match "32" ) {return "x86"}
    }
    else {
        Write-Host "Powershell Major Version < 4"
        $aVar = ([WMI]'Win32_OperatingSystem=@').OSArchitecture.ToString()
        Write-Host "Os Architecture: $aVar"
        return "Unknown"
    }
    return "Unknown"
}

Function NIT-GetWinEdition() {
    if( NIT-CheckPSVersionMajor ) {
        $WinEdition=$(Get-WindowsEdition -Online).Edition.ToString()
        # Write-Host "Windows Edition: $WinEdition" 
    }
    else {
        Write-Host "Powershell Major Version < 4"
        Write-Host "Can't Determine Edition"
        return "Unknown"
    }
    if( $(NIT-IsOsServer) -match "Server" ) {
        if( $WinEdition -match "Standard" ) {return "Standard"}
        if( $WinEdition -match "Datacenter") { return "Datacenter" }
        return "Unknown"
    }
    if( $(NIT-IsOsServer) -match "Client" ) {
        if( $(NIT-GetOSVersion) -match "7" ) {
            if($WinEdition -match "Home Basic" ) { return "Home Basic" }
            if($WinEdition -match "Домашняя Базовая" ) { return "Home Basic" }
            if($WinEdition -match "Home Premiun" ) { return "Home Premium" }
            if($WinEdition -match "Домашняя Расширенная" ) { return "Home Premium" }
            if($WinEdition -match "Professional" ) { return "Professional" }
            if($WinEdition -match "Профессиональная" ) { return "Professional" }
            if($WinEdition -match "Maximal" ) { return "Maximal" }
            if($WinEdition -match "Максимальная" ) { return "Maximal" }
            return "Unknown"

        }
        if( $(NIT-GetOSVersion) -match "8.1" ){
            if($WinEdition -match "Professional" ) { return "Professional" }
            if($WinEdition -match "Профессиональная" ) { return "Professional" }
            return "Unknown"

        }
        if( $(NIT-GetOSVersion) -match "10" ) {
            if($WinEdition -match "Core" ) { return "Home" }
            if($WinEdition -match "Professional" ) { return "Professional" }
            if($WinEdition -like "Education" ) { return "Educational" }
            return "Unknown"

        }
        if( $(NIT-GetOSVersion) -match "11" ) {
            if($WinEdition -match "Core" ) { return "Home" }
            if($WinEdition -match "Professional" ) { return "Professional" }
            if($WinEdition -like "Education" ) { return "Educational" }
            return "Unknown"

        }
        return "Unknown"
    }
    return "Unknown"
}

Function NIT-CheckWinInfo() {
    $WinInfo="Microsoft Windows $(NIT-IsOsServer) $(NIT-GetOsVersion) $(NIT-IsOsCore) $(NIT-GetOSLanguage) $(NIT-GetWinEdition) $(NIT-GetOsArchitecture) Build $(NIT-GetOSBuildNumber)"
    # $WinInfo="Unknown Unknown Unknown"
    # $WinInfo="Microsoft Windows Client 7 Desktop Home Basic amd64"
    $hasUnknown=$WinInfo | Select-String "Unknown" | Select-Object -Expand Matches | Select-Object -Expand Value
    $hasHome=$WinInfo | Select-String "Home" | Select-Object -Expand Matches | Select-Object -Expand Value
    if($hasUnknown -match "Unknown" ) {
        Write-Host "Ваша операционная система не удовлетворяет современным требованиям"
        Write-Host "Как Вы смотрите на то, чтобы заменить её на Microsoft Windows 10/11 Pro?"
    }
    else {
        if( $hasHome -match "Home" ) {
            Write-Host "Ваша операционная система — домашеняя."
            Write-Host "Обновитесь до профессиональной версии."
        }
        Write-Host "Ваша система: $WinInfo"
    }
}

Function NIT-CheckDoingWinInfo() {
    $WinInfo="Microsoft Windows $(NIT-IsOsServer) $(NIT-GetOsVersion) $(NIT-IsOsCore) $(NIT-GetOSLanguage) $(NIT-GetWinEdition) $(NIT-GetOsArchitecture) Build $(NIT-GetOSBuildNumber)"
    $hasUnknown=$WinInfo | Select-String "Unknown" |  Select-Object -Expand Matches | Select-Object -Expand Value
    if($hasUnknown -match "Unknown" ) {
        Write-Host "Ваша операционная система не удовлетворяет современным требованиям"
        Write-Host "Как Вы смотрите на то, чтобы заменить её на Microsoft Windows 10/11 Pro?"
        $aVar=([WMI]'Win32_OperatingSystem=@').Caption.ToString()
        Write-Host "Windows Caption: $aVar"
        Write-Host "Ваша система: $WinInfo"

    }
    else {
        if( $(NIT-GetOSVersion) -match "7" ) {
            if( $(NIT-GetWinEdition) -match "Home Basic" ) {
                Write-Host "Ваша операционная система — домашеняя."
                Write-Host "Обновитесь до профессиональной версии."
                Write-Host "May not be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Home Premium" ) {
                Write-Host "Ваша операционная система — домашеняя."
                Write-Host "Обновитесь до профессиональной версии."
                Write-Host "May not be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Maximal" ) {
                Write-Host "Ваша операционная система — Максимальная."
                Write-Host "May not be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Professional" ) {
                Write-Host "Ваша операционная система — Профессиональная."
                Write-Host "May be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "8.1" ) {
            if( $(NIT-GetWinEdition) -match "Professional" ) {
                Write-Host "Ваша операционная система — Профессиональная."
                Write-Host "May be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "10" ) {
            if( $(NIT-GetWinEdition) -match "Professional" ) {
                Write-Host "Ваша операционная система — Профессиональная."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Educational" ) {
                Write-Host "Ваша операционная система — Образовательная."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Home" ) {
                Write-Host "Ваша операционная система — Домашняя."
                Write-Host "Обновитесь до профессиональной версии."
                Write-Host "May not be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "11" ) {
            if( $(NIT-GetWinEdition) -match "Professional" ) {
                Write-Host "Ваша операционная система — Профессиональная."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Educational" ) {
                Write-Host "Ваша операционная система — Образовательная."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Home" ) {
                Write-Host "Ваша операционная система — Домашняя."
                Write-Host "Обновитесь до профессиональной версии."
                Write-Host "May not be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "2008R2" ) {
            if( $(NIT-GetWinEdition) -match "Standard" ) {
                Write-Host "Ваш сервер — Стандартный."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Datacenter" ) {
                Write-Host "Ваш сервер — Датацентр."
                Write-Host "May be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "2012R2" ) {
            if( $(NIT-GetWinEdition) -match "Standard" ) {
                Write-Host "Ваш сервер — Стандартный."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Datacenter" ) {
                Write-Host "Ваш сервер — Датацентр."
                Write-Host "May be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "2016" ) {
            if( $(NIT-GetWinEdition) -match "Standard" ) {
                Write-Host "Ваш сервер — Стандартный."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Datacenter" ) {
                Write-Host "Ваш сервер — Датацентр."
                Write-Host "May be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "2019" ) {
            if( $(NIT-GetWinEdition) -match "Standard" ) {
                Write-Host "Ваш сервер — Стандартный."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Datacenter" ) {
                Write-Host "Ваш сервер — Датацентр."
                Write-Host "May be Cracked"
            }
        }
        if( $(NIT-GetOSVersion) -match "2022" ) {
            if( $(NIT-GetWinEdition) -match "Standard" ) {
                Write-Host "Ваш сервер — Стандартный."
                Write-Host "May be Cracked"
            }
            if( $(NIT-GetWinEdition) -match "Datacenter" ) {
                Write-Host "Ваш сервер — Датацентр."
                Write-Host "May be Cracked"
            }
        }
        $aVar=([WMI]'Win32_OperatingSystem=@').Caption.ToString()
        Write-Host "Windows Caption: $aVar"
        Write-Host "Ваша система: $WinInfo"
    }
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -ExecutionPolicy Bypass -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Hidden -ExecutionPolicy Bypass -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'


# $WinInfo="Microsoft Windows $(NIT-IsOsServer) $(NIT-GetOsVersion) $(NIT-IsOsCore) $(NIT-GetOSLanguage) $(NIT-GetWinEdition) $(NIT-GetOsArchitecture) Build $(NIT-GetOSBuildNumber)"

# NIT-CheckWinInfo
NIT-CheckDoingWinInfo


