
# ----- ExeScript Options Begin -----
# ScriptType: console,silent,administrator
# DestDirectory: current
# Icon: default
# OutputFile: E:\yuden\Compile\SetupRemoteSettings.ps1.exe
# ----- ExeScript Options End -----

# Setup-RemoteSettings.ps1
# This Script Prepares the Powershell Module to First Run
#
###
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
Enable-PSRemoting -Force
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions
Set-BoxstarterTaskbarOptions -Size  Large

