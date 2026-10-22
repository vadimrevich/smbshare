# Требования для SQL Server 2025

# Требования к оборудованию и программному обеспечению для SQL Server 2025 г.

Обратная связь

## В этой статье

1.  [Требования к оборудованию](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#hardware-requirements)
2.  [Требования к программному обеспечению](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#software-requirements)
3.  [Поддержка операционной системы](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#operating-system-support)
4.  [Поддержка межязыковая](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#cross-language-support)
5.  [Требования к дисковой области](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#drive-space-requirements)
6.  [Типы хранения файлов данных](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#storage-types-for-data-files)
7.  [Установка SQL Server на контроллере домена](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#install-sql-server-on-a-domain-controller)
8.  [Установочный носитель](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#installation-media)
9.  [Связанный контент](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#related-content)

Показать еще 5

**Применимо к:**![](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17../../includes/media/yes-icon.svg?view=sql-server-ver17)[SQL Server](https://learn.microsoft.com/ru-ru/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver17#applies-to) в Windows

В этой статье перечислены минимальные требования к оборудованию и программному обеспечению для установки и запуска SQL Server 2025 (17.x) в операционной системе Windows.

Требования к оборудованию и программному обеспечению для других версий SQL Server см. в статье:

-   [SQL Server 2022](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver17)
-   [SQL Server 2019](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2019?view=sql-server-ver17)
-   [SQL Server 2016 и 2017](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-ver17)
-   [SQL Server на Linux](https://learn.microsoft.com/ru-ru/sql/linux/sql-server-linux-setup?view=sql-server-ver17#system-requirements)

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#hardware-requirements)

## Требования к оборудованию

Следующие требования к памяти и процессору применяются ко всем выпускам SQL Server:

Развернуть таблицу

| Компонент | Требование |
| --- | --- |
| **Хранение** | SQL Server требует не менее 6 ГБ доступного места на жестком диске.  
  
Требования к месту на диске зависят от установленных компонентов SQL Server. Более подробную информацию смотрите в разделе [Требования к месту на диске](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#drive-space-requirements) далее в данной статье. Для получения информации о поддерживаемых типах хранилищ для файлов данных см. раздел [Типы хранилищ для файлов данных](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#storage-types-for-data-files). |
| **Монитор** | SQL Server требует монитор с разрешением Super-VGA (800x600) или выше. |
| **Интернет** | Для работы в Интернете требуется доступ к Интернету (плата может применяться). |
| **Память** |  |
| Минимальный объем памяти | — Выпуски Express: 512 МБ  
  
— Все остальные выпуски: 1 ГБ |
| Рекомендуемая память | — Выпуски Express: 1 ГБ  
  
— Все остальные выпуски: не менее 4 ГБ и должны быть увеличены по мере увеличения размера базы данных, чтобы обеспечить оптимальную производительность. |
| **Процессор** |  |
| Тип процессора | Процессор x64. Все процессоры Intel и AMD x86-64 с [до 64 ядер на узел NUMA](https://learn.microsoft.com/ru-ru/sql/sql-server/compute-capacity-limits-by-edition-of-sql-server?view=sql-server-ver17#numa-64). |
| Минимальная скорость | 1,4 ГГц |
| Рекомендуемая скорость | 2,0 ГГц или быстрее |

Примечание.

Установка SQL Server поддерживается только на процессорах x64.

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#software-requirements)

## Требования к программному обеспечению

Следующие требования относятся ко всем видам установки.

Развернуть таблицу

| Компонент | Требование |
| --- | --- |
| Операционная система | \- Windows 10 или больше  
— Windows Server 2019 или более поздней версии |
| платформа .NET | SQL Server 2025 (17.x) требуется .NET Framework 4.7.2. |
| Сетевое программное обеспечение | Поддерживаемые операционные системы для SQL Server имеют встроенное сетевое программное обеспечение. Именованные и стандартные экземпляры автономной установки поддерживают следующие сетевые протоколы: общая память, именованные каналы и TCP/IP. |

SQL Server программа установки устанавливает следующие компоненты программного обеспечения, необходимые для продукта:

-   Microsoft ODBC Driver 17 и 18 для SQL Server
-   Microsoft OLE DB Driver 18 и 19 for SQL Server
-   файлы поддержки программы установки SQL Server

Внимание

Компонент PolyBase имеет дополнительные требования к оборудованию и программному обеспечению. Дополнительные сведения см. в статье [Data virtualization with PolyBase in SQL Server](https://learn.microsoft.com/ru-ru/sql/relational-databases/polybase/overview?view=sql-server-ver17).

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#operating-system-support)

## Поддержка операционной системы

В следующей таблице показано, какие выпуски SQL Server 2025 (17.x) совместимы с версиями Windows. Вы также можете использовать сведения о жизненном цикле поддержки, чтобы узнать, поддерживается ли ваша версия Windows.

Развернуть таблицу

| SQL Server редакция: | Предприятие <sup>1</sup> | Стандартный <sup>1</sup> | Экспресс |
| --- | --- | --- | --- |
| **Windows Server 2025** ([жизненный цикл поддержки](https://learn.microsoft.com/ru-ru/lifecycle/products/windows-server-2025)) |  |  |  |
| Центр обработки данных Windows Server 2025 | Да | Да | Да |
| Windows Server 2025 Datacenter: Azure Edition | Да | Да | Да |
| Windows Server 2025 Standard | Да | Да | Да |
| Windows Server 2025 Essentials | Да | Да | Да |
| **Windows Server 2022** ([жизненный цикл поддержки](https://learn.microsoft.com/ru-ru/lifecycle/products/windows-server-2022)) |  |  |  |
| Центр обработки данных Windows Server 2022 | Да | Да | Да |
| Windows Server 2022 Datacenter: Azure Edition | Да | Да | Да |
| Windows Server 2022 Standard | Да | Да | Да |
| Windows Server 2022 Essentials | Да | Да | Да |
| **Windows Server 2019** ([жизненный цикл поддержки](https://learn.microsoft.com/ru-ru/lifecycle/products/windows-server-2019)) |  |  |  |
| Центр обработки данных Windows Server 2019 | Да | Да | Да |
| Windows Server 2019 Standard | Да | Да | Да |
| Windows Server 2019 Essentials | Да | Да | Да |
| **Windows 11** (цикл поддержки [](https://learn.microsoft.com/ru-ru/lifecycle/products/windows-11-home-and-pro)) |  |  |  |
| Windows 11 IoT для предприятия | нет | Да | Да |
| Windows 11 Корпоративная | нет | Да | Да |
| Windows 11 профессиональный | нет | Да | Да |
| Windows 11 главная | нет | Да | Да |
| **Windows 10** (жизненный цикл поддержки) |  |  |  |
| Windows 10 IoT Enterprise | нет | Да | Да |
| Windows 10 Корпоративная | нет | Да | Да |
| Windows 10 профессиональный | нет | Да | Да |
| Windows 10 главная | нет | Да | Да |

<sup>1</sup> SQL Server 2025 (17.x) вводит отдельные выпуски Enterprise Developer и Standard Developer SQL Server.

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#server-core-support)

### Поддержка Server Core

Следующие выпуски windows Server Core поддерживают установку SQL Server 2025 (17.x):

-   Windows Server 2025 Core
-   Windows Server 2022 Core
-   Windows Server 2019 Core

Дополнительные сведения об установке SQL Server на серверных ядрах см. в разделе [Install SQL Server на сервере Core](https://learn.microsoft.com/ru-ru/sql/database-engine/install-windows/install-sql-server-on-server-core?view=sql-server-ver17).

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#cross-language-support)

## Поддержка межязыковая

Дополнительные сведения о поддержке и рекомендациях по установке SQL Server на локализованных языках см. в разделе [Local language versions in SQL Server](https://learn.microsoft.com/ru-ru/sql/sql-server/install/local-language-versions-in-sql-server?view=sql-server-ver17).

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#drive-space-requirements)

## Требования к дисковой области

Во время установки SQL Server установщик Windows создает временные файлы на системном диске. Перед запуском программы установки для установки или обновления SQL Server убедитесь, что на системном диске для этих файлов имеется не менее 6 ГБ свободного места. Это требование применяется даже при установке SQL Server компонентов на диск, отличный от используемого по умолчанию.

Фактические требования к месту на жестком диске зависят от конфигурации системы и компонентов, которые вы решили установить. В следующей таблице приведены требования к дисковой области для компонентов SQL Server.

Развернуть таблицу

| Функция | Требование места на диске |
| --- | --- |
| СУБД и файлы данных, репликация, полнотекстовый поиск | 1480 МБ |
| Служба базы данных (как предыдущая строка) со службами R (в базе данных) | 2 744 МБ |
| Database Engine (как предыдущая строка) со службой запросов PolyBase для внешних данных | 4 194 МБ |
| Службы анализа и файлы данных | 698 МБ |
| Службы отчетности | 967 МБ |
| Microsoft R Server (изолированная версия) | 280 МБ |
| Reporting Services — SharePoint | 1203 МБ |
| надстройка Reporting Services для продуктов SharePoint | 325 МБ |
| Клиент контроля качества данных | 121 МБ |
| Подключение клиентских инструментов | 328 МБ |
| Услуги по интеграции | 306 МБ |
| Клиентские компоненты (кроме компонентов SQL Server Books Online и средств Integration Services) | 445 МБ |
| SQL Server компоненты Books Online для просмотра и управления справочным содержимым <sup>1</sup> | 27 МБ |
| Все функции | 8 030 МБ |

<sup>1</sup> Требование дискового пространства для скачаемого содержимого электронной документации составляет 200 МБ.

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#storage-types-for-data-files)

## Типы хранения файлов данных

Поддерживаемые типы хранения для файлов данных:

-   **Локальный диск**
    
    -   SQL Server в настоящее время поддерживает диски с стандартными размерами собственного сектора в 512 байтах и 4 КБ. Дополнительные сведения о поддержке более крупных размеров секторов и реализации изготовителя см. в разделе "Размеры секторов дисков 4 КБ" в белой книге _SQLIOBasicsCh2.doc_. Вы можете скачать белую книгу из раздела [Download](https://learn.microsoft.com/ru-ru/previous-versions/sql/sql-server-2005/administrator/cc917726(v=technet.10)#download) статьи [SQL Server I/O Basics, Chapter 2](https://learn.microsoft.com/ru-ru/previous-versions/sql/sql-server-2005/administrator/cc917726(v=technet.10)).
        
        Если вы используете диски расширенного формата, которые физически форматируются с 4096 байтами, но предоставляют размер логического сектора размером 512 байт, вы можете узнать больше о поведении и рекомендациях в статье Tech Community [SQL Server — новые диски используют размер сектора 4K](https://techcommunity.microsoft.com/blog/sqlserversupport/sql-server---new-drives-use-4k-sector-size/316277).
        
        Жесткие диски с размером сектора, превышающим 4 КБ, могут привести к ошибкам при попытке сохранить SQL Server файлы данных на них. Дополнительные сведения о поддержке размера сектора жесткого диска в SQL Server см. в разделе [Troubleshoot SQL Server ошибки, связанные с размером сектора системного диска, превышающим 4 КБ](https://learn.microsoft.com/ru-ru/troubleshoot/sql/database-engine/database-file-operations/troubleshoot-os-4kb-disk-sector-size). В настоящее время ключ реестра `ForcedPhysicalSectorSizeInBytes` необходим для успешной установки SQL Server на некоторых новых устройствах хранения, где размер сектора системного диска превышает 4 КБ.
        
    -   Установка отказоустойчивого кластера SQL Server поддерживает только локальный диск для установки файлов `tempdb`. Убедитесь, что путь, указанный для `tempdb` файлов данных и журналов, действителен на всех узлах кластера. При переключении на резервный ресурс, если каталоги `tempdb` недоступны на целевом узле, ресурс SQL Server не удается запустить.
        
-   **Общее хранилище**
    
-   **[Storage Spaces Direct (S2D)](https://learn.microsoft.com/ru-ru/windows-server/storage/storage-spaces/storage-spaces-direct-overview)**
    
-   **Общий файловый ресурс SMB**
    
    -   Хранилище SMB не поддерживается для файлов данных служб SQL Server Analysis Services для автономных или кластеризированных установок. Вместо этого используйте прямое подключение хранилища, сеть области хранилища или S2D.
        
    -   Хранилище SMB можно разместить на файловом сервере Windows или стороннем устройстве хранения SMB. При использовании Файлового сервера Windows версия должна быть 2008 или более поздней. Дополнительные сведения об установке SQL Server с использованием общей папки SMB в качестве опции хранилища см. в разделе [Установка SQL Server с хранилищем SMB](https://learn.microsoft.com/ru-ru/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option?view=sql-server-ver17).
        

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#install-sql-server-on-a-domain-controller)

## Установка SQL Server на контроллере домена

По соображениям безопасности не устанавливайте SQL Server на контроллере домена. Программа установки SQL Server не блокирует установку на компьютере, который является контроллером домена, но применяются следующие ограничения.

-   Нельзя запускать службы SQL Server на контроллере домена в локальной учетной записи службы.
    
-   После установки SQL Server на компьютере невозможно изменить компьютер с члена домена на контроллер домена. Перед изменением хост-компьютера на контроллер домена необходимо удалить SQL Server.
    
-   После установки SQL Server на компьютере невозможно изменить компьютер с контроллера домена на член домена. Перед преобразованием компьютера из хоста в доменный участник необходимо удалить SQL Server.
    
-   SQL Server экземпляры отказоустойчивого кластера не поддерживаются, где узлы кластера являются контроллерами домена.
    
-   SQL Server не поддерживается на контроллере домена только для чтения. Установка SQL Server не может создавать группы безопасности и учетные записи службы SQL Server на контроллере домена только для чтения. В этом сценарии установка завершается сбоем.
    
-   Экземпляр отказоустойчивого кластера SQL Server не поддерживается в среде, где доступен исключительно контроллер домена только для чтения.
    

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#installation-media)

## Установочный носитель

Получите соответствующий носитель установки из следующих расположений:

-   центр оценки [SQL Server 2025](https://www.microsoft.com/evalcenter/evaluate-sql-server-2025)
-   [Последние накопительные обновления](https://learn.microsoft.com/ru-ru/troubleshoot/sql/releases/download-and-install-latest-updates?bc=%2fsql%2fbreadcrumb%2ftoc.json&toc=%2fsql%2ftoc.json)

Кроме того, можно развернуть [SQL Server на виртуальной машине Azure в Azure portal](https://learn.microsoft.com/ru-ru/azure/azure-sql/virtual-machines/windows/sql-vm-create-portal-quickstart). Из-за накладных расходов виртуализации виртуальные машины могут быть медленнее, чем при работе в нативном режиме.

[](https://learn.microsoft.com/ru-ru/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025?view=sql-server-ver17#related-content)

## Связанный контент

-   [План установки SQL Server](https://learn.microsoft.com/ru-ru/sql/sql-server/install/planning-a-sql-server-installation?view=sql-server-ver17)
-   Вопросы безопасности при установке SQL Server<|vq\_850|>

