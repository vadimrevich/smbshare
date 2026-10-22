###########################################################
# cd.Dsk.pwsh.ps1
# This Script will Jump to User Desktop folder
###########################################################

#### Set a Variable
$CMDFOLDER = (New-Object -ComObject Shell.Application).NameSpace('shell:Desktop').Self.Path

#### Run Payload
#
Push-Location -Path $CMDFOLDER
