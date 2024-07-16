@echo on
rem *******************************************************
rem nit.get_smb1protocol.cmd
rem This Script will Get a SMBv1.0 Protocol with Dism
rem *******************************************************
@echo off

rem Run Payloads
Dism /online /Get-Features /format:table | find "SMB1Protocol"