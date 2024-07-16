#This assumes you've already created a PowerShell Remoting session
#You must use a PSSession

#get the locally loaded function	
$f = $(get-item function:\Get-Foo).scriptblock

#copy it to the remote session
Invoke-Command { New-Item -Name Get-Foo -Path Function: -Value $($using:f)} -session $s

#now you can use it remotely
Invoke-Command { Get-Foo } -session $s