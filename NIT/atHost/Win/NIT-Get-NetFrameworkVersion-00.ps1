function Get-DotNetVersionByFs {
  <#
    .SYNOPSIS
      NOT RECOMMENDED - try using instead:
        Get-DotNetVersion 
          from DotNetVersionLister module (https://github.com/EliteLoser/DotNetVersionLister), 
          but it is not usable/importable in PowerShell 2.0 
        Get-DotNetVersionByReg
          reg(istry) based: (available herin as well) but it may return some wrong version or may not work reliably for versions > 4.5 
          (works in PSv2.0)
      Get-DotNetVersionByFs (this):  
        f(ile) s(ystem) based: determines the latest installed .NET version based on $Env:windir\Microsoft.NET\Framework content
        this is unreliable, e.g. if 4.0* is already installed some 4.5 update will overwrite content there without
        renaming the folder
        (works in PSv2.0)
    .EXAMPLE
      PS> Get-DotnetVersionByFs
      4.0.30319
    .EXAMPLE
      PS> Get-DotnetVersionByFs -All
      1.0.3705
      1.1.4322
      2.0.50727
      3.0
      3.5
      4.0.30319
    .NOTES
      from https://stackoverflow.com/a/52078523/1915920
  #>
    [cmdletbinding()]
  param(
    [Switch]$All  ## do not return only latest, but all installed
  )
  $list = ls $Env:windir\Microsoft.NET\Framework |
    ?{ $_.PSIsContainer -and $_.Name -match '^v\d.[\d\.]+' } |
    %{ $_.Name.TrimStart('v') }
  if ($All) { $list } else { $list | select -last 1 }
}


function Get-DotNetVersionByReg {
  <#
    .SYNOPSIS
      NOT RECOMMENDED - try using instead:
        Get-DotNetVersion
          From DotNetVersionLister module (https://github.com/EliteLoser/DotNetVersionLister), 
          but it is not usable/importable in PowerShell 2.0. 
          Determines the latest installed .NET version based on registry infos under 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP'
    .EXAMPLE
        PS> Get-DotnetVersionByReg
        4.5.51209
    .EXAMPLE
        PS> Get-DotnetVersionByReg -AllDetailed
        PSChildName                                          Version                                             Release
        -----------                                          -------                                             -------
        v2.0.50727                                           2.0.50727.5420
        v3.0                                                 3.0.30729.5420
        Windows Communication Foundation                     3.0.4506.5420
        Windows Presentation Foundation                      3.0.6920.5011
        v3.5                                                 3.5.30729.5420
        Client                                               4.0.0.0
        Client                                               4.5.51209                                           379893
        Full                                                 4.5.51209                                           379893
    .NOTES
      from https://stackoverflow.com/a/52078523/1915920
  #>
    [cmdletbinding()]
    param(
        [Switch]$AllDetailed  ## do not return only latest, but all installed with more details
    )
    $Lookup = @{
        378389 = [version]'4.5'
        378675 = [version]'4.5.1'
        378758 = [version]'4.5.1'
        379893 = [version]'4.5.2'
        393295 = [version]'4.6'
        393297 = [version]'4.6'
        394254 = [version]'4.6.1'
        394271 = [version]'4.6.1'
        394802 = [version]'4.6.2'
        394806 = [version]'4.6.2'
        460798 = [version]'4.7'
        460805 = [version]'4.7'
        461308 = [version]'4.7.1'
        461310 = [version]'4.7.1'
        461808 = [version]'4.7.2'
        461814 = [version]'4.7.2'
    }
    $list = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse |
        Get-ItemProperty -name Version, Release -EA 0 |
        # For One True framework (latest .NET 4x), change match to PSChildName -eq "Full":
        Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} |
        Select-Object `
           @{
               name = ".NET Framework" ; 
               expression = {$_.PSChildName}}, 
           @{  name = "Product" ; 
               expression = {$Lookup[$_.Release]}}, 
           Version, Release
    if ($AllDetailed) { $list | sort version } else { $list | sort version | select -last 1 | %{ $_.version } }
}

Write-Host "Get All dotNet versions by FS"
Get-DotNetVersionByFs -All
Write-Host "Get All dotNet versions by Registry"
Get-DotNetVersionByReg -AllDetailed
