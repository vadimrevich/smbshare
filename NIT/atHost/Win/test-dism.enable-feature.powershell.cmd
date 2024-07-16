@echo off
rem *******************************************************
rem
rem test-dism.enable-feature.powershell.cmd
rem This file Enable Powershell Features on
rem some Windows Operation Systems
rem
rem *******************************************************
@echo off

%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellRoot /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:RemoteAccessPowerShell /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellISE /All

