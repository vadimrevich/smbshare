#######
# NIT.New-CimAndPSSession-00.ps1
#######

#### Enter Computer Name or IP Address
$ComputerName="user-w7st"

#### Get Credential or Set Saved
# $credss=Get-Credential
$credss=$cred0

#### Run Payload

# New-CimSession -ComputerName $ComputerName -Credential $credss -Name csesss -Authentication Negotiate -Port 5985

New-PSSession -ComputerName $ComputerName -Credential $credss -Authentication Negotiate -Port 5985