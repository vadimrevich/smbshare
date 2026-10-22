Тревожные Event ID в журналах событий Windows — это идентификаторы, которые указывают на потенциальные проблемы, нарушения безопасности или критические сбои в работе системы. Они помогают выявлять подозрительную активность, попытки несанкционированного доступа, изменения в настройках безопасности и другие тревожные ситуации. [softcomputers.org](https://softcomputers.org/blog/analiz-logov-event-viewer-kak-nayti-sledy-vzloma/)[infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)[blog.elcomsoft.ru](https://blog.elcomsoft.ru/2026/02/kriminalisticheskij-analiz-zhurnala-sobytij-windows-event-log/)

## Некоторые тревожные Event ID

**В журнале «Безопасность» (Security):**

-   **4719.** Несанкционированное изменение политики аудита — критический сигнал тревоги. Злоумышленники часто пытаются отключить аудит, чтобы скрыть свои действия. [softcomputers.org](https://softcomputers.org/blog/analiz-logov-event-viewer-kak-nayti-sledy-vzloma/)
-   **1102.** Журнал аудита очищен — серьёзный признак того, что злоумышленник пытался скрыть свои следы. Это событие регистрируется даже если журнал был очищен, и его нельзя стереть самим действием очистки. [softcomputers.org](https://softcomputers.org/blog/analiz-logov-event-viewer-kak-nayti-sledy-vzloma/)
-   **4625.** Неудачный вход в систему. Массовые попытки с этим ID на разные учётные записи могут указывать на брутфорс-атаки или подбор паролей (password spraying). [softcomputers.org](https://softcomputers.org/blog/analiz-logov-event-viewer-kak-nayti-sledy-vzloma/)[infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)
-   **4648.** Вход с явным указанием учётных данных. Часто признак использования украденных учётных данных. [infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)
-   **4672.** Назначены особые привилегии (вход административной учётной записи). [infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)
-   **4688.** Создание нового процесса (если включён аудит командной строки). Ценный источник информации о запускаемых процессах. [infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)
-   **7045.** Установлена новая служба. Может указывать на закрепление вредоносного ПО или изменение конфигурации системы. [infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)[gist.github.com](https://gist.github.com/githubfoam/69eee155e4edafb2e679fb6ac5ea47d0)
-   **7036.** Изменение состояния службы (запуск/остановка). [infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)

**В других журналах (например, System или Application):**

-   **104.** Очистка других журналов (не Security). Также может быть признаком действий злоумышленника. [blog.elcomsoft.ru](https://blog.elcomsoft.ru/2026/02/kriminalisticheskij-analiz-zhurnala-sobytij-windows-event-log/)
-   **51.** Предупреждение о потенциальной задержке записи данных на диск. [phoenixnap.com](https://phoenixnap.com/kb/windows-event-log)
-   **41, 1001, 6008.** Указывают на непредвиденную перезагрузку системы, которая может быть вызвана сбоем, потерей питания или проверкой ошибок. [learn.microsoft.com](https://learn.microsoft.com/ru-ru/troubleshoot/windows-server/performance/troubleshoot-unexpected-reboots-system-event-logs)

## Как анализировать журналы

1.  **Используйте Event Viewer** (Просмотр событий) для просмотра журналов. Можно фильтровать события по Event ID, уровню серьёзности (Severity) и другим параметрам. [techtarget.com](https://www.techtarget.com/searchwindowsserver/definition/Windows-event-log)[phoenixnap.com](https://phoenixnap.com/kb/windows-event-log)
2.  **Настройте аудит** (если требуется). Для записи многих событий безопасности нужно предварительно настроить политику аудита в gpedit.msc или GPO для домена. [softcomputers.org](https://softcomputers.org/blog/analiz-logov-event-viewer-kak-nayti-sledy-vzloma/)
3.  **Сопоставляйте события с другими данными**. Например, с реестром, файлами Prefetch, телеметрией приложений. Это помогает восстановить последовательность действий и выявить связи между событиями. [blog.elcomsoft.ru](https://blog.elcomsoft.ru/2026/02/kriminalisticheskij-analiz-zhurnala-sobytij-windows-event-log/)
4.  **Используйте SIEM-системы** для анализа логов на уровне всей инфраструктуры. [infobezopasnost.ru](https://infobezopasnost.ru/blog/articles/kak-issleduyut-reestr-i-zhurnaly-sobytij-windows-pri-rassledovanii/)

Важно регулярно проверять журналы и использовать пользовательские представления для постоянного мониторинга критических событий. [softcomputers.org](https://softcomputers.org/blog/analiz-logov-event-viewer-kak-nayti-sledy-vzloma/)
