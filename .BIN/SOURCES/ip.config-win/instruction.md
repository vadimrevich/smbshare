# ИНСТРУКЦИЯ
по назначению собственных значений для командных файлов

Для корректного применения настроек к Вашему компьютеру или серверу, Вы должны изменить глобально следуюущие переменные в вашем командном файле:

rem Define Local Variables (must be changed)
- set main_dns_suffix=<Ваш DNS суффикс (доменное имя)>
- set newcomputername=<Имя Вашего компьютера>
- set newworkgroup=<Имя Вашей рабочей круппы (обычно WORKGROUP)>
- set interface_name="<имя Вашего рабочего сетевого интерфейса>"
- set ip_address=<Ваш статический IPv4 адрес компьютера>
- set ip_mask=<Маска IPv4 адреса (уточняйте у администратора, для сетей C это 255.255.255.0)>
- set ip_gateway=<Основной Интернет-шлюз Вашей сети>
- set first_dns=<Первичный DNS (обычно задаётся провайдером или маршрутизатором)>
- set second_dns=<Вторичный DNS сервер>
- set third_dns=<Третий DNS сервер>

#### Для IPv6 адресов:

- set ip_address=<Ваш статический IPv6 адрес компьютера>
- set ip_mask=<Префикс IPv6 адреса (уточняйте у администратора, обычно он равен 64)>
- set ip_gateway=<Основной IPv6 Интернет-шлюз Вашей сети>
- set first_dns=<Первичный DNS (обычно задаётся провайдером или маршрутизатором)>
- set second_dns=<Вторичный DNS сервер>
- set third_dns=<Третий DNS сервер>
- 