# Get .Net Framework Versions

**С помощью PowerShell можно проверить установку .NET Framework 4.8** (или другой версии). Для этого нужно использовать команду, которая выводит список установленных версий .NET Framework. [c-sharpcorner.com](https://www.c-sharpcorner.com/article/how-to-check-net-framework-version-on-windows-10/)[windowscentral.com](https://www.windowscentral.com/how-quickly-check-net-framework-version-windows-10)[docs.redcheck.ru](https://docs.redcheck.ru/articles/?_escaped_fragment_=redcheck-269/setup-microsoft-net-framework)

## Пример кода

**Команда для проверки установки .NET Framework 4.8 с помощью PowerShell**:  

```
Get-ChildItem ‘HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP’ -Recurse | Get-ItemProperty -Name version -EA 0 | Where { $_.PSChildName -Match ‘^(?!S)\p{L}’} | Select PSChildName, version
```

 [docs.redcheck.ru](https://docs.redcheck.ru/articles/?_escaped_fragment_=redcheck-269/setup-microsoft-net-framework)

**Чтобы запустить команду**, нужно: [docs.redcheck.ru](https://docs.redcheck.ru/articles/?_escaped_fragment_=redcheck-269/setup-microsoft-net-framework)

1.  Запустить консоль PowerShell: «Пуск» → «Windows PowerShell» → «Windows PowerShell».
2.  В появившемся окне ввести команду.

 [docs.redcheck.ru](https://docs.redcheck.ru/articles/?_escaped_fragment_=redcheck-269/setup-microsoft-net-framework)

**В окне отобразится список установленных версий .NET Framework**. Наибольшая версия — .NET Framework 4.8. [docs.redcheck.ru](https://docs.redcheck.ru/articles/?_escaped_fragment_=redcheck-269/setup-microsoft-net-framework)[c-sharpcorner.com](https://www.c-sharpcorner.com/article/how-to-check-net-framework-version-on-windows-10/)

## Объяснение

Команда запрашивает реестр Windows, чтобы получить информацию об установленных версиях .NET Framework. При установке или обновлении любой версии .NET Framework изменения записываются в реестр. В разделе

```
HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP
```

хранится информация обо всех версиях .NET на компьютере. [winitpro.ru](https://winitpro.ru/index.php/2018/06/09/kak-uznat-kakie-versii-net-framework-ustanovleny-na-kompyutere/)[learn.microsoft.com](https://learn.microsoft.com/ru-ru/dotnet/framework/install/how-to-determine-which-versions-are-installed)

**Некоторые параметры, которые можно проверить**:

-   **Install** — флаг установки (если равен 1, значит данная версия .NET установлена на компьютере);
-   **Install Path** — каталог, в который установлена данная версия .NET;
-   **Release** — номер релиза .NET;
-   **Version** — полный номер версии .NET Framework.

 [winitpro.ru](https://winitpro.ru/index.php/2018/06/09/kak-uznat-kakie-versii-net-framework-ustanovleny-na-kompyutere/)

**Важно**: для .NET 4.0 и выше, если подраздел Full отсутствует, это значит, что данная версия Framework на компьютере не установлена. [winitpro.ru](https://winitpro.ru/index.php/2018/06/09/kak-uznat-kakie-versii-net-framework-ustanovleny-na-kompyutere/)

# Get VCRedist

**В PowerShell есть команда

```
Get-InstalledVcRedist
```

, которая возвращает список установленных пакетов Microsoft Visual C++ Redistributable (VCRedist)**. Она возвращает список с различными свойствами, включая имя, код продукта, версию и строки удаления. [vcredist.com](https://vcredist.com/get-installedvcredist)

Также для проверки установки можно использовать **модуль VcRedist**, который позволяет получать список установленных Redistributables. [vcredist.com](https://vcredist.com/get-installedvcredist)

## Пример кода

**Команда

```
Get-InstalledVcRedist
```

**возвращает список установленных Redistributables. Можно отфильтровать вывод по конкретным свойствам, например:

```
Get-InstalledVcRedist | Select Name, Version, ProductCode
```

. [vcredist.com](https://vcredist.com/get-installedvcredist)

**Опциональный параметр

```
-ExportAll
```

**позволяет вернуть все установленные Redistributables, включая дополнительные и минимальные runtime, которые обычно скрыты в «Программах и функциях». Например:

```
Get-InstalledVcRedist -ExportAll
```

. [vcredist.com](https://vcredist.com/get-installedvcredist)

**Важно**: по умолчанию список не включает дополнительные и минимальные runtime. [vcredist.com](https://vcredist.com/get-installedvcredist)

## Ошибки

В некоторых случаях при проверке установки VCRedist с помощью PowerShell могут возникнуть ошибки, например, из-за некорректной работы условной проверки в операторе if в более ранних версиях PowerShell. В этом случае нужно изменить код, чтобы он работал на всех платформах, включая старые версии PowerShell. [stackoverflow.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F78380533%2Fneed-to-install-microsoft-visual-c-2015-2022-via-powershell)

**Важно**: при установке VCRedist рекомендуется использовать официальные источники — скачивание пакетов с непроверенных сайтов может быть опасным. [compmaster.site](https://compmaster.site/articles/vcredist-0x80070666-windows-10-11-2026.html)

### Ещё один скрипт

```powershell
# Source - https://stackoverflow.com/a/79334549
# Posted by Tilo
# Retrieved 2026-02-13, License - CC BY-SA 4.0

##check VC Redistributable packages installed
 Get-ChildItem HKLM:\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | ForEach-Object { 
    $CurDisplayName = $_.GetValue("DisplayName")
    if( $CurDisplayName -match "^Microsoft Visual C\+\+\D*(?<Year>(\d|-){4,9}).*Redistributable.*") {
        #$Year = $Matches.Year
        echo $Matches.0
    }
}
```
