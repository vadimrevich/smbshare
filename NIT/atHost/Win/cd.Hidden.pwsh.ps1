###########################################################
# cd.Hidden.pwsh.ps1
# This Script will Jump to User Desktop folder
###########################################################

#### Set a Variable
$CMDFOLDER1 = (New-Object -ComObject Shell.Application).NameSpace('shell:Desktop').Self.Path
$CMDFOLDER = Join-Path -Path $CMDFOLDER1 -ChildPath 'Hidden'

#### Run Payload
#
Push-Location -Path $CMDFOLDER
