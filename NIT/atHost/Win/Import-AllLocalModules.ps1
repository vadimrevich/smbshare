# My Download Modules

$MyPublishModules = @(
	"SCONFIG",
	"Posh-SSH",
	"ps2exe",
	"PSHyperVTools",
	"PSSQlite",
	"WSManTrust",
	"Microsoft.Graph.DirectoryObjects",
    	"Microsoft.Graph.Users",
    	"Microsoft.Graph.Users.Actions",
    	"Microsoft.Graph.Groups",
    	"Microsoft.Graph.Identity.DirectoryManagement",
    	"Microsoft.Graph.Identity.Governance",
    	"Microsoft.Graph.Identity.SignIns",
    	"Microsoft.Graph.Applications",
    	"Microsoft.Graph.Reports",
	"ImpersonateSystem",
	"NTLMX",
	"AdminToolbox",
	"AdminToolbox.ActiveDirectory",
	"AdminToolbox.EndpointManagement",
	"AdminToolbox.Exchange",
	"AdminToolbox.FFTools",
	"AdminToolbox.FileManagement",
	"AdminToolbox.FortiWizard",
	"AdminToolbox.Fun",
	"AdminToolbox.MSGraph",
	"AdminToolbox.Networking",
	"AdminToolbox.Office365",
	"AdminToolbox.Remoting",
	"AdminToolbox.SecOps",
	"AdminToolbox.VMWareAutomate",
	"Hosts",
	"ImportExcel",
	"Microsoft.PowerShell.Operation.Validation",
	"PackageManagement",
	"Pester",
	"posh-sshell",
	"PoshNmap",
	"PowerShellGet",
	"PSEventViewer",
	"PSReadLine",
	"PSWindowsUpdate",
	"SSH-Copy-ID",
	"WinSSH"
)
# Install each module from the local gallery
foreach ($moduleName in $MyPublishModules) {
    Write-Host "[Local Gallery] Importing: $moduleName" -ForegroundColor Green
    Import-Module -Name $moduleName -Verbose -DisableNameChecking
}

### Install Some Others
Get-Module -ListAvailable | Import-Module -Verbose -DisableNameChecking

