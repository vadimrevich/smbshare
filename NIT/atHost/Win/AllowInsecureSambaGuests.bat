@echo off
rem *******************************************************
rem AllowInsecureSambaGuests.bat
rem Run with Elevated Privileges
rem *******************************************************

rem Run Payload
reg.exe ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters /v AllowInsecureGuestAuth /t REG_DWORD /d 0x1 /f
