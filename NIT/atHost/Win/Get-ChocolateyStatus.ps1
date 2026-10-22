<#
# Check Chocolatey Status Page 
# Graham Smith (gsmitheidw), 10/Oct/2018
#>

function check_detailed_status
{

# Initialise variables
$component = @()
$chocstates = @{}

    foreach ($section in $chocstatus.tostring().Split("[`r`n]")) { 
    $component += ($section | select-string 'div class="component" data-status="' -Quiet)
    }

	# Populate
	$chocstates.Add("Chocolatey.org Website", $component[0])
	$chocstates.Add("Community Package Repository", $component[1])
	$chocstates.Add("Licensed Package Repository", $component[2])
	$chocstates.Add("Package Validator", $component[3])
	$chocstates.Add("Package Verifier", $component[4])
	$chocstates.Add("Package Scanner", $component[5])
	$chocstates.Add("Boxstarter.org Website", $component[6])
	$chocstates.Add("Manage Chocolatey Packages through Boxstarter", $component[7])

    return $chocstates | Format-Table -AutoSize

}

# Retrieve content
$chocstatus = Invoke-WebRequest https://status.chocolatey.org -ErrorAction Stop

if ($chocstatus.ToString().Contains("All systems operational"))
    {
    Write-Output 'Chocolatey: All systems operational'
    }
else
    {
    check_detailed_status
    }