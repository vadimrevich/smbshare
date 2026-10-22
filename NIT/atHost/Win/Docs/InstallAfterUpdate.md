# Install after Update Windows

Установка после обновления Microsoft Windows 10+ Clients

## Обновление

В результате обновления должны быть установлены:

- Microsoft .Net Framework 4.8.1., языковые пакеты и обновления.
- Обновления безопасности.
- После обновляется магазин приложений.
- Из него — средства установки программ (WinGet).

Дополнительно ничего устанавливать не нужно.

# Установка с помощью WinGet

-  Менеджер пакетов Chocolatey:

```bash
winget install Chocolatey.Chocolatey --source winget
```
- Менеджер пакетов snoop
```bash
winget install --id=SnoopWpf.Snoop -e
```
- sudo
```bash
winget install oleg-shilo.win-sudo --source winget
```

- VC++ Redist AIO
```bash
winget install abbodi1406.vcredist --source winget
```
- Powershell
```bash
winget install Microsoft.PowerShell --source winget
```
- Obsidian
```bash
winget install Obsidian.Obsidian --source winget
```

- Windows Terminal
```bash
winget install Microsoft.WindowsTerminal --source winget
```

- ConEmu
```bash
winget install Maximus5.ConEmu --source winget

```
- Far Manager
```bash
winget install FarManager.FarManager --source winget
```

После установки — перезагрузка.

Далее — загрузка дополнений, файлов данных и плагинов с пользовательских репозиториев (в архиве).

- Install File Exchange Service at User Downloads Folder

```bash
winget install localsend --source winget
```

- Install Microsoft GNU Coreutils

```bash
winget install Microsoft.Coreutils
```
- Install GNU Nano (needs VPN)

```bash
winget install GNU.nano
```

