#####
# NIT-Start-MyKeeneticWeb.ps1
#####

### Set a variables

# $MyScript=[Environment]::GetCommandLineArgs()[0]
$MyScript=$MyInvocation.InvocationName

$anURLString="https://technic.keenetic.link/login#goto=%2Fdashboard"

# Run Payload....

& start $anURLString

# End
Write-Host "The End of the Script $MyScript"
Write-Host "The URL $anURLString is Opened"
Exit 0
