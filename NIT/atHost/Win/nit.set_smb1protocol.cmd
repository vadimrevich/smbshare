@echo on
rem *******************************************************
rem nit.set_smb1protocol.cmd
rem This Script will Set a SMBv1.0 Protocol with Dism
rem *******************************************************
@echo off

rem Run Payloads
Dism /online /Enable-Feature /FeatureName:"SMB1Protocol" /All /NoRestart
Dism /online /Enable-Feature /FeatureName:"SMB1Protocol-Client" /All /NoRestart
Dism /online /Enable-Feature /FeatureName:"SMB1Protocol-Server" /All /NoRestart
rem shutdown /r /t 00
