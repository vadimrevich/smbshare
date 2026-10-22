@echo off
rem *******************************************************
rem sed.exclusionpath.defenderadd.bat
rem This function is made Windows Defeneder exclusions
rem adding file from Exclusions Path List
rem
rem Program will use a SED utility
rem Exclusions list is made by a Command
rem Get-MpPreference | Select-Object -Property ExclusionPath | Out-File $env:UserProfile\Exclusions.Path.Defender.ps1.txt
rem Be Sure that you have a UNIX (LF) End-of-Line
rem
rem PARAMETER %1 is a List file
rem
rem *******************************************************
echo off

rem set a variable

rem set aListFile=%1
set aListFile=%UserProfile%\Exclusions.Path.Defender.ps1.txt
set aPrefix="Add-MpPreference -ExclusionPath "

set aPrefix=%aPrefix:"=%
rem set aSedStrind="s/^/\"/;s/$/\"/"
set aSedStrind="s/^/\"/;s/$/\"/;s/^/%aPrefix%/"

rem Run Payload
type %aListFile% | sed %aSedStrind%

rem The End of the Script