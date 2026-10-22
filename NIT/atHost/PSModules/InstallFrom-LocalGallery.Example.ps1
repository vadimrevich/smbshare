# Install a specific module
Install-Module -Name 'Microsoft.Entra.Authentication' -Repository $localGallery -AllowClobber -Verbose

# Define the modules to install
$entraModules = @(
    "Microsoft.Entra.Authentication",
    "Microsoft.Entra.Applications",
    "Microsoft.Entra.DirectoryManagement",
    "Microsoft.Entra.Groups",
    "Microsoft.Entra.Governance",
    "Microsoft.Entra.SignIns",
    "Microsoft.Entra.Users",
    "Microsoft.Entra.Reports",
    "Microsoft.Entra.CertificateBasedAuthentication"
)

# Install each module from the local gallery
foreach ($moduleName in $entraModules) {
    Write-Host "[Local Gallery] Installing: $moduleName" -ForegroundColor Green
    Install-Module -Name $moduleName -Repository $localGallery -AllowClobber -Verbose
}
