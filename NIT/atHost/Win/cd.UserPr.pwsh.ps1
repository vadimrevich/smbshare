###########################################################
# cd.UserPr.pwsh.ps1
# This Script will Jump to UserProfile folder
###########################################################

#### Set a Variable
$CMDFOLDER=$env:UserProfile

#### Run Payload
#
cd $CMDFOLDER
