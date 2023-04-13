$vmParams = @{
  NameSpace = 'Root\Virtualization\v2';
  Query = 'SELECT * FROM Msvm_KvpExchangeComponent' #pulls VM WMI object ExchangeComponents
}

Get-WmiObject @vmParams |
  % {
    $xml = [Xml]"<properties>$($_.GuestIntrinsicExchangeItems)</properties>"
    $xml.properties.INSTANCE.Property |
      % {
        $value = ($_.ParentNode.Property | ? { $_.Name -eq 'Data' }).VALUE
        if ($_.Value -eq 'FullyQualifiedDomainName')
        {
          Write-Host "Host: $($value)"
        }
        if ($_.Value -eq 'RDPAddressIPv4')
        {
          Write-Host "RDP Address: $($value)"
        }
      }
  }