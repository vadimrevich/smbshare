# Index of C:/.BIN/ScriptArchive/Vagrant_Settings/Win/
- `TurnOffServerManager.reg` -- Выключает автозагрузку ServerManager на серверных операционных системах.
- `TurnOffShutdowsTracker.reg` -- Выключает указание причины остановки/перезагрузки сервера
- `WinRM2Unsafe.bat` -- Включает небезопасные настройки протокола WinRM.
- `Disable-PasswordComplexity.ps1` -- Скрипт отключает дополнительную проверку сложности паролей. Работает только на компьютерах, не входящих в домен.
- `Enable-PasswordComplexity.ps1` -- Скрипт включает дополнительную проверку сложности паролей. Работает только на компьютерах, не входящих в домен.
- `IEHArden_V5.bat` -- Скрипт отключает режим усиленной безопасности Internet Explorer.

### Примечания

1. Работать со скриптами нужно при отключёном антивирусе.
2. Для запуска скриптов на Windows машине необходимо:
  - Открыть Windows Explorer.
  - Перейти в каталог X:\Vagrant_Settings\Win\
  - Запускать скрипты отсюда в любом порядке.
  
  Для полноценной работы Microsoft Windows Server в Интернете необходимо отключать режим усиленной безопасности Microsoft Internet Explorer (даже если вы им не пользуетесь). Возможно, Вам понадобиться упрощённое подключение к серверу в локальной сети по протоколу WinRM. Поэтому запуск скриптов `IEHArden_V5.bat`и `WinRM2Unsafe.bat` крайне необходим при ручной настройке сервера из командной строки, а остальные скрипты запускайте на ваше усмотрение в любом порядке.
  
 