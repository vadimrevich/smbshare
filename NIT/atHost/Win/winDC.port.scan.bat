echo off
rem ###########################################################
rem winDC.port.scan.sh
rem ###########################################################

rem Set Variables
set NMAPEXE="C:\Program Files (x86)\Nmap\nmap.exe"

rem Check Integrity
if not exist %NMAPEXE% echo %NMAPEXE% is not found && exit /b 1

rem run payloads

%NMAPEXE%  -Pn --open -sV -T4 -A ^
-p 20,21,22,23,25,53,80,88,110,119,135,139,389,443,445,464,563,593,636,647,2869,3268,3269,3389,5985,5986,9389,42424 ^
%1