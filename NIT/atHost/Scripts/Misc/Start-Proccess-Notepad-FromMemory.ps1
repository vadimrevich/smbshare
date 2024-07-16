$process = Get-Content $env:SystemRoot\notepad.exe
Start-Process $process -WindowStyle Normal