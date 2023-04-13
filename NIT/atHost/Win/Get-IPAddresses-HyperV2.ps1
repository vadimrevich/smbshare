$vm = Get-WmiObject -computerName "." -NameSpace  "Root\Virtualization\v2"   -query "SELECT * FROM Msvm_KvpExchangeComponent" #pulls VM WMI object ExchangeComponents
$vmitems = $vm.GuestIntrinsicExchangeItems 
$ipitem = $vmitems[-4]#yay! a hack that relies on XML schemas! 
$xmlip = [xml]$ipitem #convert string format to XML 
$ipaddr = $xmlip.INSTANCE.PROPERTY[1].VALUE #playing with XML schemas again hopefully reliably
Out-Host $ipaddr
