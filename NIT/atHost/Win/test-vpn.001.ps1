1..254 | ForEach-Object {
    $ip = "10.8.1.$_"
    Test-Connection -ComputerName $ip -Count 1 -Quiet
} | Where-Object { $_.ResponseStatus -eq "Success" } | ForEach-Object {
    "IP: $_, Время отклика: $($_.ResponseTime) мс"
}
