###########################################################
# cd.CProg.pwsh.ps1
# This Script will Jump to Common Programs folder
###########################################################

#### Set a Variable
$CMDFOLDER = [Environment]::GetFolderPath("CommonPrograms")

#### Run Payload
#
Push-Location -Path $CMDFOLDER
