function isRegistryValueMatch
{
    param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]$Path,
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]$ValueMatch
        )
    try
    {
        Get-ChildItem -Path $Path | Where-Object {$_.Name -match $ValueMatch} -ErrorAction Stop | Out-Null
        return $true
    }
    catch
    {
        return $false
    }
}
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
$ValueMatch="Avast"
$ValueFile=".\" + $ValueMatch + ".txt"
if( isRegistryNode -Path $Path )
{
    if( isRegistryValueMatch -Path $Path -ValueMatch $ValueMatch )
    {
        Get-ChildItem  $Path | Where-Object {$_.Name -match $ValueMatch} | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Out-File -FilePath $ValueFile -Encoding String -Width 2048
    }
}
$Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
if( isRegistryNode -Path $Path )
{
    if( isRegistryValueMatch -Path $Path -ValueMatch $ValueMatch )
    {
        Get-ChildItem  $Path | Where-Object {$_.Name -match $ValueMatch} | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Out-File -FilePath $ValueFile -Encoding String -Width 2048 -Append
    }
}
$Path="HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
if( isRegistryNode -Path $Path )
{
    if( isRegistryValueMatch -Path $Path -ValueMatch $ValueMatch )
    {
        Get-ChildItem  $Path | Where-Object {$_.Name -match $ValueMatch} | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Out-File -FilePath $ValueFile -Encoding String -Width 2048 -Append
    }
}
$Path="HKCU:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
if( isRegistryNode -Path $Path )
{
    if( isRegistryValueMatch -Path $Path -ValueMatch $ValueMatch )
    {
        Get-ChildItem  $Path | Where-Object {$_.Name -match $ValueMatch} | Get-ItemProperty | Select-Object -Property DisplayName, DisplayVersion, Publisher, UninstallString | Out-File -FilePath $ValueFile -Encoding String -Width 2048 -Append
    }
}