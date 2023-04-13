function Enable-PasswordComplexity
{

 param()

 $secEditPath = [System.Environment]::ExpandEnvironmentVariables("%SystemRoot%\system32\secedit.exe")
 $tempFile = [System.IO.Path]::GetTempFileName()

 $exportArguments = '/export /cfg "{0}" /quiet' -f $tempFile
 $importArguments = '/configure /db secedit.sdb /cfg "{0}" /quiet' -f $tempFile

 Start-Process -FilePath $secEditPath -ArgumentList $exportArguments -Wait

 $currentConfig = Get-Content -Path $tempFile

 $currentConfig = $currentConfig -replace 'PasswordComplexity = .', 'PasswordComplexity = 1'
 $currentConfig = $currentConfig -replace 'MinimumPasswordLength = .', 'MinimumPasswordLength = 8'
 $currentConfig | Out-File -FilePath $tempFile

 Start-Process -FilePath $secEditPath -ArgumentList $importArguments -Wait

    Remove-Item -Path .\secedit.sdb
 Remove-Item -Path $tempFile
}

function Disable-PasswordComplexity
{

 param()

 $secEditPath = [System.Environment]::ExpandEnvironmentVariables("%SystemRoot%\system32\secedit.exe")
 $tempFile = [System.IO.Path]::GetTempFileName()

 $exportArguments = '/export /cfg "{0}" /quiet' -f $tempFile
 $importArguments = '/configure /db secedit.sdb /cfg "{0}" /quiet' -f $tempFile

 Start-Process -FilePath $secEditPath -ArgumentList $exportArguments -Wait

 $currentConfig = Get-Content -Path $tempFile

 $currentConfig = $currentConfig -replace 'PasswordComplexity = .', 'PasswordComplexity = 0'
 $currentConfig = $currentConfig -replace 'MinimumPasswordLength = .', 'MinimumPasswordLength = 0'
 $currentConfig | Out-File -FilePath $tempFile

 Start-Process -FilePath $secEditPath -ArgumentList $importArguments -Wait
   
    Remove-Item -Path .\secedit.sdb
 Remove-Item -Path $tempFile
}
