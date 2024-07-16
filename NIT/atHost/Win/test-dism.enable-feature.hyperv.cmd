@echo off
rem *******************************************************
rem
rem test-dism.enable-feature.hyperv.cmd
rem This file Enable Hyper-V Features on
rem some Windows Operation Systems
rem
rem *******************************************************
@echo off

%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-Tools-All /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-Management-PowerShell /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-Services /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-Management-Clients /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /All
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy Bypass -Command "Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart"
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy Bypass -Command "iwr -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -Outfile %USERPROFILE%\wsl_update_x64.msi"
%SystemRoot%\System32\msiexec.exe /i %USERPROFILE%\wsl_update_x64.msi /quiet /qn /norestart
del /Q /F %USERPROFILE%\wsl_update_x64.msi
rem wsl --install
wsl --set-default-version 2

