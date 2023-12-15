###
# RunSelect-UICulture.ps1
# This Script will Select a Script to be Run 
# with Windows UI Culture
####

# Get a Variable
$LCIDCulture=$(Get-UICulture).LCID

### Choose Script
if( $LCIDCulture -eq 1033 ) {
    # English Version of Culture
    Write-Host "English Version of the Windows"
}
elseif( $LCIDCulture -eq  1049) {
    # Russian Version of Culture
    Write-Host "Русская версия Windows"
}
else {
    Write-Host "Unknown Culture of the Windows"
}
