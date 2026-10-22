# Создание vhd диска в Windows

Создать виртуальный жёсткий диск (VHD или VHDX) в Windows можно несколькими способами: через графический интерфейс «Управление дисками», с помощью утилиты **DiskPart** или с использованием PowerShell.

## Создание через «Управление дисками»

1.  Откройте «Управление дисками» с правами администратора. Для этого можно: 
    
    -   нажать
        
        ```
        Win + R
        ```
        
        , ввести
        
        ```
        diskmgmt.msc
        ```
        
        и нажать Enter; [remontka.pro](https://remontka.pro/virtual-hdd-windows/)[thewindowsclub.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fwww.thewindowsclub.com%2Fcreate-and-set-up-new-vhd-or-vhdx-file-in-windows-10)
    -   в меню «Пуск» найти «Управление дисками» и открыть его. [learn.microsoft.com](https://learn.microsoft.com/ru-ru/windows-server/storage/disk-management/manage-virtual-hard-disks)
2.  В меню «Действие» выберите «Создать VHD». [learn.microsoft.com](https://learn.microsoft.com/ru-ru/windows-server/storage/disk-management/manage-virtual-hard-disks)[learn.microsoft.com](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/manage-virtual-hard-disks)
    
3.  В диалоговом окне «Создание и подключение виртуального жёсткого диска»:
    
    -   в поле «Расположение» нажмите «Обзор», выберите папку для сохранения VHD-файла (путь должен быть полным, не включая каталог
        
        ```
        \Windows
        ```
        
        );
    -   в поле «Имя файла» введите имя нового виртуального жёсткого диска;
    -   в раскрывающемся списке «Сохранить как тип» выберите «Файлы виртуального диска (\*.vhdx)» (рекомендуется);
    -   в поле «Размер виртуального жёсткого диска» укажите размер нового VHD (минимальный размер — 3 МБ);
    -   выберите тип виртуального жёсткого диска: «Динамически расширяющийся» или «Фиксированный размер».

 [learn.microsoft.com](https://learn.microsoft.com/ru-ru/windows-server/storage/disk-management/manage-virtual-hard-disks)[learn.microsoft.com](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/manage-virtual-hard-disks)

4.  Нажмите «ОК», чтобы завершить работу. [learn.microsoft.com](https://learn.microsoft.com/ru-ru/windows-server/storage/disk-management/manage-virtual-hard-disks)

После создания диска его нужно инициализировать и создать на нём раздел (раздел, файловую систему) для использования. [remontka.pro](https://remontka.pro/virtual-hdd-windows/)[windowsnotes.ru](https://windowsnotes.ru/virtualization/virtualnye-zhestkie-diski-sozdanie-i-upravlenie/)

## Создание с помощью DiskPart

1.  Запустите командную строку с правами администратора.
    
2.  Введите
    
    ```
    diskpart
    ```
    
    и нажмите Enter, чтобы запустить утилиту.
    
3.  Для создания фиксированного VHD-файла используйте команду:
    
    ```
    <div class="FuturisMarkdown-Code"><code class="FuturisMarkdown-CodeText">create vdisk file="Full\path\to\vhd\file" maximum=&lt;size&gt; type=fixed
    </code><button type="button" class="Button FuturisMarkdown-CopyText" autocomplete="off"><span class="Button-Text"><span class="Icon Icon_type_copyOutline16Black FuturisMarkdown-CopyIcon" aria-hidden="true"></span>Скопировать</span></button></div>
    ```
    
    где
    
    ```
    Full\path\to\vhd\file
    ```
    
     — полный путь к файлу,
    
    ```
    &lt;size&gt;
    ```
    
     — максимальный размер в мегабайтах. [winaero.com](https://winaero.com/create-a-new-vhd-or-vhdx-file-in-windows-10/)
    
    Для динамически расширяемого VHD/VHDX:
    
    ```
    <div class="FuturisMarkdown-Code"><code class="FuturisMarkdown-CodeText">create vdisk file="Full\path\to\vhd\file" maximum=&lt;size&gt; type=expandable
    </code><button type="button" class="Button FuturisMarkdown-CopyText" autocomplete="off"><span class="Button-Text"><span class="Icon Icon_type_copyOutline16Black FuturisMarkdown-CopyIcon" aria-hidden="true"></span>Скопировать</span></button></div>
    ```
    

После создания диска его можно подключить и использовать как обычный жёсткий диск в системе. [windowsnotes.ru](https://windowsnotes.ru/virtualization/virtualnye-zhestkie-diski-sozdanie-i-upravlenie/)

## Дополнительные возможности

-   **PowerShell.** Можно использовать командлеты New-VHD для создания фиксированного или динамически расширяемого VHD.
-   **Hyper-V Manager.** Позволяет создать VHD-файл через приложение Hyper-V Manager.

 [habr.com](https://habr.com/ru/companies/ruvds/articles/952020/)[winaero.com](https://winaero.com/create-a-new-vhd-or-vhdx-file-in-windows-10/)

**Важно:** для выполнения процедур создания VHD учётная запись пользователя должна быть членом группы «Операторы резервного копирования» или «Администраторы». [learn.microsoft.com](https://learn.microsoft.com/ru-ru/windows-server/storage/disk-management/manage-virtual-hard-disks)[learn.microsoft.com](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/manage-virtual-hard-disks)

