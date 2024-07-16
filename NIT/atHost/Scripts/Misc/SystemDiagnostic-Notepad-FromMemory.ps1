$cmd = $env:SystemRoot + "\notepad.exe"
$process = Get-Content $cmd
$ps = New-Object System.Diagnostics.Process
$pssinfo = New-Object System.Diagnostics.ProcessStartInfo
$pssinfo.FileName = $process
$pssinfo.UseShellExecute = $true
$pssinfo.WindowStyle = Hidden
$ps.StartInfo = $pssinfo
$ps.Start()
$ps.WaitForExit()
