**Обфускация кода PowerShell с помощью Base64** — техника, которая позволяет запутать содержимое скрипта, чтобы затруднить его анализ и обнаружение. Это может быть полезно, например:

-   **Для скрытного выполнения команд** — обфускация помогает скрыть загрузку вредоносных файлов или предотвратить простое сопоставление строк.
-   **Для удалённого выполнения скрипта** — техника полезна в средах, где прямое выполнение скрипта не возможно.

 [kqlquery.com](https://kqlquery.com/posts/hunting-encoded-powershell/), [techcrafters.com](https://www.techcrafters.com/portal/en/kb/articles/powershell-tutorial-mastering-base64-encoding-of-powershell-scripts)

### Принцип

Код PowerShell кодируется в Base64, что добавляет уровень запутывания. Это позволяет:

-   **Запускать команды в кодировке Base64** — PowerShell поддерживает возможность выполнять закодированные команды прямо из командной строки.
-   **Использовать Base64-выраражения** — метод позволяет выполнять закодированные строки внутри скрипта.

 [cybersec.th4ntis.com](https://cybersec.th4ntis.com/tools/methods/powershell-obfuscation), [offsec.com](https://www.offsec.com/blog/powershell-obfuscation/)

### Пример

-   **Кодирование скрипта, сохранённого в переменной**:
       ```
        $Script = @' # Ваши команды PowerShell здесь Write-Host "Hello, World!" '@
        ```
        ```
        $EncodedScript = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($Script))
        ```
    -   **Запуск закодированного скрипта**:
        
        ```
        powershell -EncodedCommand $EncodedScript
        ```
-   **Кодирование файла скрипта**:
       
       ```
        $ScriptContent = Get-Content 'C:\path\to\your\script.ps1' -Raw
        ```
        ```
        $EncodedScriptFile = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($ScriptContent))
        ```
    -   **Запуск закодированного скрипта из файла**:

        ```
        powershell -EncodedCommand $EncodedScriptFile
        ```
 [techcrafters.com](https://www.techcrafters.com/portal/en/kb/articles/powershell-tutorial-mastering-base64-encoding-of-powershell-scripts)

### Методы обнаружения

-   **Анализ логов** — PowerShell поддерживает возможность выполнять закодированные команды, и обфусцированный скрипт может быть обнаружен при просмотре логов. [cybersec.th4ntis.com](https://cybersec.th4ntis.com/tools/methods/powershell-obfuscation)
-   **Использование инструментов для деобфускации** — они позволяют раскрыть скрытый код, закодированный в Base64. Однако обфускация не считается безопасным методом защиты чувствительной информации — закодированный скрипт может быть декодирован. [adrinanthony.wordpress.com](https://adrinanthony.wordpress.com/2023/06/27/powershell-deobfuscation-unmasking-hidden-code-using-cyberchef/), [techcrafters.com](https://www.techcrafters.com/portal/en/kb/articles/powershell-tutorial-mastering-base64-encoding-of-powershell-scripts)

**Invoke-Obfuscation** — инструмент для обфускации скриптов PowerShell, разработанный для обхода обнаружения антивирусами. Он позволяет запутывать и кодировать вредоносные сценарии PowerShell, делая их менее заметными для антивирусных решений. [toolify.ai](https://www.toolify.ai/gpts/master-the-art-of-powershell-script-obfuscation-with-invokeobfuscation-376990), [linode.com](https://www.linode.com/docs/guides/windows-red-team-defense-evasion-techniques/), [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md)

**Репозиторий**: [github.com](https://github.com/danielbohannon/Invoke-Obfuscation). [github.com](https://github.com/danielbohannon/Invoke-Obfuscation)

### Принцип работы

Инструмент поддерживает различные техники обфускации, например:

-   **Модуль Token** — обфусцирует токены команд PowerShell в скрипте. Есть опции: обфускация строки токена, команды токена, аргумента токена и другие.
-   **Модуль String** — обфусцирует целые команды PowerShell в виде строк. Можно выбрать опции: конкатенация, перепорядок, обратный порядок всей команды после конкатенации.
-   **Модуль Encoding** — кодирует команды PowerShell с помощью различных техник кодировки. Есть опции: кодировка ASCII, шестнадцатеричная кодировка, двоичная кодировка и другие.

 [toolify.ai](https://www.toolify.ai/gpts/master-the-art-of-powershell-script-obfuscation-with-invokeobfuscation-376990)

### Установка

Инструмент доступен в репозитории GitHub. Можно клонировать репозиторий с помощью Git или скачать его в виде zip-файла и распаковать в выбранный каталог. [toolify.ai](https://www.toolify.ai/gpts/master-the-art-of-powershell-script-obfuscation-with-invokeobfuscation-376990), [github.com](https://github.com/danielbohannon/Invoke-Obfuscation)

**Важно**: целевой объект должен иметь возможность выполнять сценарии PowerShell, иначе обфусцированные скрипты не будут выполняться. [linode.com](https://www.linode.com/docs/guides/windows-red-team-defense-evasion-techniques/), [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md)

### Использование

**Некоторые шаги для обфускации PowerShell-скрипта с помощью Invoke-Obfuscation**:

1.  **Создать и сохранить вредоносный скрипт PowerShell**. [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md)
2.  **Указать путь к скрипту** с помощью Invoke-Obfuscation. Например, выполнить команду:
    
    ```
    SET SCRIPTPATH /PATH-TO-SCRIPT/script.ps1
    ```
    
    . [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md), [linode.com](https://www.linode.com/docs/guides/windows-red-team-defense-evasion-techniques/)
3.  **Выбрать метод обфускации**. Например, использовать опцию AST для обфускации узлов PowerShell (PS3.0+). [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md), [ladydebug.com](https://ladydebug.com/blog/2020/11/12/installing-powershell-and-invoke-obfuscation-on-centos-8/)
4.  **Подтвердить метод обфускации**. [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md)

**Результат** — обфусцированный код PowerShell. Можно скопировать запутанный скрипт и сохранить его в новом файле, после чего перенести в целевую систему и выполнить. [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2Flinode%2Fdocs%2Fblob%2Fdevelop%2Fdocs%2Fguides%2Fsecurity%2Fvulnerabilities%2Fwindows-red-team-defense-evasion-techniques%2Findex.md)

### Риски

**Инструмент Invoke-Obfuscation не гарантирует 100% обход обнаружения антивирусом** — алгоритмы обнаружения со временем улучшаются. Результат обфускации может отличаться, так как при обфускации используется рандомизация. Иногда это может приводить к ошибкам в коде, и обфускацию придётся выполнить повторно. [toolify.ai](https://www.toolify.ai/gpts/master-the-art-of-powershell-script-obfuscation-with-invokeobfuscation-376990), [habr.com](https://habr.com/ru/articles/868622/)