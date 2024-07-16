#####
# NIT-Ms.NetworkSharingCenter.ps1
# Open Microsoft Network and Sharing Center Settings
#####

### Set a variables

# $MyScript=[Environment]::GetCommandLineArgs()[0]
$MyScript=$MyInvocation.InvocationName

# Run Payload....
control.exe /name Microsoft.NetworkandSharingCenter

# End
Write-Host "The End of the Script $MyScript"
Exit 0
