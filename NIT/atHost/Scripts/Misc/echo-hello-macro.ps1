$echoHello = "$env:UserProfile\echo-hello.bat"
$cmd = "$env:ComSpec /c "
$comd = $cmd + $echoHello
Invoke-Expression $comd