# Popup tray notification

Alice:

**В PowerShell есть возможность отображать всплывающие сообщения (popup) в трее для залогиненных пользователей**. Для этого можно использовать класс

```
System.Windows.Forms.NotifyIcon
```

. [gist.github.com](https://gist.github.com/jdhitsolutions/e9e693f10f7196ca02323d7066297e79)[winitpro.ru](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/)[learn-powershell.net](https://learn-powershell.net/2010/08/22/balloon-notifications-with-powershell/)

**Некоторые особенности**:

-   Можно определить текст сообщения, заголовок и значок.
-   Можно указать время, в течение которого сообщение будет отображаться в трее (тайм-аут в миллисекундах).
-   Можно зарегистрировать события, чтобы выполнять действия в зависимости от того, закрыто ли сообщение или на него нажали.

 [learn-powershell.net](https://learn-powershell.net/2010/08/22/balloon-notifications-with-powershell/)

## Пример кода

**Скрипт, который выводит всплывающее сообщение рядом с панелью уведомлений Windows**:

```
Add-Type -AssemblyName System.Windows.Forms
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning
$balmsg.BalloonTipText = 'Это текст всплывающего сообщения для пользователя Windows 10'
$balmsg.BalloonTipTitle = "Внимание $Env:USERNAME"
$balmsg.Visible = $true
$balmsg.ShowBalloonTip(10000)
```

**Важно**: если скрипт запускается от имени локальной системы, текущий пользователь может не видеть всплывающее сообщение, потому что вывод отправляется сеансом 0 (для учётной записи локальной системы). В этом случае нужно запустить скрипт от имени текущего пользователя. [winitpro.ru](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/)[stackoverflow.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F61971517%2Fpowershell-send-a-toast-notification-to-logged-user-when-running-as-local-syste)

## Возможные ошибки

**Некоторые проблемы, которые могут возникать**:

-   **Значок в трее не исчезает** — в этом случае можно добавить обработчик событий, чтобы он получал уведомления о событии
    
    ```
    BalloonTipClosed
    ```
    
    и удалял значок. [stackoverflow.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F2179294%2Fproperly-displaying-a-tray-balloon-tooltip-in-powershell)
-   **Уведомление не отображается в трее** — в этом случае нужно проверить, правильно ли указан значок и сообщение. Например, если используется значок, который не доступен в трее, нужно указать его в свойстве
    
    ```
    Icon
    ```
    
    . [learn-powershell.net](https://learn-powershell.net/2010/08/22/balloon-notifications-with-powershell/)[stackoverflow.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F2179294%2Fproperly-displaying-a-tray-balloon-tooltip-in-powershell)
-   **Уведомление не отображается из-за того, что не зарегистрирован идентификатор приложения** — в этом случае нужно зарегистрировать PowerShell как приложение-уведомлитель и выбрать опцию «Показывать уведомления в центре действий» в настройках уведомлений. [deploywindows.com](https://deploywindows.com/2015/12/01/powershell-can-i-use-balloons-toasts-and-notifications/)[stackoverflow.com](https://stackoverflow.com/questions/39344752/powershell-script-creates-windows-10-notification-and-it-disappears-after-popup)

**Рекомендуется**: не использовать PowerShell в производственной среде, не протестировав код, — ошибки могут привести к проблемам. [gist.github.com](https://gist.github.com/jdhitsolutions/e9e693f10f7196ca02323d7066297e79)

Original Article: [Вывод уведомлений пользователям из скриптов PowerShell  Windows для системных администраторов](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/?ysclid=mm767ql2yu590187936)

Text:

[WinITPro.ru](https://winitpro.ru/)  /  [PowerShell](https://winitpro.ru/index.php/category/powershell/)  /  [Windows 10](https://winitpro.ru/index.php/category/windows-10/)  /  Вывод уведомлений пользователям из скриптов PowerShell

___

# Вывод уведомлений пользователям из скриптов PowerShell

![date](https://winitpro.ru/wp-content/themes/lite/img/sloi_13.png)12.04.2024

![user](https://winitpro.ru/wp-content/themes/lite/img/sloi_64.png) [itpro](https://winitpro.ru/index.php/author/itpro/ "Записи itpro")

![directory](https://winitpro.ru/wp-content/themes/lite/img/sloi_11.png) [PowerShell](https://winitpro.ru/index.php/category/powershell/), [Windows 10](https://winitpro.ru/index.php/category/windows-10/)

![comments](https://winitpro.ru/wp-content/themes/lite/img/sloi_14.png) [комментария 34](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/#comments)

Для оповещения пользователей о различных событиях, вы можете выводить различные графические уведомления из скриптов PowerShell. В PowerShell можно использовать всплывающие уведомления в трее Windows или модальные окно для получения информации от пользователя или подтверждения действия.

Содержание:

-   [Вывести всплывающее сообщение на экран с помощью PowerShell](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/?ysclid=mm767ql2yu590187936#h2_1)
-   [Вывести уведомление пользователю Windows из скрипта PowerShell](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/?ysclid=mm767ql2yu590187936#h2_2)
-   [PowerShell: отправка сообщения пользователю на удаленный компьютер](https://winitpro.ru/index.php/2018/10/02/uvedomleniya-polzovateley-is-powershell/?ysclid=mm767ql2yu590187936#h2_3)

## Вывести всплывающее сообщение на экран с помощью PowerShell

Для вывода простых модального диалогового окна в Windows можно воспользоваться Wscript классами подсистемы сценариев Windows.  Следующий PowerShell код выведет обычное текстовое окно с вашим текстом и кнопкой OK.

window.yaContextCb.push(()=>{ Ya.Context.AdvManager.render({ renderTo: "yandex\_rtb\_R-A-78675-11", blockId: "R-A-78675-11" }) })

`$wshell = New-Object -ComObject Wscript.Shell   $Output = $wshell.Popup("Скрипт формирования отчета выполнен")`

![Wscript.Shell вывод уведомлений в POwershell](https://winitpro.ru/wp-content/uploads/2018/10/wscript-shell-vyvod-uvedomlenij-v-powershell.png)

Вы можете настроить вид модального окна такого сообщения и добавить кнопки действия для пользователей. Например, чтобы вывести всплывающее окно с кнопками Да и Нет, выполните:

![$wshell.Popup](https://winitpro.ru/wp-content/uploads/2018/10/dollarwshell-popup.png)

`$Output = $wshell.Popup("Скрипт формирования отчета завершен! Хотите вывести его на экран?",0,"Отчет готов",4+32)`

Если пользователь нажмет Да, команда вернет значение `6`, а если Нет – `7`.

В зависимости от выбора пользователя вы можете выполнить какое-то действие, или завершить скрипт.

```
switch ($Output) {
    7 {$wshell.Popup('Нажата Нет')}
    6 {$wshell.Popup('Нажата Да')}
 default {$wshell.Popup('Неверный ввод')}
}
```

Общий синтаксис и параметры метода Popup:

`Popup(<Text>,<SecondsToWait>,<Title>,<Type>)`

Параметры:

-   `<Text>` — текст сообщения.
-   `<SecondsToWait>` — необязательный, число. Количество секунд, по истечении которого окно будет автоматически закрыто.
-   `<Title>` — текст заголовка окна сообщения (необязательный параметр).
-   `<Type>` — комбинация флагов, определяет тип кнопок и вид значка (числовое значение, не обязательный параметр). Возможные значения флагов:
    -   0 — кнопка ОК.
    -   1 — кнопки ОК и Отмена.
    -   2 — кнопки Стоп, Повтор, Пропустить.
    -   3 — кнопки Да, Нет, Отмена.
    -   4 — кнопки Да и Нет.
    -   5 — кнопки Повтор и Отмена.
    -   16 — значок Stop.
    
    -   32 — значок Question.
    -   48 — значок Exclamation.
    -   64 — значок Information.

Команда PowerShell возвращает целое значение, с помощью которого можно узнать, какая кнопка была нажата пользователем. Возможные значения:

-   \-1 — таймаут.
-   1 — кнопка ОК.
-   2 — кнопка Отмена.
-   3 — кнопка Стоп.
-   4 — кнопка Повтор.
-   5 — кнопка Пропустить.
-   6 — кнопка Да.
-   7 — кнопка Нет.

Если нужно показать пользователю окно ввода и запросить данные, воспользуйтесь классом Windows Forms.

`Add-Type -AssemblyName System.Windows.Forms   $input = [Microsoft.VisualBasic.Interaction]::InputBox("Введите имя пользователя:", "Запрос данных", "")`

Чтобы обработать введенные пользователе данные:

```
if ([string]::IsNullOrWhiteSpace($input)) {
   Write-Host "Данные не указаны"
} else {
    Write-Host "Вы ввели $input"
}
```

![Вывести окно для ввода данных пользователя в powershell скрипте](https://winitpro.ru/wp-content/uploads/2018/10/powershell-script-vyvesti-formmu-dlya-vvoda-dannih.jpg)

Если нужно вывести всплывающее окно поверх всех окон, используйте команду:

```powershell
($ModalTop = New-Object 'System.Windows.Forms.Form' ).TopMost = $True   
```
```powershell
[System.Windows.Forms.MessageBox]::Show($ModalTop,"Текст", "Заголовок", 4, 48)
```

## Вывести уведомление пользователю Windows из скрипта PowerShell

С помощью класса Windows Forms можно вывести более красивые всплывающие сообщения (ballons). Следующий скрипт выведет всплывающее сообщение рядом с панелью уведомлений Windows, которое автоматически исчезнет через 10 секунд:

```powershell
Add-Type -AssemblyName System.Windows.Forms   
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon   
$path = (Get-Process -id $pid).Path   
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)  
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning   
$balmsg.BalloonTipText = 'Это текст всплывающего сообщения для пользователя Windows 10'   
$balmsg.BalloonTipTitle = "Внимание $Env:USERNAME"   
$balmsg.Visible = $true   
$balmsg.ShowBalloonTip(10000)
```

![всплывающее уведомление в POwerShell](https://winitpro.ru/wp-content/uploads/2018/10/vsplyvayushee-uvedomlenie-v-powershell.png)

Для создания красочных **всплывающих** сообщений в Windows можно использовать отдельный PowerShell модуль **BurntToast**.

Установите модуля из PowerShell Gallery:

```powershell
Install-Module -Name BurntToast
```

Теперь, например, в ранее рассматриваемый [скрипт автоматического отключения от Wi-FI сети при подключении к Ethernet](https://winitpro.ru/index.php/2018/08/01/kak-avtomatom-otklyuchat-wi-fi-pri-ethernet/) можно добавить уведомление с картинкой:

```powershell
New-BurntToastNotification -Text "Отключение от Wi-Fi сети", "Вы были отключены от Wi-Fi сети, т.к. Вше устройство было подключено к скоростному Ethernet подключению." -AppLogo C:\PS\changenetwork.png
```

![Вывести всплывающее уведомление uvedomlenie New-BurntToastNotification](https://winitpro.ru/wp-content/uploads/2018/10/vyvesti-vsplivayushee-uvedomlenie-New-BurntToastNotification.jpg)

## PowerShell: отправка сообщения пользователю на удаленный компьютер

С помощью PowerShell вы можете отправить всплывающее сообщение пользователю на удаленный компьютер. Сначала нужно получить [список сессии пользователей на удаленном компьютере](https://winitpro.ru/index.php/2021/03/25/poluchit-imya-polzovatelya-na-udalennom-kompyutere/) (в случае [RDS сервера](https://winitpro.ru/index.php/2022/02/17/ustanovka-nastrojka-remote-desktop-services-rds-windows-server/)):

```powershell
qwinsta /server:rds1
```

![qwinsta: список сессий пользователей на удаленном компьютере](https://winitpro.ru/wp-content/uploads/2018/10/qwinsta-spisok-sessiy-na-udalennom-komputere.jpg)

Чтобы отправить сообщение в сессию пользователя на удаленном компьютер, выполните команду:

```powershell
MSG kbuldogov /server:rds1 "Сервер будет перезагружен через 10 минут. Закройте документы"
```

Если всплывающее сообщение нужно отправить всем пользователям укажите \* вместо имени пользователя:

```powershell
MSG * /server:rds1 "Срочное сообщение всем! "
```

![PowerShell msg вывести сообщение пользователю на удаленном компьютере ](https://winitpro.ru/wp-content/uploads/2018/10/powershell-otpravka-soobsheniya-na-udalenniy-komputer.png)

Для отправки всплывающего графического уведомления на удаленный компьютер можно воспользоваться скриптом **RemoteSendToasNotification.ps1** из нашего GitHub репозитория ( [https://github.com/winadm/posh/blob/master/scripts/RemoteSendToasNotification.ps1](https://github.com/winadm/posh/blob/master/scripts/RemoteSendToasNotification.ps1)). Для подключения к удаленному компьютеру используется командлет [Invoke-Command](https://winitpro.ru/index.php/2020/07/27/powershell-invoke-command-zapuska-komand-na-udalennyx-kompyuterax/), который использует [WinRM](https://winitpro.ru/index.php/2012/01/31/kak-aktivirovat-windows-remote-management-s-pomoshhyu-gruppovoj-politiki/).

![Отправить всплывающее сообщение пользователю на удаленный компьютер Windows](https://winitpro.ru/wp-content/uploads/2018/10/otpravk-vspivayushego-soobsheniya-udalenniy-komputer.jpg)
