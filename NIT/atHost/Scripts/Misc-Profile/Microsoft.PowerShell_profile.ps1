# function subl { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

set-alias vim "C:/tools/Vim/vim90/.\vim.exe"
# set-alias nano "C:/ProgramData/chocolatey/bin/.\nano.exe"

# Users
$User_yuden = "yuden"
$User_vagrant = "vagrant"
$User_Admin = "Admin"
$User_user = "user"
$User_MSSQLSR = "MSSQLSR"
$User_Administrator = "�������������"
$Domain_AdministratorTest = "Peter\�������������"

# Passwords
$PlPass_yuden = "0a9s8d7F"
$PlPass_Admin = "0A9s8d7F"
$PlPass_MSSQLSR = "Admin01234"
$PlPass_vagrant = "vagrant"

# Hosts
$Server_home_host = "SERVER-HOME"
$Raspberrypi_host = "RASPBERRYPI"
$Raspberrypi4_host = "RASPBERRYPI4"

# Secure Passwords
$SecPass_yuden = ConvertTo-SecureString -AsPlainText $PlPass_yuden -Force
$SecPass_Admin = ConvertTo-SecureString -AsPlainText $PlPass_Admin -Force
$SecPass_MSSQLSR = ConvertTo-SecureString -AsPlainText $PlPass_MSSQLSR -Force
$SecPass_vagrant = ConvertTo-SecureString -AsPlainText $PlPass_vagrant -Force

# Credentials
# $Cred_yuden_home_yuden = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_yuden,$SecPass_Admin
$Cred_server_home_Admin = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_yuden,$SecPass_Admin
$Cred_server_home_vagrant = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_vagrant,$SecPass_yuden

$cred0 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_Administrator,$SecPass_Admin
$cred1 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_vagrant,$SecPass_vagrant
$cred2 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_user,$SecPass_Admin
$cred4 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_vagrant,$SecPass_yuden
$cred3 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User_MSSQLSR,$SecPass_MSSQLSR
$credDomTest = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Domain_AdministratorTest,$SecPass_Admin

# Working Catalog
cd $env:UserProfile
# function subl { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }
