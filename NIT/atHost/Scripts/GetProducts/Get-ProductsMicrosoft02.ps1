#Get-WMIObject -Class Win32_Product | Where-Object {$_.Vendor -Match "New Internet"} | Select-Object -Property Name, IdentifyingNumber, Vendor, Version | Sort-Object Name

function isRegistryNode
{
    param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]$Path
        )
    try
    {
        Get-ItemProperty -Path $Path -ErrorAction Stop | Out-Null
        return $true
    }
    catch
    {
        return $false
    }
}
$Path="HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
$ValueMatch="Microsoft "
$ValueFile=".\" + $ValueMatch + ".txt"
if( isRegistryNode -Path $Path )
{
    Get-ChildItem  $Path  | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Where-Object {$_.Publisher -match $ValueMatch} | Out-File -FilePath $ValueFile -Encoding String -Width 2048
}
$Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
if( isRegistryNode -Path $Path )
{
    Get-ChildItem  $Path  | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Where-Object {$_.Publisher -match $ValueMatch} | Out-File -FilePath $ValueFile -Encoding String -Width 2048 -Append
}
$Path="HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
if( isRegistryNode -Path $Path )
{
    Get-ChildItem  $Path  | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Where-Object {$_.Publisher -match $ValueMatch} | Out-File -FilePath $ValueFile -Encoding String -Width 2048 -Append
}
$Path="HKCU:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
if( isRegistryNode -Path $Path )
{
    Get-ChildItem  $Path  | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Where-Object {$_.Publisher -match $ValueMatch} | Out-File -FilePath $ValueFile -Encoding String -Width 2048 -Append
}
