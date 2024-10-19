###########################################################
# cd.UserPr.pwsh.ps1
# This Script will Jump to UserProfile folder
###########################################################

#### Set a Variable
$CMDFOLDER = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

#### Run Payload
#
cd $CMDFOLDER
