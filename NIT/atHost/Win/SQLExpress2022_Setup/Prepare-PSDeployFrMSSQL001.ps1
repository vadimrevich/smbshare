#### Set A Variables

### Set a Directory
#
$MainDownloadDirectory="C:\Downloads"
$MainInstFilesDir=Join-Path -Path $env:USERPROFILE -ChildPath "SQLExpress2022_Setup"

#### Set a Filed
##
$MSSQLFIleName="SQL2022-SSEI-Expr.exe"
$MSSQLINSTFilePath=Join-Path -Path $MainDownloadDirectory -ChildPath $MSSQLFIleName
$MSSQLFIleNameRUS="SQLEXPR_x64_RUS.exe"
### Set SQLEXPR_x64_RUS.exe and "SQLEXPR_2022" Path
#
$MSSQLINSTPath01=Join-Path -Path $MainDownloadDirectory -ChildPath "SQLEXPR_2022"
$MSSQLINSTFilePathRUS01=Join-Path -Path $MainDownloadDirectory -ChildPath $MSSQLFIleNameRUS
### Set Setup.EXE File Path
$MSSQLINSTFilePathRUS02=Join-Path -Path $MSSQLINSTPath01 -ChildPath "SETUP.EXE"
$MSSQLInstConfigPathInit=Join-Path -Path $MainInstFilesDir -ChildPath "ConfigurationFile.ini"
$MSSQLUninstConfigPathInit=Join-Path -Path $MainInstFilesDir -ChildPath "ConfigurationFile-un.ini"

### Make Directories
#
if( !(Test-Path $MainDownloadDirectory)) {
    Write-Host( "Creating " + $MainDownloadDirectory +"...")
    mkdir $MainDownloadDirectory
}

### Download a File

if( !(Test-Path $MSSQLINSTPath01) ) {
#if( $true ) {
    
    #### Delete Old Files ####
    #
    if( Test-Path $MSSQLINSTFilePath ) {
        Remove-Item -Path $MSSQLINSTFilePath
    }
    if( Test-Path $MSSQLINSTFilePathRUS01 ){
        Remove-Item -Path $MSSQLINSTFilePathRUS01
    }
    
    ### Download SQLSERVER SQL2022-SSEI-Expr.exe
    Invoke-WebRequest -Uri "https://download.microsoft.com/download/5/1/4/5145fe04-4d30-4b85-b0d1-39533663a2f1/SQL2022-SSEI-Expr.exe" -OutFile $MSSQLINSTFilePath

    ### Download SQLEXPR_x64_RUS.exe
    # & $MSSQLINSTFilePath /ACTION=Download MEDIAPATH=$MainDownloadDirectory /MEDIATYPE=Core /QUIET
    Start-Process -FilePath $MSSQLINSTFilePath -ArgumentList "/ACTION=Download MEDIAPATH=$MainDownloadDirectory /MEDIATYPE=Core /QUIET" -Wait -NoNewWindow -PassThru
    
    ### Extract Setup Files
    #
    # & $MSSQLINSTFilePathRUS01 /q /x:$MSSQLINSTPath01
    Start-Process -FilePath $MSSQLINSTFilePathRUS01 -ArgumentList "/q /x:$MSSQLINSTPath01" -Wait -NoNewWindow -PassThru

    ### Setup Some Changes
    #
    ## & SETUP.EXE /UIMODE=Normal /ACTION=INSTALL

    ## Set All Passwords
    # & $MSSQLINSTFilePathRUS02 /SQLSVCPASSWORD="0a9s8d7F" /AGTSVCPASSWORD="0a9s8d7F" /ASSVCPASSWORD="0a9s8d7F" /ISSVCPASSWORD="0a9s8d7F" /RSSVCPASSWORD="0a9s8d7F" /ConfigurationFile=$MSSQLInstConfigPath
    # & $MSSQLINSTFilePathRUS02 /ConfigurationFile=ConfigurationFile.ini

    #### Copy Setup Files
    #
    Copy-Item -Path $MSSQLInstConfigPathInit -Destination $MSSQLINSTPath01
    Copy-Item -Path $MSSQLUninstConfigPathInit -Destination $MSSQLINSTPath01
}

Set-Location $MainInstFilesDir
