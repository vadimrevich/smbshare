###########################################################
# This Script Sets a Default SSH Shell cmd.exe
# on REmote Computer
###########################################################
If(Test-Path "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1") 
	{& "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1" -PathSpecsToProbeForShellEXEString "C:\Windows\system32\cmd.exe" -AllowInsecureShellEXE}