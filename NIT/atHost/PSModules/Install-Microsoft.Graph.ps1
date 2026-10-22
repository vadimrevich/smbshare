## Needs VPN!

# Define the required Graph modules version
$graphModulesVersion = "2.25.0"

# List of required Graph modules
$graphModules = @(
    "Microsoft.Graph.DirectoryObjects",
    "Microsoft.Graph.Users",
    "Microsoft.Graph.Users.Actions",
    "Microsoft.Graph.Groups",
    "Microsoft.Graph.Identity.DirectoryManagement",
    "Microsoft.Graph.Identity.Governance",
    "Microsoft.Graph.Identity.SignIns",
    "Microsoft.Graph.Applications",
    "Microsoft.Graph.Reports"
)

# Install each module
foreach ($moduleName in $graphModules) {
    Write-Host "Installing Module $($moduleName)" -ForegroundColor Green
    Install-Module $moduleName -Scope CurrentUser -RequiredVersion $graphModulesVersion -Force -AllowClobber -Verbose
}
