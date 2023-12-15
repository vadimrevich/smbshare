@echo on
rem *******************************************************
rem nit-remoteenable-check.cmd
rem This Script will Check a Windows Host to Remote
rem Enable Open POrts
rem
rem PARAMETERS:	%1 is a host name or IP address
rem RETURNS:	always 0
rem *******************************************************
@echo off
nmap -Pn -p U:137,138,5357,T:21,22,23,135,137,139,445,3389,5357,5985 -sU -sS -sV --script=banner,nbstat -oA %UserProfile%\Output\RemoteEnable-Check-%1 --min-rate 1280 %1
exit /b 0
