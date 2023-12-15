@echo on
rem *******************************************************
rem nmap.netbios.discover.bat
rem This Script will Check if NetBIOS ports Open at
rem Windows Host %1 and Output an Info.
rem *******************************************************
@echo off

nmap.bat -Pn -p U:137,138,5357,T:21,22,23,135,137,139,445,3389,5357,5985,5986 -sU -sS -sV -oA %UserProfile%\Output\NB.Discover_%1 --script=banner,nbstat --max-rate 1280 %1
