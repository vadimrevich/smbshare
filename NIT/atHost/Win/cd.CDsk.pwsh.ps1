###########################################################
# cd.CDsk.pwsh.ps1
# This Script will Jump to Common Desktop folder
###########################################################

#### Set a Variable
$CMDFOLDER = [Environment]::GetFolderPath("CommonDesktopDirectory")

#### Run Payload
#
Push-Location -Path $CMDFOLDER
