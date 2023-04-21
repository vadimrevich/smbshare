@echo on
rem *******************************************************
rem Test001.smbshare.MSFT.bat
rem Test if Files of smbshare Packet are Present
rem
rem PARAMETERS:	none
rem RETURNS:	0 if smbshare Files are Present
rem		1 if Check Integrity Error
rem		2 if smbshare Files are not Present
rem		3 if smbshare Files are not Present
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=smbshare
set PRODUCT_NAME_FOLDER=
set FIRM=NIT
set SMBSHARE0=%~dp0..\..

echo Check OS Version and Processor Architecture...
rem
rem Set OS Architecture
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

set OS_ARCH=%xOS%

rem Set Messages Files
rem
set MSG000ERR01=%~dp0Msg000.CheckIntegrity.Err01.wsf
set MSG000ERR00=%~dp0Msg000.CheckIntegrity.Err00.wsf
set MSG000ERR02=%~dp0Msg001.smbshare.MSFT.Err02.wsf
set CSCRIPTEXE1=%SystemRoot%\System32\cscript.exe

echo Check Message Integrity...
rem
if not exist %MSG000ERR00% echo %MSG000ERR00% is not Exists && exit /b 3
if not exist %MSG000ERR01% echo %MSG000ERR01% is not Exists && exit /b 3
if not exist %MSG000ERR02% echo %MSG000ERR02% is not Exists && exit /b 3
if not exist %CSCRIPTEXE1% echo %CSCRIPTEXE1% is not Exists && exit /b 1

rem
rem Set Directories Path
set PATHCMD=%SystemRoot%\System32
set PATHCMDWOW=%SystemRoot%\SysWOW64

rem Check if FileSystem Correct
rem Check if System Folder Present at FileSystem
echo Check if Folder Presents...
if not exist C:\Windows echo "C:\Windows not Exists" && goto Lab_Err01
if not exist "%TEMP%" echo "TEMP not Exists" && goto Lab_Err01
if not exist "%ALLUSERSPROFILE%" echo "ALLUSERSPROFILE not Exists" && goto Lab_Err01
if not exist "%SystemRoot%" echo "SystemRoot not Exists" && goto Lab_Err01
if not exist "%PATHCMD%" echo "PATHCMD not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\wbem" echo "%PATHCMD%\wbem not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\WindowsPowerShell\v1.0" echo "%PATHCMD%\WindowsPowerShell\v1.0 not Exists" && goto Lab_Err01
if %OS_ARCH%==x86 goto EndFolderCheck
if not exist "%PATHCMDWOW%" echo "PATHCMDWOW not Exists" && goto Lab_Err01
if not exist "%PATHCMDWOW%\wbem" echo "%PATHCMDWOW%\wbem not Exists" && goto Lab_Err01
if not exist "%PATHCMDWOW%\WindowsPowerShell\v1.0" echo "%PATHCMDWOW%\WindowsPowerShell\v1.0 not Exists" && goto Lab_Err01

:EndFolderCheck
echo End System Folder Check

rem Check if System File Present at FileSystem
echo check if System File Present...

if not exist "%COMSPEC%" echo "COMSPEC not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\cmd.exe" echo "%PATHCMD%\cmd.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\attrib.exe" echo "%PATHCMD%\attrib.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\cscript.exe" echo "%PATHCMD%\cscript.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\wscript.exe" echo "%PATHCMD%\wscript.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\shutdown.exe" echo "%PATHCMD%\shutdown.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\find.exe" echo "%PATHCMD%\find.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\wbem\WMIC.exe" echo "%PATHCMD%\wbem\WMIC.exe not Exists" && goto Lab_Err01
rem if not exist "%PATHCMD%\bitsadmin.exe" echo "%PATHCMD%\bitsadmin.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe" echo "%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe not Exists" && goto Lab_Err01
if %OS_ARCH%==x86 goto EndSysFilesCheck
if not exist "%PATHCMDWOW%\cmd.exe" echo "%PATHCMDWOW%\cmd.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMDWOW%\cscript.exe" echo "%PATHCMDWOW%\cscript.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMDWOW%\wscript.exe" echo "%PATHCMDWOW%\wscript.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMDWOW%\wbem\WMIC.exe" echo "%PATHCMDWOW%\wbem\WMIC.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMDWOW%\WindowsPowerShell\v1.0\powershell.exe" echo "%PATHCMDWOW%\WindowsPowerShell\v1.0\powershell.exe not Exists" && goto Lab_Err01

:EndSysFilesCheck
echo End System Files Check!

rem
rem Set Directories Path
set MSFTPROD_DIR0=%SMBSHARE0%\MSFT\VCRedist\x86
set MSFTPROD_DIR1=%SMBSHARE0%\MSFT\VCRedist\x64
set MSFTPROD_DIR3=%SMBSHARE0%\MSFT\SecUpdate\W7W2K8R2\x86
set MSFTPROD_DIR4=%SMBSHARE0%\MSFT\SecUpdate\W7W2K8R2\x64
set MSFTPROD_DIR2=%SMBSHARE0%\MSFT\dotNet
set MSFTMESSAGDIR=%SMBSHARE0%\MSFT\MESSAGES

rem Set Files and Paths...
rem
set AMSFTFILE01=%MSFTPROD_DIR0%\vcredist.install.bat
set AMSFTFILE02=%MSFTPROD_DIR0%\VCRHyb86.exe
set AMSFTFILE03=%MSFTPROD_DIR0%\RuntimePack_Lite_x86_x64.exe
set AMSFTFILE04=%MSFTPROD_DIR1%\vcredist.install.bat
set AMSFTFILE05=%MSFTPROD_DIR1%\VCRHyb64.exe
set AMSFTFILE06=%MSFTPROD_DIR1%\RuntimePack_Lite_x86_x64.exe
set AMSFTFILE07=%MSFTPROD_DIR2%\dotnet.install.bat
set AMSFTFILE08=%MSFTPROD_DIR2%\NDP462-KB3151800-x86-x64-AllOS-ENU.exe
set AMSFTFILE09=%MSFTPROD_DIR2%\ndp48-x86-x64-allos-enu.exe
set AMSFTFILE10=%MSFTPROD_DIR3%\secupdate.install.bat
set AMSFTFILE11=%MSFTPROD_DIR3%\Windows6.1-KB2813430-x86.msu
set AMSFTFILE12=%MSFTPROD_DIR3%\Windows6.1-KB3004394-v2-x86.msu
set AMSFTFILE13=%MSFTPROD_DIR3%\Windows6.1-KB2677070-x86.msu
set AMSFTFILE14=%MSFTPROD_DIR3%\Windows6.1-KB3063858-x86.msu
set AMSFTFILE15=%MSFTPROD_DIR4%\secupdate.install.bat
set AMSFTFILE16=%MSFTPROD_DIR4%\Windows6.1-KB2813430-x64.msu
set AMSFTFILE17=%MSFTPROD_DIR4%\Windows6.1-KB3004394-v2-x64.msu
set AMSFTFILE18=%MSFTPROD_DIR4%\Windows6.1-KB2677070-x64.msu
set AMSFTFILE19=%MSFTPROD_DIR4%\Windows6.1-KB3063858-x64.msu
set AMSFTMSGFILE01=%MSFTMESSAGDIR%\MESSWIN7-dotNet01.wsf
set AMSFTMSGFILE02=%MSFTMESSAGDIR%\MESSWIN7-VCRedist01.wsf
set AMSFTMSGFILE03=%MSFTMESSAGDIR%\MESSWIN7-SecUpdate01.wsf
set AMSFTMSGFILE04=%MSFTMESSAGDIR%\MESSWIN7-SecUpdate02.wsf
rem

rem Set Integrity...
rem
if not exist %AMSFTMSGFILE01% echo %AMSFTMSGFILE01% is not Exist && goto Lab_Err02
if not exist %AMSFTMSGFILE02% echo %AMSFTMSGFILE02% is not Exist && goto Lab_Err02
if not exist %AMSFTMSGFILE03% echo %AMSFTMSGFILE03% is not Exist && goto Lab_Err02
if not exist %AMSFTMSGFILE04% echo %AMSFTMSGFILE04% is not Exist && goto Lab_Err02
if not exist %AMSFTFILE01% echo "%AMSFTFILE01% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE02% echo "%AMSFTFILE02% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE03% echo "%AMSFTFILE03% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE04% echo "%AMSFTFILE04% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE05% echo "%AMSFTFILE05% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE06% echo "%AMSFTFILE06% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE07% echo "%AMSFTFILE07% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE08% echo "%AMSFTFILE08% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE09% echo "%AMSFTFILE09% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE10% echo "%AMSFTFILE10% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE11% echo "%AMSFTFILE11% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE12% echo "%AMSFTFILE12% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE13% echo "%AMSFTFILE13% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE14% echo "%AMSFTFILE14% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE15% echo "%AMSFTFILE15% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE16% echo "%AMSFTFILE16% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE17% echo "%AMSFTFILE17% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE18% echo "%AMSFTFILE18% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE19% echo "%AMSFTFILE19% not Exist" && goto Lab_Err02

echo The End Checking Integrity

goto End

:Lab_Err01
%CSCRIPTEXE1% //NoLogo %MSG000ERR01%
echo The Error 1 in the Script %0
exit /b 1

:Lab_Err02
%CSCRIPTEXE1% //NoLogo %MSG000ERR02%
echo The Error 2 in the Script %0
exit /b 2

:End
%CSCRIPTEXE1% //NoLogo %MSG000ERR00%
echo The Successful End of the Script %0
exit /b 0