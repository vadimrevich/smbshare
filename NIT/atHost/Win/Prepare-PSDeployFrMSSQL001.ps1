#### Set A Variables

### Set a Directory
#
$MainDownloadDirectory="C:\Downloads"
$MainPSDeployDirectory=Join-Path -Path $MainDownloadDirectory -ChildPath "PADT"
$MainMSSQLPath=Join-Path -Path $MainDownloadDirectory -ChildPath "SQLExpress2022"
$MSSQLPADTPath=Join-Path -Path $MainMSSQLPath -ChildPath "AppDeployToolkit"
$MSSQLPADTFilePath=Join-Path  -Path $MainMSSQLPath -ChildPath "Files"

#### Set a Filed
##
$PADTFileName="PSAppDeployToolkit_v3.8.4.zip"
$PADTFilePath=Join-Path -Path $MainDownloadDirectory -ChildPath $PADTFileName

$MSSQLFIleName="SQL2022-SSEI-Expr.exe"
$MSSQLINSTFilePath=Join-Path -Path $MainDownloadDirectory -ChildPath $MSSQLFIleName
$MSSQLFIleNameRUS="SQLEXPR_x64_RUS.exe"

### Make Directories
#
if( !(Test-Path $MainDownloadDirectory)) {
    Write-Host( "Creating " + $MainDownloadDirectory +"...")
    md $MainDownloadDirectory
}

if( !(Test-Path $MainPSDeployDirectory)) {
    Write-Host( "Creating " + $MainPSDeployDirectory +"...")
    md $MainPSDeployDirectory
}

if( !(Test-Path $MainMSSQLPath)) {
    Write-Host( "Creating " + $MainMSSQLPath +"...")
    md $MainMSSQLPath
}

### Download a File
if( Test-Path $PADTFilePath ) {
    ri $PADTFilePath -Force
}

if( !(Test-Path $PADTFilePath) ) {
    Invoke-WebRequest -Uri "https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/download/3.8.4/PSAppDeployToolkit_v3.8.4.zip" -OutFile $PADTFilePath 
    if( Test-Path $MainPSDeployDirectory ) {
        ri -Recurse -Force -Path $MainPSDeployDirectory
        md $MainPSDeployDirectory
    }
    Unblock-File -Path $PADTFilePath
    Expand-Archive -Path $PADTFilePath -DestinationPath $MainPSDeployDirectory
    $PADTToolkitPath=Join-Path -Path $MainPSDeployDirectory -ChildPath "Toolkit\AppDeployToolkit"
    Copy-Item -Path $PADTToolkitPath -Destination $MainMSSQLPath -Recurse
    $PADTToolkitFilePath=Join-Path -Path $MainPSDeployDirectory -ChildPath "Toolkit\Files"
    Copy-Item -Path $PADTToolkitFilePath -Destination $MainMSSQLPath

}

#if( !(Test-Path $MSSQLINSTFilePath) ) {
if( $true ) {
    
    ### Download SQLSERVER SQL2022-SSEI-Expr.exe
    Invoke-WebRequest -Uri "https://download.microsoft.com/download/5/1/4/5145fe04-4d30-4b85-b0d1-39533663a2f1/SQL2022-SSEI-Expr.exe" -OutFile $MSSQLINSTFilePath

    ### Download SQLEXPR_x64_RUS.exe
    & $MSSQLINSTFilePath /ACTION=Download MEDIAPATH=$MainDownloadDirectory /MEDIATYPE=Core /QUIET
    
    ### Set SQLEXPR_x64_RUS.exe and "SQLEXPR_2022" Path
    #
    $MSSQLINSTPath01=Join-Path -Path $MainDownloadDirectory -ChildPath "SQLEXPR_2022"
    $MSSQLINSTFilePathRUS01=Join-Path -Path $MainDownloadDirectory -ChildPath $MSSQLFIleNameRUS

    ### Extract Setup Files
    #
    & $MSSQLINSTFilePathRUS01 /q /x:$MSSQLINSTPath01

    ### Set Setup.EXE File Path
    ## Set-Location $MSSQLINSTPath01
    $MSSQLINSTFilePathRUS02=Join-Path -Path $MSSQLINSTPath01 -ChildPath "SETUP.EXE"
    $MSSQLInstConfigPath=Join-Path -Path $MainDownloadDirectory -ChildPath "ConfigurationFile.ini"

    ### Setup Some Changes
    #
    ## & SETUP.EXE /UIMODE=Normal /ACTION=INSTALL

    ## Set All Passwords
    # & $MSSQLINSTFilePathRUS02 /SQLSVCPASSWORD="0a9s8d7F" /AGTSVCPASSWORD="0a9s8d7F" /ASSVCPASSWORD="0a9s8d7F" /ISSVCPASSWORD="0a9s8d7F" /RSSVCPASSWORD="0a9s8d7F" /ConfigurationFile=$MSSQLInstConfigPath
    # & $MSSQLINSTFilePathRUS02 /ConfigurationFile=ConfigurationFile.ini
}

Set-Location $env:USERPROFILE
