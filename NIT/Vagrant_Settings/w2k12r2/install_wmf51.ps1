#This script is only tested against and should only run on 2012R2 systems.
#There are caveats and issues upgrading from WMF 3 to 5 on 2008R2/Win7 that
#this script does not consider due to classroom environment being 2012R2.

 Function InstallMSU ($ProgName,$MSU,$Switches) {  
      $EXE = $Env:windir+"\system32\wusa.exe"  
      $Parameters = [char]34+$MSU+[char]34+[char]32+$Switches  
      Write-Host "Install "$ProgName"....." -NoNewline  
      $ErrCode = (Start-Process -FilePath $EXE -ArgumentList $Parameters -Wait -Passthru).ExitCode  
      If (($ErrCode -eq 0) -or ($ErrCode -eq 3010)) {  
           Write-Host "Success" -ForegroundColor Yellow  
      } elseif ($ErrCode -eq 2359302) {  
           Write-Host "Already Installed" -ForegroundColor Green  
      } else {  
           Write-Host "Failed with error code "$ErrCode -ForegroundColor Red  
           $Global:Errors++  
      }  
 }  
   
 Function ExitPowerShell {  
      If (($Global:Errors -ne $null) -and ($Global:Errors -ne 0)) {  
           Exit 1  
      }
      else {
        Exit 0
      }
 }

 Function CheckPowershellVersion {
    $aPSMajorVarsion = $PSVersionTable.PSVersion.Major
    $aPSMinorVersion = $PSVersionTable.PSVersion.Minor
    $aPSVersion = $aPSMajorVarsion.ToString() + "." + $aPSMinorVersion.ToString()
    Write-Host "A PowerShell Version is $aPSVersion"
    if( $aPSVersion -ge "5.1" ) {
        Write-Host "Needed Version of Powershell is already Installed"
        return $true
    }
    else {
        Write-Host "Install a New PowerShell Version..."
        return $false
    }
 }
 

#Modifiable variables are below. Update these as needed to match the WMF
#you want to have installed. Only update the DownloadUrl if Microsoft changes path.
$wmfInstallerFile = 'Win8.1AndW2K12R2-KB3191564-x64.msu'
$wmfDownloadUrl = "http://file.netip4.ru/WinUpdate/WindowsMainUpdate/Win8.1x64/WinMF5.1/$wmfInstallerFile"

$wmfPath = 'c:\temp'
$wmfInstaller = Join-Path $wmfPath $wmfInstallerFile

Write-Output 'Setting up WMF 5.1...'

if( CheckPowershellVersion ) {
    Exit 2
}

if (!(Test-Path $wmfPath)) {
  Write-Output "Creating folder `'$wmfPath`'"
    $null = New-Item -Path "$wmfPath" -ItemType Directory
}

if (!(Test-Path $wmfInstaller)) {
  Write-Output "Downloading `'$wmfDownloadUrl`' to `'$wmfInstaller`'"
    (New-Object Net.WebClient).DownloadFile("$wmfDownloadUrl","$wmfInstaller")
}
Write-Output "Installing WMF 5.1 ..."
# & $wmfInstaller /quiet /norestart

InstallMSU "Windows Management Framework 5.1" $wmfInstaller "/quiet /norestart"  
Start-Sleep -Seconds 5  
ExitPowerShell 