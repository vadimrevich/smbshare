**Команда cygrunsrv** — утилита, которая позволяет удалять сервисы, установленные с помощью Cygwin. Она доступна в оболочке Bash Cygwin и позволяет манипулировать сервисами Windows из Cygwin. [tokmakov.msk.ru](https://tokmakov.msk.ru/blog/item/472)[linuxlink.timesys.com](https://linuxlink.timesys.com/docs/classic/restart_services)

**Опция --remove** в команде cygrunsrv удаляет сервис с именем

```
&lt;svc_name&gt;
```

. <svc\_name> может быть локальным сервисом или «server/svc\_name» или «server\\svc\_name». [tokmakov.msk.ru](https://tokmakov.msk.ru/blog/item/472)

## Инструкция

**Чтобы удалить сервис с помощью команды cygrunsrv, нужно**: [superuser.com](https://superuser.com/questions/990622/how-to-remove-cygwin-sshd-service-from-service-list-in-windows-7)

1.  **Список активных сервисов** — использовать команду
    
    ```
    cygrunsrv -L
    ```
    
    .
2.  **Остановить и удалить сервис**:
    -   ```
        cygrunsrv --stop service_to_remove
        ```
        
        — остановить службу;
    -   ```
        cygrunsrv --remove service_to_remove
        ```
        
        — удалить службу.

 [superuser.com](https://superuser.com/questions/990622/how-to-remove-cygwin-sshd-service-from-service-list-in-windows-7)

**Важно**: команды нужно выполнять в одной строке, без разрывов строк. [linuxlink.timesys.com](https://linuxlink.timesys.com/docs/classic/restart_services)

**Пример**: чтобы удалить службу AutoSSH, нужно ввести команду

```
cygrunsrv --remove AutoSSH
```

. [tokmakov.msk.ru](https://tokmakov.msk.ru/blog/item/472)

## Возможные ошибки

**Некоторые ошибки, которые могут возникнуть при использовании команды cygrunsrv для удаления сервисов, и способы их решения**:

-   **Ошибка «Служба не запустилась из-за сбоя входа в систему»** — может появиться, если служба была удалена как пользователь, и процедура переустановки не помогла. В этом случае может потребоваться полностью удалить службу, связанную с Cygwin, или использовать другие методы удаления сервисов (например, через командную строку).
-   **Ошибка, связанная с совместимостью файла cygrunsrv.exe** — может появиться, если файл не совместим с версией Windows или платформой (32-бит или 64-бит). В этом случае может потребоваться обновить Windows до последней версии, просканировать компьютер на предмет вредоносного ПО или восстановить или переустановить cygrunsrv.

 [superuser.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fsuperuser.com%2Fquestions%2F110726%2Fhow-to-uninstall-reinstall-cygwin-to-use-the-sshd)[exedb.com](https://www.exedb.com/ru/cygrunsrv---44257-jkafw3gjvn0en1k.asp)

**Важно**: удаление некоторых сервисов, особенно если они имеют отношение к работе ОС, может не получиться или привести к нежелательным последствиям. Поэтому удалять службы рекомендуется лишь в том случае, если есть уверенность в том, что делается. [remontka.pro](https://remontka.pro/delete-service-windows-10/)
