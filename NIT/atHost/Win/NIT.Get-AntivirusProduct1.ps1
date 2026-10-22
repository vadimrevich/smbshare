param (
    [Parameter (Mandatory=$false,Position=0)]
    [CimSession[]] $CimSession
)
################
# NIT.Get-AntivirusProduct1.ps1
# Get AntiVirus Product info Using Cim-Instance
################

### Functions

function Get-AntiVirusProduct {
    [CmdletBinding()]
    param (
        [Parameter (Mandatory=$false,Position=0)]
        [CimSession[]] $CimSession
    )
    if($PSBoundParameters.ContainsKey("CimSession")){
        Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiVirusProduct -CimSession $CimSession
    }
    else {
        Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiVirusProduct
    }
}

function Get-AntiSpywareProduct {
    [CmdletBinding()]
    param (
        [Parameter (Mandatory=$false,Position=0)]
        [CimSession[]] $CimSession
    )
    if($PSBoundParameters.ContainsKey("CimSession")){
        Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiSpywareProduct -CimSession $CimSession
    }
    else {
        Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiSpywareProduct 
    }
}

function Get-SecurityCenter2Classes {
    [CmdletBinding()]
    param (
        [Parameter (Mandatory=$false,Position=0)]
        [CimSession[]] $CimSession
    )
    if($PSBoundParameters.ContainsKey("CimSession")){
        Get-CimClass -Namespace root\SecurityCenter2 -CimSession $CimSession
    }
    else {
        Get-CimClass -Namespace root\SecurityCenter2
    }
}



## Run Payload

# Get-CimClass -Namespace root\SecurityCenter2

# Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiVirusProduct
# Get-CimInstance -Namespace root\SecurityCenter2 -Class AntiVirusProduct -ComputerName localhost

# Get-SecurityCenter2Classes -CimSession $CimSession
# Get-AntiSpywareProduct -CimSession $CimSession
# Get-AntiVirusProduct -CimSession $CimSession
Get-AntiVirusProduct