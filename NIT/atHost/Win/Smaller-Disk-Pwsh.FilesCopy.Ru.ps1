###
#
# Smaller-Disk-Pwsh.FileCopy
# This Script Prepare Smaller-Disk-Pwsh File Operation
#
##

### Set Virtual Machine Neme ###
$VMName = 'W2K22-HV'
 
### Get Credentials ###
$cred0 = Get-Credential
 
### Create Session ###
$sess0 = New-PSSession -VMName $VMNAME -Credential $cred0
 
### Copy to Session ###
Copy-Item -ToSession $sess0 -Path .\sdelete64.exe -Destination C:\Users\Администратор\Documents
Copy-Item -ToSession $sess0 -Path .\Smaller-Disk-Pwsh.ps1 -Destination C:\Users\Администратор\Documents
 
Invoke-Command -Session $sess0 -FilePath .\Smaller-Disk-Pwsh.ps1

 
Invoke-Command -Session $sess0 -ScriptBlock { Remove-Item .\Smaller-Disk-Pwsh.ps1 }
Invoke-Command -Session $sess0 -ScriptBlock {Remove-Item .\sdelete64.exe }
 
Remove-PSSession $sess0
