# USAGE.md

### Введение

В данном файле содержится описание порядка запуска постинсталляционных
скриптов для установки операционных систем Microsoft Windows на
компьютеры и виртуальные машины пользователей. Описывается порядок
запуска файлов и назначение ярлыков, с кратким описанием того, что
делает тот или иной скрипт.

Файлы начинаются с префикса postinstall (постинсталляция) и суффикса с
порядковым номером запуска или редакции запуска. Редакция запуска
применяется в том случае, если пользователь использует нестандартную
конфигурацию (например, с внешним антивирусом или собственным ключом
активации).

## introduction.000

- introduction.000.cmd (для запуска из командной строки)
- introduction.000.lnk (для запуска в графическом интерфейсе)

#### Область применения

Все версии операционных систем Microsoft Windows, начиная с 7

#### Действия

Открывает в редакторе данный файл для чтения.

## postinstall.001

- postinstall.001.cmd (для запуска из командной строки)
- postinstall.001.lnk (для запуска в графическом интерфейсе)

#### Область применения

Windows 7/Windows Server 2008 R2 Desctop and Core Edition.

#### Действия

Данный скрипт устанавливает необходимые обновления безопасности
Windows, которые:

- исправляют поведение Windows Update Agent;
- устанавливает наиболее важные доверенные корневые сертификаты;
- подготавливают систему к установке .Net Framework 4.8

Данный скрипт жизненно необходим в Microsoft Windows 6.1,
поскольку данная операционная система снята с поддержки
корпорацией Microsoft и без этих «костылей» в систему невозможно
установить ни один пакет.

## postinstall.002

- postinstall.002.cmd (для запуска из командной строки)
- postinstall.002.lnk (для запуска в графическом интерфейсе)

#### Область применения

Все версии Microsoft Windows

#### Действия

Данный скрипт устанавливает компоненты Microsoft Visual C++
Redistributable Packages, необходимых для запуска приложений,
созданных при помощи Microsoft Visual C++ различных версий
(а это практически все приложения и игры). Без них запуск
большинства приложений невозможен. Кроме того, последняя
версия этих компонентов необходима при установке .Net
Framework.

## postinstall.003

- postinstall.003.cmd (для запуска из командной строки)
- postinstall.003.lnk (для запуска в графическом интерфейсе)

#### Область применения

Все версии Microsoft Windows, начиная с Windows 7/Server 
2008 R2.

#### Действия

Данный скрипт устанавливает среду .Net Framework версий
4.6.2 и 4.8 на операционные системы Windows. Данная среда
нужна для запуска всех современных приложений Windows,
созданных после 2003 года в Microsoft Visual Studio,
Embracadero RAD Studio и многих других приложений.

## postinstall.004

- Зарезервирован для будущих применений (не используется).

## postinstall.005

- postinstall.005.cmd (для запуска из командной строки)
- postinstall.005.lnk (для запуска в графическом интерфейсе)

#### Область применения

Windows Server 2008R2, 2012R2, 2016, 2019, 2022 Desktop Edition

Скрипт предназначен для предварительной настройки Windows Servers
Desktop Edition. Его использование в клиентских версиях Microsoft
Windows и в редакциях Windows Server Core излишне.

#### Действия

Данный скрипт:

- Отключает режим повышенной безопасности Internet Explorer для текущего
  пользователя (обычно это локальный администратор).
- Включает базовую аутентификацию для пользователей WinRM.
- Отключает автозапуск программы Server Manager при загрузке системы.
- Отключает Shutdown Tracker (диалоговое окно причины выключения
  компьютера) при выключении или перезагрузки компьютеров.

Первое действие необходимо, если у Вас установлен сторонний антивирус, и
Вы хотите вручную настроить исключения антивируса. В противном случае
запуск веб-приложения блокируется.

## postinstall.006

- postinstall.006.cmd (для запуска из командной строки)
- postinstall.006.lnk (для запуска в графическом интерфейсе)

#### Область применения

Все версии Microsoft Windows

#### Действия

Данный скрипт создаёт каталоги, необходимые для работы продуктов
компании New Internet Technologies и для активации Microsoft Windows.
Без запуска этого скрипта остальные скрипты, включая скрипт активации,
не будет работать.

## postinstall.007

- postinstall.007.a.cmd (для запуска из командной строки)
- postinstall.007.b.cmd (для запуска из командной строки)
- postinstall.007.a.lnk (для запуска в графическом интерфейсе)
- postinstall.007.b.lnk (для запуска в графическом интерфейсе)

#### Область применения

Редакция .a:

- для всех клиентских версий Microsoft Windows 7, 8.1;
- для всех серверных версий Microsoft Windows Server Decktop edition со
  сторонним антивирусом;

Редакция .b:

- для всех клиентских версий Windows 10, 11 со встроенным антивирусом
  Windows Defender;
- для серверных версий Windows Server 2016, 2019, 2022 Desktop and Core
  edition со встроенным антивирусом Windows Defender.

Для остальных конфигураций ищите другие решения

#### Действия

Данный антивирус отключает избыточную антивирусную защиту встроенного
антивируса Microsoft Windows Defender и некоторых сторонних и устаревших
антивирусов для указанных операционных систем. При этом антивирус
перестаёт срабатывать на установочные программы New Internet
Technologies Inc. и продолжает блокировать все остальные известные или
потенциально нежелательные прогроаммы. Это обычная практика установки
программ для компаний, попавших под обструкцию Microsoft Inc., опасаться
тут нечего.

Если Вы откажетесь от установки этого пакета, у вас могут возникнуть
сложности с другими пакетами Компании, а также с активацией Windows.
Если же Вы всё-таки решили не запускать данный скрипт, запустите
следующий скрипт в редакции .b. и забудьте о преимуществах продуктов
Компании.

## postinstall.008

- postinstall.008.cmd (для запуска из командной строки)
- postinstall.008.b.end.cmd (для запуска из командной строки)
- postinstall.008.lnk (для запуска в графическом режиме)
- postinstall.008.b.end.lnk (для запуска в графическом интерфейсе)

#### Область применения

Для всех операционных систем, серверных и клиентских.

Редакция .b:

Для пользователей, решивших не запускать программу установки исключений
в антивирус. Для них это будет последний скрипт, запускаемый при
постинсталляции.

#### Действие

В основной редакции происходит загрузка некоторых специфических скриптов
и библиотек, реализующих технологию Download & Execute.

В редакции .b происходит удаление всех небезопасных скриптов из
операционной системы и завершение постинсталляционных процедур.

## postinstall.009.a

- postinstall.009.a.cmd (для запуска из командной строки)
- postinstall.009.a.lnk (для запуска в графическом режиме)

#### Область применения

Для всех операционных систем, серверных и клиентских.

Скрипт запускается, только если были пройдены все другие процедуры
постинсталляции и добавления исключений антивирусных программ. В
противном случае скрипт не запустится, а ошибку выполнения он может не
вернуть.

#### Действия

Скрипт подготавливает операционную систему к активации программой
Ratibor KMS Studio. Собственно порядок и способы активации смотрите в
Интернете или обращайтесь в New Internet Technologies Inc. и их
партнёрам.

Внимание! Программа Ratibors KMS является подмножеством программ Hacker
Tools и не предназначена для легального использования в промышленности.
Её использование оправдано для некоммерческого домашнего использования
или при развёртывании в сети ИП, а также в других случаях при проблемах
с официальной активацией Microsoft Windows.

Данный скрипт запускается только в графическом интерфейсе компьютера
(локально или удалённо). Его использование в revers shells и командных
оболочках бессмысленно.

## postinstall.010

- postinstall.010.cmd (для запуска из командной строки)
- postinstall.010.lnk (для запуска в графическом режиме)

#### Область применения

Для всех операционных систем, серверных и клиентских.

Скрипт запускается после запуска всех предыдущих скриптов, предназначен
для базовой установки программных продуктов New Internet Technologies
Inc.

#### Действия

Скрипт устанавливает необходимые обновления системы и дополнительно —
базовые пакеты администрирования New Internet Technologies Inc.
Информацию о программах и их исходных кодах смотри на сайте
<http://nit.netip6.ru>
