@echo off
rem *******************************************************
rem TcpPortScan.sh
rem This Script Checks all Open TCP Ports for Single Yggdrasil Hosts
rem
rem PARAMETER:	%1 is a Hosts
rem
rem *******************************************************
@echo off

rem Check if the first parameter not null
if "%~1" == "" goto :usage


rem Set Variables
set SCRIPTDIR=%~dp0
set OUTPUTDIR=%USERPROFILE%\Output
set NMAPEXE="C:\Program Files (x86)\Nmap\nmap.exe"
set AWKEXE=%ALLUSERSPROFILE%\chocolatey\bin\awk.exe
set AWK000=%SCRIPTDIR%res.00.awk
set AWK001=%SCRIPTDIR%res.01.awk

rem Check Integrity
if not exist %NMAPEXE% echo The file %NMAPEXE% is not found && exit /b 1
if not exist %AWKEXE% echo The file %AWKEXE% is not found && exit /b 1
if not exist %AWK000% echo The file %AWK000% is not found && exit /b 1
if not exist %AWK001% echo The file %AWK001% is not found && exit /b 1
if not exist %OUTPUTDIR% echo The directory %OUTPUTDIR% is not found && exit /b 1


rem Set Current Data name
set CURDATE=%DATE%
set CURTIME=%TIME%
rem Set DateTime Suffix...
rem
set newSuffix2=%CURDATE:~8,2%%CURDATE:~3,2%%CURDATE:~0,2%_%CURTIME:~0,2%%CURTIME:~3,2%%CURTIME:~6,2%
rem
rem Replace Delimiters " " to "0"
rem
set newSuffix2=%newSuffix2: =0%
set CURDATE=
set CURDATE= 

rem echo %newSuffix2%

rem Set PORTS variable

%NMAPEXE% -6 -Pn %1 | %AWKEXE% -F/ -f %AWK000% | %AWKEXE% -f %AWK001% > %SCRIPTDIR%temp.%~n0.txt.tmp
set /p PORTS= < %SCRIPTDIR%temp.%~n0.txt.tmp
del /F /Q %SCRIPTDIR%temp.%~n0.txt.tmp
set PORTS=%PORTS:~0,-1%


rem ports="$(nmap -Pn $1 | awk -F/ -f /home/vagrant/bin/res.00.awk | awk -f /home/vagrant/bin/res.01.awk)"
echo %PORTS%
rem nmap -v -p $ports -Pn -sV -A -O -oA /home/vagrant/Output/nmap-TcpScan_$(date +"%y-%m-%d_%H-%M-%S")_$1 $1 --host-timeout 5000 --max-retries 3

%NMAPEXE% -6 -v -p %PORTS% -Pn ^
-sV -A -O ^
-oA %OUTPUTDIR%\nmap-TcpScan_%newSuffix2%_ygg02 ^
%1

rem Unset Variables
set %PORTS%=
set %OUTPUTDIR%=
set %newSuffix2%

:End
echo Success Script %0 executed.
exit /b 0

rem Usage:
:usage
echo Error. First parameter must be present and should be IPv6 Addres or FQDN
exit /b 1