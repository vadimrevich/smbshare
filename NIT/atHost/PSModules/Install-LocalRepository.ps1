# Define local gallery settings
$localGallery = '__LocalGallery__'
$galleryPath = 'C:\LocalPowerShellGallery'

# Create the gallery directory if it doesn't exist
if (-not(Test-Path $galleryPath)) {
    Write-Host "Creating local gallery directory: $galleryPath" -ForegroundColor Yellow
    $null = New-Item -Path $galleryPath -ItemType Directory
}

# Register the local repository
Write-Host "Registering local PowerShell repository: $localGallery" -ForegroundColor Green

# Register a file share on my local machine
$registerPSRepositorySplat = @{
    Name = $localGallery
    SourceLocation = $galleryPath
    ScriptSourceLocation = $galleryPath
    InstallationPolicy = 'Trusted'
}
$null = Register-PSRepository @registerPSRepositorySplat

### Check Installation
# Display all registered repositories
Get-PSRepository

#### Load Package
