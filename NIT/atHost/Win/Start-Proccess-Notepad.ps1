###########################################################
# Start-Process-Notepad.ps1
# This Script Starts a Test Running notepad.exe
# from a Disk as a Process
##########################################################
$process = $env:SystemRoot+"\notepad.exe"
Start-Process $process -WindowStyle Normal