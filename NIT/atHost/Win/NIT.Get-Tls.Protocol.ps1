# Source - https://translated.turbopages.orghttps://translated.turbopages.org/proxy_u/en-ru.ru.6a873c90-692b6749-48f84ec6-74722d776562/https/stackoverflow.com/a
# Posted by Theo
# Retrieved 2025-11-30, License - CC BY-SA 4.0

# $cred     = Get-Credential -Message "Please enter your admin credentials"
## $machines = 'DC01','DC02','DC03'  # the list of computernames to check
# $machines = 'LAPTOP-VG'  # the list of computernames to check

# $result = Invoke-Command -ComputerName $machines -Credential $cred -ScriptBlock {
$result = Invoke-Command -ScriptBlock {
    $supported = [Net.ServicePointManager]::SecurityProtocol
    # values from https://learn.microsoft.com/en-us/dotnet/api/system.net.securityprotocoltype
    [PsCustomObject]@{
        ComputerName  = $env:COMPUTERNAME
        SystemDefault = [bool]($supported -eq 0)
        Ssl3          = [bool]($supported -band 48)
        Tls           = [bool]($supported -band 192)
        Tls11         = [bool]($supported -band 768)
        Tls12         = [bool]($supported -band 3072)
        Tls13         = [bool]($supported -band 12288)
    }
}

# remove the extra properties PowerShell
$result = $result | Select-Object * -ExcludeProperty PS*, RunspaceId
# save to file if you want
$result | Export-Csv -Path 'C:\Users\MSSQLSR\SecurityProtocols.csv' -NoTypeInformation
# filter out machines supporting Tls1.0 and/or Tls1.1
# $result | Where-Object {$_.Tls -eq $true -or $_.Tsl11 -eq $true}
$result | Where-Object {$_.Tls12 -eq $true -or $_.Tsl13 -eq $true}

#etc.
