Для обновления Windows Server Core с помощью PowerShell можно использовать **модуль PSWindowsUpdate**.  [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)[4](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fwww.partitionwizard.com%2Fpartitionmagic%2Fpowershell-windows-update.html)

**Чтобы установить обновления с помощью PowerShell, нужно выполнить следующие шаги**:

1.  **Открыть PowerShell с правами администратора**. [3](https://www.wintips.org/how-to-run-windows-update-from-command-prompt-or-powershell-windows-10-11-server-2016-2019/)
2.  **Установить модуль PSWindowsUpdate** из онлайн-репозитория PowerShell Gallery с помощью команды
    
    ```
    Install-Module -Name PSWindowsUpdate
    ```
    
    . Нужно подтвердить установку репозитория, нажав «Y». [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)
3.  **Разрешить выполнение скриптов** с помощью команды
    
    ```
    Set-ExecutionPolicy –ExecutionPolicy RemoteSigned -force
    ```
    
    . [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)
4.  **Импортировать модуль** в сессию PowerShell с помощью команды
    
    ```
    Import-Module PSWindowsUpdate
    ```
    
    . [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)
5.  **Проверить наличие обновлений** с помощью команд
    
    ```
    Get-WindowsUpdate
    ```
    
    или
    
    ```
    Get-WUList
    ```
    
    .  [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)[4](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fwww.partitionwizard.com%2Fpartitionmagic%2Fpowershell-windows-update.html)
6.  **Установить обновления** с помощью команды
    
    ```
    Install-WindowsUpdate
    ```
    
    . Например, чтобы автоматически скачать и установить все доступные обновления для версии Windows с серверов Windows Update, нужно выполнить команду
    
    ```
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
    ```
    
    .  [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)

Модуль PSWindowsUpdate особенно полезен для серверов, которые работают без графического интерфейса, таких как Windows Server Core. [2](https://softcomputers.org/blog/ustanovit-obnovleniya-v-windows-c-pomoshchyu-powershell/)

