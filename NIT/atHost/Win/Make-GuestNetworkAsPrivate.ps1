$NLMType = [Type]::GetTypeFromCLSID('DCB00C01-570F-4A9B-8D69-199FDBA5723B')
$INetworkListManager = [Activator]::CreateInstance($NLMType)
$NLM_ENUM_NETWORK_CONNECTED  = 1
$NLM_NETWORK_CATEGORY_PUBLIC = 0x00
$NLM_NETWORK_CATEGORY_PRIVATE = 0x01
$NLM_NETWORK_CATEGORY_DOMAIN = 0x02
$UNIDENTIFIED = "Unidentified network"
$INetworks = $INetworkListManager.GetNetworks($NLM_ENUM_NETWORK_CONNECTED)
foreach ($INetwork in $INetworks)
{
	$Name = $INetwork.GetName()
	$Category = $INetwork.GetCategory()
	$CategoryName = switch ($Category){
		$NLM_NETWORK_CATEGORY_PUBLIC {'Public'}
		$NLM_NETWORK_CATEGORY_PRIVATE {'Private'}
		$NLM_NETWORK_CATEGORY_DOMAIN {'Domain'} 
		Default {$Category}
	}
	Write-Host "Network named: $Name is of type: $CategoryName"
	if ($INetwork.IsConnected -and ($Category -eq $NLM_NETWORK_CATEGORY_PUBLIC) -and ($Name -eq $UNIDENTIFIED))
	{
		Write-Host "Changing network $Name to Private"
		$INetwork.SetCategory($NLM_NETWORK_CATEGORY_PRIVATE)
	}
}

[Environment]::Exit(0)