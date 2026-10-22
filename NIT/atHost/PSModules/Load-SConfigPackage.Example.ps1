# Publish to a file share repo - the NuGet API key must be a non-blank string

$aNupkgModule="SCONFIG"
$aNupkgFile="sconfig.2.0.1.nupkg"
$DnldF=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$localGallery = '__LocalGallery__'
$galleryPath = 'C:\LocalPowerShellGallery'

$aNupkgPath=Join-Path -Path $galleryPath  -ChildPath $aNupkgModule
if( -not (Test-Path -Path $aNupkgPath -PathType Container)) {
    Write-Host "NuPkg Directory $aNupkgPath is not found"
}
else {
    $publishModuleSplat = @{
        Path = $aNupkgPath
        Repository = $localGallery
        NuGetApiKey = 'AnyStringWillDo'
    }
    Publish-Module @publishModuleSplat
}


