**Чтобы сбросить сессию WinRM на локальном компьютере, нужно выполнить следующие шаги**:

1.  Запустить командную строку (cmd.exe) от имени администратора.
2.  **Остановить и отключить службу WinRM**.
3.  **Удалить любые конфигурации** и настройки, применённые политикой. Например, удалить файлы в каталогах:
    -   ```
        HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WSMAN
        ```
        
        ;
    -   ```
        HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\winrm
        ```
        
        .
4.  **Восстановить базовую конфигурацию**. Для этого нужно выполнить команду:
    
    ```
    winrm invoke Restore http://schemas.microsoft.com/wbem/wsman/1/config @{}
    ```
    
    .
5.  **Включить службу WinRM снова**. Для этого нужно выполнить команду:
    
    ```
    sc config winrm start=auto
    ```
    
