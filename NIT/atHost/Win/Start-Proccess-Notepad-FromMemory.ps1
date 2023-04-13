###########################################################
# Start-Proccess-Notepad-FromMemory.ps1
# This Script Test how to Run notepad.exe from Memory
#
###########################################################
$process = Get-Content $env:SystemRoot\notepad.exe
Start-Process $process -WindowStyle Normal