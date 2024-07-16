#####
##### NIT-New-ADPeterUser001.ps1 #####
## This Script will Create a New Test Peter User
## with Standard Parameters
#####

## Set a Variables
## (domain peter.yuden.local)
#
$aGivenName="Peter"
$aSurName="Tenkaev"
$aSamAccountName="peter"
$SafePassword="0a9s8d7F"
$aMobilePhone="+79047071125"
$aEMailAddress="yudenisov@hotmail.com"
$anOrganization="NIT"
$aCity="Saratov"
$aCountry="Russia"
$aPostalCode="410056"

$aName=$aSamAccountName
$aPrincipalName=$aSamAccountName+"@peter.yuden.local"
$aPath="OU=Users,OU=Accounts,OU=Saratov,OU=RU,DC=peter,DC=yuden,DC=local"
$SecurePassword=ConvertTo-SecureString $SafePassword -AsPlainText -Force

### Run a Payload
#
#New-ADUser -Name $aName -GivenName $aGivenName -Surname $aSurName -SamAccountName $aSamAccountName `
#           -UserPrincipalName $aPrincipalName -AccountPassword $SecurePassword `
#           -City $aCity -Country $aCountry -PostalCode $aPostalCode -MobilePhone $aMobilePhone `
#           -EmailAddress $aEMailAddress -Organization $anOrganization -Company $anOrganization `
#           -Enabled $true

New-ADUser -Name $aName -GivenName $aGivenName -Surname $aSurName -SamAccountName $aSamAccountName `
           -UserPrincipalName $aPrincipalName -AccountPassword $SecurePassword `
           -Enabled $true

