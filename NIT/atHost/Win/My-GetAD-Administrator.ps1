### Set My Domain Controller
#
$MyDomainController="w2k22-ad.yudenisov.internal"

## Get All Users at AD
Get-ADUser -AuthType Negotiate -Credential $cred0 -Server $MyDomainController -Filter *

## Get All Properties of the User Администратор at AD
Get-ADUser -AuthType Negotiate -Credential $cred0 -Server $MyDomainController -Filter 'SamAccountName -like "Админ*"' | Select-Object -Property *

## Get All Computers at AD
Get-ADComputer -AuthType Negotiate -Credential $cred0 -Server $MyDomainController -Filter * | Select-Object -Property *

## Get All Groups
Get-ADGroup -Filter * -Credential $cred0 -Server $MyDomainController | Select-Object SamAccountName, objectClass, GroupCategory, GroupScope | ft -AutoSize | Out-String -Width 4096

## Get All Members of the Group Administrators
Get-ADGroupMember -Identity "Администраторы" -Server $MyDomainController -Credential $cred0 | Select-Object objectClass, SamAccountName | Format-Table

# Get Groups where Member Администратор
Get-ADPrincipalGroupMembership -Server $MyDomainController -Credential $cred0 Администратор | Select-Object name, objectClass, SamAccountName | Format-Table

# Get All E-mail Addresses
Get-ADUser -filter * -properties EmailAddress -Server $MyDomainController -Credential $cred0 | select-object Name, EmailAddres

# Get Info about UserAccounts
Get-ADUser -filter * -properties * -Server $MyDomainController -Credential $cred0 | select-object Name, Enabled, emailaddress, officephone, homephone, mobilephone, ipphone, fax

# Get Mail and Phone of Valid Accounts
Get-ADUser -filter * -properties * -Server $MyDomainController -Credential $cred0 | Where-Object -Property Enabled -eq $True | select-object Name, GivenName, Surname, emailaddress, homephone, mobilephone | ft

