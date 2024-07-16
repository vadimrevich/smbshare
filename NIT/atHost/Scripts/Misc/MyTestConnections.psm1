function Test-Port000 
{
[CmdletBinding()]
    param
    (
        [string[]]$Hostname='localhost',
        [int]$Port='80',
        [int]$Timeout='1000'
    )

    foreach ($h in $Hostname)
        { 
            $tab = "`t"
            $requestCallback = $state = $null 
            $client = New-Object System.Net.Sockets.TcpClient 
            $beginConnect = $client.BeginConnect($h, $Port, $requestCallback, $state) 
            Start-Sleep -milli $Timeout 

            if ($client.Connected) 
                { 
                    Write-Host $h':'$Port -ForegroundColor Green
                } 
            else 
                { 
                    Write-Host $h':'$Port -ForegroundColor Red
                } 
            $client.Close() 
        } 
}

function Check-Ports000 
{
[CmdletBinding()]
    param
    (
        [string[]]$Hostname='localhost',
        [int[]]$Port=1..1000,
        [int]$Timeout='300'
    )
        
     foreach ($h in $Hostname)
     {
        foreach ($p in $Port)    
        { 
            $requestCallback = $state = $null 
            $client = New-Object System.Net.Sockets.TcpClient 
            $beginConnect = $client.BeginConnect($h, $p, $requestCallback, $state) 
            Start-Sleep -milli $Timeout

            if ($client.Connected) 
                { 
                    Write-Host $h':'$p -ForegroundColor Green
                }
            $client.Close()
        }   
    }
}

#Allow run powershell scripts for current user
Set-ExecutionPolicy Unrestricted -Scope CurrentUser

#Get subnet calculator powershell function
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#$URL = "https://gallery.technet.microsoft.com/scriptcenter/PowerShell-Subnet-db45ec74/file/141596/2/Get-IPs.ps1"
#$Path = "$env:HOMEPATH\Get-IPs.ps1"
#(New-Object System.Net.WebClient).DownloadFile($URL, $Path)
#. $Path

function Ping-Hosts000 
{

[CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [array]$Subnet
    )

    #Define subnet and ping hosts
    $Subnet = Get-IPs -Subnets $Subnet
    Write-Host "OK. Ping hosts in subnets starting. Be patient."
    foreach ($h in $Subnet)
        {
            $result = Test-Connection -Count 1 -ComputerName $h -ErrorAction SilentlyContinue
            if ($result)
                {
                    Write-Host $h 'is Online' -ForegroundColor Green 
                }
        }
}