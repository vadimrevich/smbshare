###########################################################
# This Script Sets a Default Remote SSH Shell as a PowerShell
##########################################################
If(Test-Path "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1") 
	{& "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1" -PathSpecsToProbeForShellEXEString "$env:programfiles\PowerShell\*\pwsh.exe;$env:programfiles\PowerShell\*\Powershell.exe;c:\windows\system32\windowspowershell\v1.0\powershell.exe;C:\Windows\system32\cmd.exe" -AllowInsecureShellEXE}