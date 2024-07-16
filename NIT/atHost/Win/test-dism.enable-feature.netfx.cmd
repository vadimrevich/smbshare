@echo off
rem *******************************************************
rem
rem test-dism.enable-feature.netfx.cmd
rem This file Enable .NET Framework Features on
rem some Windows Operation Systems
rem
rem *******************************************************
@echo off

%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx4 /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx4-AdvSrvs /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3ServerFeatures /All
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx4ServerFeatures /All

