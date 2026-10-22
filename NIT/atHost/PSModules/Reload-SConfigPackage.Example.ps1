$aNupkgModule="SCONFIG"
$DnldF=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$localGallery = '__LocalGallery__'
$galleryPath = 'C:\LocalPowerShellGallery'

# Publish from the PSGallery to your local Repository
$savePackageSplat = @{
    Name = $aNupkgModule
    ProviderName = 'NuGet'
    Source = 'https://www.powershellgallery.com/api/v2'
    Path = $galleryPath
}
Save-Package @savePackageSplat