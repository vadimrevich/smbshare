@echo on
rem *******************************************************
rem
rem NIT-SUDL-InitPr.cmd
rem
rem This Templater file Downloads and Installs NIT
rem Program Products and Plugins
rem on local computer
rem
rem ALGORITHM
rem
rem PARAMETERS: NO
rem RETURN:	0 if Success
rem		1 if Filesystem Error
rem		2 bitsadmin not found
rem		3 curl not found
rem		4 wget not found
rem		5 Unknown OS
rem		6 Wrong Server
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TEMPLATE
SET FIRM_NAME=NIT

rem
rem Set Directories Path
set curdirforurl=%CD%
set UTIL=c:\Util
set DEST_DIR=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set TEMPPUB=c:\pub1\Distrib

rem Check if FileSystem Correct
echo Check AllUserProfile
if not exist "%ALLUSERSPROFILE%" exit /b 1

rem Check if Utilites Presents
echo Check if Utilities Presents
if not exist "%SystemRoot%\system32\find.exe" exit /b 1
rem if not exist "%UTIL%\nit.http.wise.wsf" exit /b 2
rem if not exist "%SystemRoot%\System32\bitsadmin.exe" exit /b 2
if not exist "%SystemRoot%\System32\wbem\WMIC.EXE" exit /b 1
if not exist "%SystemRoot%\System32\reg.exe" exit /b 1
if not exist "%SystemRoot%\System32\wscript.exe" exit /b 1
if not exist "%SystemRoot%\System32\cscript.exe" exit /b 1
if not exist "%SystemRoot%\System32\shutdown.exe" exit /b 1
if not exist "%SystemRoot%\System32\netsh.exe" exit /b 1
if not exist "%SystemRoot%\System32\attrib.exe" exit /b 1
if not exist "%USERPROFILE%\nit.http.wise.wsf" exit /b 2
copy "%USERPROFILE%\nit.http.wise.wsf" "%TEMP%\nit.http.wise.wsf"
if not exist "%TEMP%\nit.http.wise.wsf" exit /b 2
if not exist "%TEMP%" exit /b 1

rem Make and Clean Download Directory
md %PUB1%
md %PUB1%\Distrib
md %UTIL%
md %DEST_DIR%
md "%ALLUSERSPROFILE%\%FIRM_NAME%"
"%SystemRoot%\System32\attrib.exe" +H "%PUB1%"
"%SystemRoot%\System32\attrib.exe" +H "%PUB1%\Distrib%"
"%SystemRoot%\System32\attrib.exe" +H "%DEST_DIR%"
"%SystemRoot%\System32\attrib.exe" +H "%UTIL%"

rem Check If System Product Directory Exists
rem
echo Check NIT Products Directory
set PRODUCTNAMEDIR=%ALLUSERSPROFILE%\%FIRM_NAME%\%PRODUCT_NAME%
rem if not exist "%PRODUCTNAMEDIR%" exit /b 1
if not exist "%UTIL%" exit /b 1
if not exist "%DEST_DIR%" exit /b 1
if not exist "%PUB1%" exit /b 1
if not exist "%TEMPPUB%" exit /b 1

rem Initialization Download Variables
rem
set http_pref001=http
set http_host001=file.netip4.ru
set http_port001=80
rem set http_dir0001=/WinUpdate/
rem set http_dir0000=/Exponenta/
set http_echodir=/WinUpdate/InitialCommon/

rem set Folders
rem
set BASE_FOLD=%http_echodir%

rem set Executable Files Variables
set LOADSUDL=NIT-SUDl-00.cmd
set GETVALIDVERSION=NIT.getVersion.bat

rem Derivatives Variables Initial
set host0=%http_pref001%://%http_host001%:%http_port001%%BASE_FOLD%
set LocalFolder=%TEMP%
rem set LocalFolder=%USERPROFILE%

rem Download and Execute
echo Download %LocalFolder%\%GETVALIDVERSION%
"%SystemRoot%\System32\cscript.exe" "%TEMP%\nit.http.wise.wsf" %GETVALIDVERSION% %host0% "%LocalFolder%"
if not exist "%LocalFolder%\%GETVALIDVERSION%" echo "%LocalFolder%\%GETVALIDVERSION%" not exist && exit /b 6
call "%LocalFolder%\%GETVALIDVERSION%"
rem Check Error
if %ERRORLEVEL%==2 goto Unknown
if %ERRORLEVEL%==1 exit /b 1

rem set CURL & WGET Variables
rem
echo Set CURL and WGET Variadles
set CURLEXE=%UTIL%\curl.exe
set WGETEXE=%UTIL%\wget.exe
if not exist "%CURLEXE%" echo %CURLEXE% not exist && exit /b 3
if not exist "%WGETEXE%" echo %WGETEXE% not exist && exit /b 4

rem Enable all protocols for curl, wget
%SystemRoot%\System32\netsh.exe advfirewall firewall delete rule name="Download Application Rule"

%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="Download Application Rule" dir=in action=allow program="%WGETEXE%" enable=yes
%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="Download Application Rule" dir=out action=allow program="%WGETEXE%" enable=yes
%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="Download Application Rule" dir=in action=allow program="%CURLEXE%" enable=yes
%SystemRoot%\System32\netsh.exe advfirewall firewall add rule name="Download Application Rule" dir=out action=allow program="%CURLEXE%" enable=yes

:NonSU
if not exist "%TEMP%\%LOADSUDL%" echo "%TEMP%\%LOADSUDL%" not exist && goto Unknown
call "%TEMP%\%LOADSUDL%"
goto End

:Unknown
rem Unknown OS
echo Run at Unknown OS
exit /b 5

rem The End of the Script
:End
echo "Success Update Script Start"
exit /b 0