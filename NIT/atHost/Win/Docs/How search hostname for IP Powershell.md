# How search hostname for IP with Powershell

**В PowerShell на Windows по IP-адресу можно узнать имя компьютера (hostname) с помощью команды Resolve-DnsName или класса System.Net.Dns**. Оба метода выполняют обратный поиск DNS: запрашивают сервер DNS, чтобы разрешить IP-адрес в имя хоста. [sharepointdiary.com](https://www.sharepointdiary.com/2020/10/how-to-get-the-computer-name-in-powershell.html)[powershellcommands.com](https://powershellcommands.com/powershell-get-hostname-from-ip)[java2blog.com](https://java2blog.com/get-hostname-from-ip-address-powershell/)

## С помощью команды Resolve-DnsName

**Синтаксис**:

```
Resolve-DnsName -Name <IPAddress> -Type A
```

. [powershellcommands.com](https://powershellcommands.com/powershell-get-hostname-from-ip)

**Параметры**:

```
-Name
```
    
— указывает IP-адрес;

```
    -Type
```
    
— тип записи DNS (A для IPv4).

 [powershellcommands.com](https://powershellcommands.com/powershell-get-hostname-from-ip)

**Пример**:

```
Resolve-DnsName -Name '192.168.1.1' -Type A
```
    
— возвращает имя хоста, соответствующее IP-адресу. [powershellcommands.com](https://powershellcommands.com/powershell-get-hostname-from-ip)

## С помощью класса System.Net.Dns

**Метод

```
GetHostByAddress
```

**возвращает объект

```
System.Net.IPHostEntry
```

, который содержит детали о хосте. **Свойство

```
HostName
```

**объекта извлекает имя хоста. [java2blog.com](https://java2blog.com/get-hostname-from-ip-address-powershell/)

**Пример**:

```
$ipAddress = '8.8.8.8'
```
```
$hostEntry = [System.Net.Dns]::GetHostByAddress($ipAddress)
```
```
$hostname = $hostEntry.HostName
```
    
— вовращает имя хоста, соответствующее IP-адресу.

## Имя компьютера через Powershell используя WMI

Для того что бы узнать имя используя WMI можно сделать:

```
Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ipAddress
```

Более подробно WMI в Powershell [рассматривался тут](https://fixmypc.ru/post/osnovy-raboty-s-wmi-cherez-powershell/).

```powershell
$(Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ipAddress).Name
```
## :-)

```powershell
Invoke-Command -ComputerName $ipAddress -ScriptBlock {$env:computername}
```