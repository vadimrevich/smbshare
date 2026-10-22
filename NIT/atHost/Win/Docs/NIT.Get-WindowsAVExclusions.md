Командлет **Get-MpPreference** в PowerShell позволяет получить настройки Windows Defender, включая информацию об исключениях. Однако сам по себе он не выводит полный список исключений в текстовом виде — для этого требуется дополнительная обработка вывода. [learn.microsoft.com](https://learn.microsoft.com/en-us/powershell/module/defender/get-mppreference?view=windowsserver2025-ps)[github.com](https://github.com/MicrosoftDocs/windows-powershell-docs/blob/main/docset/winserver2022-ps/Defender/Get-MpPreference.md)[github.com](https://github.com/MicrosoftDocs/windows-powershell-docs/blob/main/docset/winserver2025-ps/Defender/Get-MpPreference.md)

## Как просмотреть исключения

Чтобы получить список исключений, можно использовать следующие команды в окне PowerShell с повышенными правами доступа (от имени администратора):

```powershell
$p = Get-MpPreference
@(
    $p.ExclusionExtension | ForEach-Object { [pscustomobject]@{ Type = 'ExclusionExtension'; Value = $_ } }
    $p.ExclusionPath | ForEach-Object { [pscustomobject]@{ Type = 'Путь исключения'; Value = $_ } }
    $p.ExclusionProcess | ForEach-Object { [pscustomobject]@{ Type = 'Процесс исключения'; Value = $_ } }
)
```

Этот код извлекает свойства

```
ExclusionExtension
```

,

```
ExclusionPath
```

и

```
ExclusionProcess
```

объекта, возвращённого командой

```
Get-MpPreference
```

, и преобразует их в пользовательские объекты с указанием типа исключения. [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2FMicrosoftDocs%2Fdefender-docs%2Fblob%2Fpublic%2Fdefender-endpoint%2Fconfigure-process-opened-file-exclusions-microsoft-defender-antivirus.md)

**Важно:** вывод может быть обрезан, если количество исключений велико. Для более детального отображения можно использовать

```
Format-Table
```

с параметром

```
-AutoSize
```

. [superuser.com](https://superuser.com/questions/1591375/how-to-retrieve-windows-defender-exclusions-by-powershell-without-truncation-out)

## Дополнительные сведения

-   **Параметры командлета:** помимо параметров, связанных с исключениями,
    
    ```
    Get-MpPreference
    ```
    
    поддерживает общие параметры PowerShell (например,
    
    ```
    -Debug
    ```
    
    ,
    
    ```
    -ErrorAction
    ```
    
    и др.). [learn.microsoft.com](https://learn.microsoft.com/en-us/powershell/module/defender/get-mppreference?view=windowsserver2025-ps)[github.com](https://github.com/MicrosoftDocs/windows-powershell-docs/blob/main/docset/winserver2025-ps/Defender/Get-MpPreference.md)
-   **Типы исключений:** исключения могут быть связаны с путями к папкам, расширениями файлов или процессами. [github.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fgithub.com%2FMicrosoftDocs%2Fdefender-docs%2Fblob%2Fpublic%2Fdefender-endpoint%2Fconfigure-process-opened-file-exclusions-microsoft-defender-antivirus.md)[dzen.ru](https://dzen.ru/a/aPTDvGD0IUksN0t1)
-   **Для изменения настроек исключений** используются другие командлеты, например
    
    ```
    Add-MpPreference
    ```
    
    (добавление исключений) и
    
    ```
    Remove-MpPreference
    ```
    
    (удаление). [winitpro.ru](https://winitpro.ru/index.php/2016/02/25/upravlenie-windows-defender-s-pomoshhyu-powershell/)[remontcompa.ru](https://remontcompa.ru/windows/windows-11/2811-kak-v-windows-11-dobavljat-fajly-i-papki-v-spisok-iskljuchenij-zaschitnika.html)

Если требуется более детальный анализ или фильтрация данных, можно комбинировать несколько командлетов или использовать дополнительные параметры PowerShell.
