Обновляем Kali Linux

```bash
sudo apt update && sudo apt dist-upgrade -y
```

Устанавливаем основные утилиты

```bash
sudo apt install -y tmux busybox git wget curl socat proxychains-ng openssl tcpdump
```
Устанавливаем Питон

```bash
sudo apt install -y python3 python3-dev python3-pip pipx
```
Устанавливаем Си

```bash
sudo apt install -y gcc make libc-dev
```

Устанавливаем Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
sudo apt install rustc cargo libssl-dev libffi-dev
```
Устанавливаем Impacket

```bash
pipx install impacket
```

Установка nmap

```bash
sudo apt install -y nmap
```

Установка OpenLDAP

```bash
sudo apt install -y ldap-utils
```

Установка BloodHound (for AD)

```bash
sudo apt install -y bloodhound
```

Установка ZeroLogin

```bash
mkdir -p ~/packages
cd ~/packages
git clone https://github.com/dirkjanm/CVE-2020-1472 zerologon
```

Установка Corercer (повышение привилегий в AD)

```bash
# git clone https://github.com/p0dalirius/Coercer
pipx install git+https://github.com/p0dalirius/Coercer
```

Библиотека работы с Kerberos

```bash
git clone https://github.com/dirkjanm/krbrelayx
```

```bash
pipx install certipy-ad
git clone https://github.com/dirkjanm/PKINITtools
```

```bash
git clone https://github.com/dirkjanm/PrivExchange
```

```bash
# git clone https://github.com/ShutdownRepo/pywhisker
pipx install git+https://github.com/ShutdownRepo/pywhisker
pipx install rich --include-deps
# git clone https://github.com/Hackndo/pyGPOAbuse
pipx install git+https://github.com/Hackndo/pyGPOAbuse
```

Установка клиентов Samba

```bash
sudo apt install -y cifs-utils smbclient
```

Установка PrintNightmare

```bash
git clone https://github.com/cube0x0/CVE-2021-1675 PrintNightmare
```

Уязвимость Eternalblue

```bash
git clone https://github.com/3ndG4me/AutoBlue-MS17-010
```

SSH and XSERVER

```bash
sudo apt install -y openssh-server openssh-client xdotool
```

Пентест оборудования CISCO

```bash
git clone https://github.com/frostbits-security/SIETpy3
```

Сканер веб-уязвимостей

```bash
sudo apt install -y nuclei
```

Установка carackmapexec

```bash
sudo apt install -y g++ libxml2-dev libxslt-dev libjpeg-dev
sudo apt install -y crackmapexec
```

Установка john and ripper

```bash
sudo apt install -y perl libgomp1 john
```

Установка Metasploit

```bash
sudo apt install -y ruby ruby-bundler ruby-dev libffi-dev libpq-dev libpcap-dev libncurses5-dev libncursesw5-dev metasploit-framework
```

Установка FTP сервера на порт 21
```bash
pipx install pyftpdlib 
sudo python3 -m pyftpdlib -p 21
```

Установка Linux Utilites

```bash
sudo apt install -y util-linux
# sudo apt install -y exfiltrate
```

Установка SMB Enumetation

```bash
sudo apt install -y enum4linux enum4linux-ng smbmap
git clone https://github.com/m8r0wn/nullinux
cd ./nullinux
sudo bash setup.sh
nullinux -h
cd ../
```


