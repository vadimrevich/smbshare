## 3.140.51 show ip dhcp bindings
Описание Показать статус DHCP server.
Если выполнить команду без аргумента,то
на экран будет выведен весь список выделенных IP для всех пулов.

Префиксno Нет

Меняет настройки Нет

Многократный вводН ет

Синопсис (show)> ip dhcp bindings[‹pool›]

Аргументы Описание Значение Аргумент

Имя пула. Строка pool

Пример 

```
(show)>ip dhcp bindings _WEBADMIN

lease:
ip:192.168.15.211
mac:00:26:c7:4a:e0:16
expires:289
hostname:lenovo

lease:
ip:192.168.15.208
mac:00:19:d2:48:d6:dc
expires:258
hostname:evo
```

## 3.140.52 show ip dhcp pool

Описание

Префиксno
Показать информацию об определенном пуле. Если выполнить команду
без аргумента, то на экран будет выведена информация обо всех пулах
системы.

Нет

Меняет настройки Нет

Многократный ввод Нет

Синопсис (show)> ip dhcp pool [‹pool›]

Аргументы

Аргумент

Значение

Описание

pool

Строка

Имяпула.

Пример

```
(show)> ip dhcp pool 123
pool, name = 123:
interface, binding = auto:
network: 0.0.0.0/0
begin: 0.0.0.0
end: 0.0.0.0
router, default = yes: 0.0.0.0
lease, default = yes: 25200
state: down
debug: n
```

## 3.140.50 show ip arp

Описание

Префиксno

Отображает содержимое кеша ARP.
Нет

Меняет настройки Нет

Многократный ввод Нет

Синопсис (show)> ip arp

Пример

```
(show)> ip arp
===================================================
510
Справочник команд —Extra (KN-1711)
IP MAC Interface
===================================================
192.168.75.209 9c:b7:0d:91:e7:31 Home
82.135.72.150 00:0e:0c:09:db:60 ISP
192.168.75.106 88:53:2e:5e:07:1d Home
192.168.75.201 7c:61:93:eb:6c:77 Home
192.168.75.203 00:19:d2:48:d6:dc Home
10.10.30.34 a0:88:b4:40:9c:98 GuestWiFi
192.168.75.203 7c:61:93:ee:88:67 Home
192.168.75.211 00:26:c7:4a:e0:16 Home
82.138.72.163 34:51:c9:c6:53:cf ISP
192.168.75.200 60:d8:19:cb:1b:36 Home
192.168.75.204 4c:0f:6e:4b:3c:ba Home
82.138.72.129 00:30:48:89:b5:9f ISP
```

**На устройствах Keenetic (например, Keenetic DSL) есть команда для настройки закрепления узлов DHCP в сети по MAC-адресу через интерфейс командной строки (CLI)**. Эта команда позволяет статически привязать IP-адрес к MAC-адресу, оставив прежнее значение IP-адреса, и наоборот — поменять IP-адрес, оставив прежнее значение MAC-адреса. [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

**Синопсис команды**:

```
(config)> ip dhcp host ‹name› [mac] [ip]
```

. [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

**Аргументы**: [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

-   **name** — произвольное имя хоста, используется для идентификации пары MAC-IP в настройках.
-   **mac** — MAC-адрес хоста для статической привязки IP-адреса. Если не указан, значение берётся из предыдущей настройки.
-   **ip** — IP-адрес хоста. Если не указан, значение берётся из предыдущей настройки.

 [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

## Пошаговая инструкция

**Пример использования команды**: [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

-   ```
    (config)&gt; ip dhcp host HOST 192.168.1.44
    ```
    
    — создаёт хост с именем HOST, MAC-адресом 192.168.1.44 и IP-адресом 192.168.1.44. [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

**Важно**:

-   Если указанный IP-адрес не входит в диапазон ни одного пула, команда сохранится в настройках, но на работу DHCP-сервера не повлияет.
-   Команда с префиксом
    
    ```
    no
    ```
    
    удаляет хост.

 [mcgrp.ru](https://mcgrp.ru/files/viewer/168405/84)

**Важно**: перед настройкой рекомендуется уточнить, делает ли интернет-провайдер привязку по MAC-адресу. Как правило, эту информацию можно посмотреть в договоре о подключении к интернету или узнать у поддержки интернет-провайдера.

# Полезные команды в CLI Zyxel Keenetic

[← Масштабирование экрана при подключении по rdp](https://www.admin01.ru//faq/zoom_the_screen_when_connecting_via_rdp.html)[↑ Вопрос-ответ](https://www.admin01.ru//faq/)[Настройка клавиатуры Apple A1243 в windows 10 →](https://www.admin01.ru//faq/configure_apple_keyboard_a1243_windows_10.html)

[Наша команда](https://www.admin01.ru//about_the_company/our_team/)

Иногда быстрее настраивать интернет центр Keenetic через CLI.

Например, создать несколько пробросов, или правил в firewall.

Подключение происходит через telnet, логин и пароль те же что для Web интерфейса

**Cоздание проброса через CLI**

создаем проброс для _TCP_ пакетов приходящих на порт _12345_ на ip _192.168.0.17_ с новым номером порта назначения _33333_

 _ip static tcp ISP 12345 192.168.0.17 33333_

 Сохраняем конфигурацию

_system configuration save_

**Удаление проброса через CLI**

Чтобы удалить проброс надо просто добавить в начало конмады “_no_”

_no ip static tcp ISP 12345 192.168.0.17 33333_

Сохраняем конфигурацию

_system configuration save_

**Редактирование firewall**

**Создаем правило**

Переходим в редактирование системного ACL с именем _\_WEBADMIN\_ISP_

_access-list \_WEBADMIN\_ISP_

Создаем правило разрешающее _TCP_ пакеты с адреса _9.8.7.6_ (и только его - _255.255.255.255_) на внешний адрес нашего роутера _1.2.3.4_ (и только его - _255.255.255.255_), на порт _1010_

_permit tcp 9.8.7.6 255.255.255.255 1.2.3.4 255.255.255.255 port eq 1010_

**Удаляем правило**

Чтобы удалить проброс надо просто добавить в начало конмады “no”

Переходим в редактирование системного ACL с именем _\_WEBADMIN\_ISP_

_access-list \_WEBADMIN\_ISP_  
_no permit tcp 9.8.7.6 255.255.255.255 1.2.3.4 255.255.255.255 port eq 1010_

**Просмотр пробросов UPNP**

_**Через WEB не доступно вообще.**_

_show upnp redirect_

# Полезные команды в CLI Zyxel Keenetic

[← Масштабирование экрана при подключении по rdp](https://www.admin01.ru//faq/zoom_the_screen_when_connecting_via_rdp.html)[↑ Вопрос-ответ](https://www.admin01.ru//faq/)[Настройка клавиатуры Apple A1243 в windows 10 →](https://www.admin01.ru//faq/configure_apple_keyboard_a1243_windows_10.html)

[Наша команда](https://www.admin01.ru//about_the_company/our_team/)

Иногда быстрее настраивать интернет центр Keenetic через CLI.

Например, создать несколько пробросов, или правил в firewall.

Подключение происходит через telnet, логин и пароль те же что для Web интерфейса

**Cоздание проброса через CLI**

создаем проброс для _TCP_ пакетов приходящих на порт _12345_ на ip _192.168.0.17_ с новым номером порта назначения _33333_

 _ip static tcp ISP 12345 192.168.0.17 33333_

 Сохраняем конфигурацию

_system configuration save_

**Удаление проброса через CLI**

Чтобы удалить проброс надо просто добавить в начало конмады “_no_”

_no ip static tcp ISP 12345 192.168.0.17 33333_

Сохраняем конфигурацию

_system configuration save_

**Редактирование firewall**

**Создаем правило**

Переходим в редактирование системного ACL с именем _\_WEBADMIN\_ISP_

_access-list \_WEBADMIN\_ISP_

Создаем правило разрешающее _TCP_ пакеты с адреса _9.8.7.6_ (и только его - _255.255.255.255_) на внешний адрес нашего роутера _1.2.3.4_ (и только его - _255.255.255.255_), на порт _1010_

_permit tcp 9.8.7.6 255.255.255.255 1.2.3.4 255.255.255.255 port eq 1010_

**Удаляем правило**

Чтобы удалить проброс надо просто добавить в начало конмады “no”

Переходим в редактирование системного ACL с именем _\_WEBADMIN\_ISP_

_access-list \_WEBADMIN\_ISP_  
_no permit tcp 9.8.7.6 255.255.255.255 1.2.3.4 255.255.255.255 port eq 1010_

**Просмотр пробросов UPNP**

_**Через WEB не доступно вообще.**_

_show upnp redirect_

**Команда «show interface»** в интерфейсе командной строки (CLI) устройств Keenetic **отображает информацию об интерфейсе**. Она может выводить данные о типе интерфейса, его описании, состоянии, адресе, маске и других параметрах. [support.keenetic.ru](https://support.keenetic.ru/air/kn-1613/ru/22346-configuring-firewall-rules-from-the-command-line-interface.html)[manualslib.com](https://www.manualslib.com/manual/1509090/Keenetic-Extra-Kn-1710.html?page=251)[mcgrp.ru](https://mcgrp.ru/files/viewer/168392/124)

Если не указать аргумент, команда выводит список всех сетевых интерфейсов. [manualslib.com](https://www.manualslib.com/manual/1509090/Keenetic-Extra-Kn-1710.html?page=251)

## Синтаксис

**Формат команды**:

```
(show)> interface ‹name›
```

. [mcgrp.ru](https://mcgrp.ru/files/viewer/168392/124)

**Аргумент** — полное имя или псевдоним интерфейса, информацию о котором требуется отобразить. [mcgrp.ru](https://mcgrp.ru/files/viewer/168392/124)

**Важно**: команда выводит различную информацию в зависимости от типа интерфейса. Например, для коммутатора Switch0 она помимо общих сведений показывает текущее состояние физических портов, скорость и дуплекс. [mcgrp.ru](https://mcgrp.ru/files/viewer/168392/124)

## Пример

**Пример вывода команды «show interface» для интерфейса ISP**:

> (config)> show interface ISP  
> id: GigabitEthernet1  
> index: 1  
> type: GigabitEthernet  
> description: Broadband connection  
> interface-name: ISP  
> link: up  
> connected: yes  
> state: up  
> mtu: 1500  
> tx-queue: 2000  
> address: 193.0.174.199  
> mask: 255.255.255.0  
> uptime: 12433  
> global: yes  
> defaultgw: yes  
> priority: 700  
> security-level: public  
> mac: 50:ff:20:2d:ed:ea  
> auth-type: none [support.keenetic.ru](https://support.keenetic.ru/air/kn-1613/ru/22346-configuring-firewall-rules-from-the-command-line-interface.html)

**В строке security-level** указан уровень безопасности, соответственно которому работает преднастроенная политика сетевого экрана. По умолчанию всем вновь созданным через командную строку интерфейсам присваивается уровень безопасности public.


Опубликовано 5 января

Ощущение что в логах две отдельные таблицы, делаешь выборку по тексту, находит текст без даты, делаешь выборку по дате, выдаёт только дату.

необходимо сделать вывод строки полностью, иначе пользоваться такой выборкой невозможно.

примеры:

(config)> show log onc

 Usage template:  
              log \[{max-lines}\] \[once\]

(config)> show log once | grep NAK  
\=====================  
  Time              Message  
\=====================  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.  
I \[??? ?? ??:??:??\] : FastEthernet0/Vlan4000: recieved NAK.

(config)> show log once | grep 11:07:31  
\=====================  
 Time             Message  
\=====================  
 \[Jan  5 11:07:31\] :  
 \[Jan  5 11:07:31\] :  
 \[Jan  5 11:07:31\] :  
  
(config)> show log once | grep SSH

\====================  
  Time              Message  
\====================  
I \[??? ?? ??:??:??\] : Ssh::Manager: SSH server enabled.  
I \[??? ?? ??:??:??\] : Core::Authenticator: "\*" logged in, SSH authenticated.  
I \[??? ?? ??:??:??\] : Core::Authenticator: "\*" logged in, SSH authenticated.  
I \[??? ?? ??:??:??\] : Core::Authenticator: "\*" logged in, SSH authenticated.

получается что сейчас вижу что произошло событие, но не знаю когда

-   [Цитата](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2//#)

## 2 ответа на этот вопрос

-   [Сортировать по голосам](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2/)
-   [Сортировать по дате](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2/?sortby=date)

## Рекомендуемые сообщения

-   0

 [![sergeyk](data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%201024%201024%22%20style%3D%22background%3A%2362c49a%22%3E%3Cg%3E%3Ctext%20text-anchor%3D%22middle%22%20dy%3D%22.35em%22%20x%3D%22512%22%20y%3D%22512%22%20fill%3D%22%23ffffff%22%20font-size%3D%22700%22%20font-family%3D%22-apple-system%2C%20BlinkMacSystemFont%2C%20Roboto%2C%20Helvetica%2C%20Arial%2C%20sans-serif%22%3ES%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fsvg%3E)](https://forum.keenetic.ru/profile/7759-sergeyk/ "Перейти в профиль sergeyk")[![Старожил](https://forum.keenetic.ru/uploads/set_resources_10/84c1e40ea0e759e3f1505eb1788ddf3c_default_rank.png "Звание: Старожил (5/6)")](https://forum.keenetic.ru/profile/7759-sergeyk/badges/)

### [sergeyk](https://forum.keenetic.ru/profile/7759-sergeyk/ "Перейти в профиль sergeyk")

[Опубликовано 5 января](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2/#findComment-196313)

### **[sergeyk](https://forum.keenetic.ru/profile/7759-sergeyk/ "Перейти в профиль sergeyk")**

-    [![sergeyk](data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%201024%201024%22%20style%3D%22background%3A%2362c49a%22%3E%3Cg%3E%3Ctext%20text-anchor%3D%22middle%22%20dy%3D%22.35em%22%20x%3D%22512%22%20y%3D%22512%22%20fill%3D%22%23ffffff%22%20font-size%3D%22700%22%20font-family%3D%22-apple-system%2C%20BlinkMacSystemFont%2C%20Roboto%2C%20Helvetica%2C%20Arial%2C%20sans-serif%22%3ES%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fsvg%3E)](https://forum.keenetic.ru/profile/7759-sergeyk/ "Перейти в профиль sergeyk")![Старожил](https://forum.keenetic.ru/uploads/set_resources_10/84c1e40ea0e759e3f1505eb1788ddf3c_default_rank.png "Звание: Старожил (5/6)")
    
-   Участники форума
-   -   [1,5 тыс](https://forum.keenetic.ru/profile/7759-sergeyk/content/ "1 512 сообщений")
    -   [9](https://forum.keenetic.ru/profile/7759-sergeyk/solutions/ "9 решений")
-   **Устройства:** All models

-   [](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2//#elControls_196313_menu "Ещё...")
    

Опубликовано 5 января

>  [](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2//#) [](https://forum.keenetic.ru//forum.keenetic.ru/?app=core&module=system&controller=content&do=find&content_class=forums_Topic&content_id=19801&content_commentid=196307)В 05.01.2025 в 11:22, [kirk88](https://forum.keenetic.ru//forum.keenetic.ru/?app=core&module=members&controller=profile&id=74855) сказал:
> 
> получается что сейчас вижу что произошло событие, но не знаю когда

Попробуйте так

```
show log once | grep -C 1 NAK
```

-    ![Лайк](https://forum.keenetic.ru/uploads/reactions/react_up_120.png)1

-   [Цитата](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2//#)

-   0

 [![kirk88](https://forum.keenetic.ru/uploads/
 
 monthly_2023_10/1920x1200_833222_www.ArtFile_ru.thumb.jpg.c24f3c6d595f506269cf82c20e3e8ed8.jpg)](https://forum.keenetic.ru/profile/74855-kirk88/ "Перейти в профиль kirk88")[![Пользователь](https://forum.keenetic.ru/uploads/set_resources_10/84c1e40ea0e759e3f1505eb1788ddf3c_default_rank.png "Звание: Пользователь (2/6)")](https://forum.keenetic.ru/profile/74855-kirk88/badges/)

### [kirk88](https://forum.keenetic.ru/profile/74855-kirk88/ "Перейти в профиль kirk88")

[Опубликовано 5 января](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2/#findComment-196333)

### **[kirk88](https://forum.keenetic.ru/profile/74855-kirk88/ "Перейти в профиль kirk88")**

-    [![kirk88](https://forum.keenetic.ru/uploads/monthly_2023_10/1920x1200_833222_www.ArtFile_ru.thumb.jpg.c24f3c6d595f506269cf82c20e3e8ed8.jpg)](https://forum.keenetic.ru/profile/74855-kirk88/ "Перейти в профиль kirk88")![Пользователь](https://forum.keenetic.ru/uploads/set_resources_10/84c1e40ea0e759e3f1505eb1788ddf3c_default_rank.png "Звание: Пользователь (2/6)")
    
-   Участники форума
-   -   [35](https://forum.keenetic.ru/profile/74855-kirk88/content/ "35 сообщений")
-   **Устройства:** kn-3010, kn-1010, kn-1212, kn-1912, kn-3210, kn-1711, kn-1310

-   **Автор**

-   [](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2//#elControls_196333_menu "Ещё...")
    

Опубликовано 5 января

>  [](https://forum.keenetic.ru/topic/19801-grep-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2//#) [](https://forum.keenetic.ru//forum.keenetic.ru/?app=core&module=system&controller=content&do=find&content_class=forums_Topic&content_id=19801&content_commentid=196313)В 05.01.2025 в 12:58, [sergeyk](https://forum.keenetic.ru//forum.keenetic.ru/?app=core&module=members&controller=profile&id=7759) сказал:
> 
> Попробуйте так
> 
> ```
> show log once | grep -C 1 NAK
> ```

действительно так показывает, благодарю.

(config)> show log once | grep -C 1 NAK  
\========================================================================================================================  
  Time              Message  
\========================================================================================================================  
I \[Dec 23 16:54:31\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Dec 24 16:55:28\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Dec 26 17:02:21\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Dec 28 17:09:15\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Dec 29 17:10:11\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Dec 31 17:17:03\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Jan  1 17:18:00\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Jan  2 17:18:56\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.  
I \[Jan  5 17:31:46\] ndhcpc: FastEthernet0/Vlan4000: recieved NAK.

здорово было бы добавить к консоль man по команде grep через tab или ? что б не запоминать возможные переменные grep

## Тест соединений

В интерфейсе командной строки (CLI) роутеров Keenetic доступны команды **tools arping** и **tools ping**. [storage.googleapis.com](https://storage.googleapis.com/docs.help.keenetic.com/cli/3.9/ru/cli_manual_kn-1910_ru.pdf)[storage.googleapis.com](https://storage.googleapis.com/docs.help.keenetic.com/cli/3.8/ru/cli_manual_kn-1711_ru.pdf)

## Команда

```
tools arping
```

Используется для отправки ARP-запросов и проверки доступности устройств в локальной сети по MAC-адресам. Позволяет имитировать поведение классической команды

```
arp
```

и проверить, какие устройства сопоставлены с определёнными IP-адресами в сети.

## Команда

```
tools ping
```

Позволяет отправлять ICMP-пакеты (пинг) для проверки доступности узлов в сети. С её помощью можно проверить связь с конкретным IP-адресом или именем хоста.

## Как подключиться к CLI

Для подключения к интерфейсу командной строки можно использовать протоколы Telnet или SSH. После подключения обычно требуется ввести пароль администратора. Для удобства ввода команд и параметров доступна функция автодополнения (с помощью клавиши Tab). [destek.keenetic.com.tr](https://destek.keenetic.com.tr/extra-dsl/kn-2111/en/18480-command-line-interface--cli-.html)

Подробные справочники команд для конкретных моделей роутеров Keenetic можно найти на официальном сайте в разделе Download Center, выбрав нужную модель. [destek.keenetic.com.tr](https://destek.keenetic.com.tr/extra-dsl/kn-2111/en/18480-command-line-interface--cli-.html)

**Важно:** при работе с CLI следует соблюдать осторожность, так как неправильные команды могут нарушить работу устройства. Рекомендуется внимательно изучать документацию и делать резервные копии настроек.
