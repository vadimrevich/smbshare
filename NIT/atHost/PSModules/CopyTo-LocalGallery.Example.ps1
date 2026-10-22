# Copy nupkg files to the local gallery
# Replace 'C:\Downloads' with the actual path where you downloaded the files
$downloadPath = 'C:\Downloads'
$nupkgFiles = Get-ChildItem -Path $downloadPath -Filter "Microsoft.Entra*.nupkg"

foreach ($file in $nupkgFiles) {
    Write-Host "Copying $($file.Name) to local gallery" -ForegroundColor Cyan
    Copy-Item -Path $file.FullName -Destination $galleryPath -Force
}
