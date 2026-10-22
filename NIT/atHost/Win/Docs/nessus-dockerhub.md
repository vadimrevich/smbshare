**На Docker Hub доступен образ сканера уязвимостей Nessus** от компании Tenable. Доступны разные версии: Nessus Essentials, Nessus Professional и Nessus Manager. [help.sweb.ru](https://help.sweb.ru/kak-ispol6zovat6-nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-2204_1399.html)[hub.docker.com](https://hub.docker.com/r/travix/nessus)[hamradio.my](https://hamradio.my/2025/07/deploying-tenable-nessus-in-docker-fast-portable-vulnerability-scanning/)

**Ссылка на образ**: [hub.docker.com](https://hub.docker.com/r/tenable/nessus). [docs.tenable.com](https://docs.tenable.com/nessus/Content/DeployNessusDocker.htm)

**Особенности**:

-   Nessus обнаруживает уязвимости в системах и приложениях на основе базы данных известных уязвимостей.
-   Поддерживает аутентифицированное сканирование, что позволяет проводить более глубокий анализ системы, включая проверку внутренних сервисов и приложений, которые доступны только после авторизации.
-   Может интегрироваться с другими системами безопасности, например, с SIEM-системами (Security Information and Event Management).

 [timeweb.cloud](https://timeweb.cloud/tutorials/servers/nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-22-04)[help.sweb.ru](https://help.sweb.ru/kak-ispol6zovat6-nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-2204_1399.html)

![Vulnerability Scanning with Nessus in Kali Linux Beginner’s Guide to Nessus Cyber Security Tools - YouTube](https://avatars.mds.yandex.net/i?id=95230b6f5ac05fabe99656442a6bb6f0_l-5869427-images-thumbs&n=13&n=13&w=345&h=230)

## Инструкция по использованию

**Чтобы запустить Nessus в контейнере на Docker Hub, нужно**: [hamradio.my](https://hamradio.my/2025/07/deploying-tenable-nessus-in-docker-fast-portable-vulnerability-scanning/)

1.  **Установить Docker**. Если Docker не установлен, его можно установить через менеджер пакетов ОС или с официального сайта Docker.
2.  **Загрузить образ Nessus** из Docker Hub. Например, официальный образ —
    
    ```
    docker pull tenable/nessus:latest-ubuntu
    ```
    
    . Другие доступные теги:
    
    ```
    latest-oracle
    ```
    
    , конкретные версии (например, 10.6.1-ubuntu или 10.6.1-oracle).
3.  **Запустить контейнер**. **Типичная команда** для запуска Nessus:
    
    ```
    docker run -d --name nessus -p 8834:8834 -e USERNAME=admin -e PASSWORD=SuperSecurePassword -e ACTIVATION_CODE=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX tenable/nessus:latest-ubuntu
    ```
    
    .
4.  **Получить доступ к веб-интерфейсу**. Для локальных машин —
    
    ```
    https://localhost:8834
    ```
    
    , для удалённого доступа —
    
    ```
    https://&lt;host-ip&gt;:8834
    ```
    
    .

 [hamradio.my](https://hamradio.my/2025/07/deploying-tenable-nessus-in-docker-fast-portable-vulnerability-scanning/)[anto.online](https://anto.online/guide-to-setting-up-and-running-tenable-nessus-essentials-in-docker/)

**Важно**: Nessus не поддерживает постоянное хранилище в Docker, поэтому конфигурация теряется, если контейнер удалён. Также не рекомендуется делиться одним NIC с другими контейнерами для безопасности и изоляции. [hamradio.my](https://hamradio.my/2025/07/deploying-tenable-nessus-in-docker-fast-portable-vulnerability-scanning/)

## Требования

-   **Разрешение на выполнение сетевых сканов** в целевой сети.
-   **Код активации** — его можно получить на сайте Tenable.

 [anto.online](https://anto.online/guide-to-setting-up-and-running-tenable-nessus-essentials-in-docker/)

**Совет**: всегда запускать Nessus в безопасной и надёжной сетевой среде. [hamradio.my](https://hamradio.my/2025/07/deploying-tenable-nessus-in-docker-fast-portable-vulnerability-scanning/)

## Отзывы

**Некоторые положительные стороны, отмеченные пользователями**:

-   большая база уязвимостей;
-   удобный интерфейс, отчёты;
-   автоматизация через API (можно запускать сканы, выгружать отчёты и интегрировать с CI/CD пайплайнами).

 [arenda-server.cloud](https://arenda-server.cloud/blog/kak-ispolzovat-nessus-dlja-skanirovanija-ujazvimostej-na-ubuntu-24-04/)

**Некоторые недостатки, упомянутые пользователями**:

-   сканер может ругаться на неиспользуемые сервисы или старые библиотеки — в этом случае нужно проверить вручную, настроить исключения в Nessus, обновить плагины. [](https://arenda-server.cloud/blog/kak-ispolzovat-nessus-dlja-skanirovanija-ujazvimostej-na-ubuntu-24-04/)

**В Docker Hub доступны образы сканера уязвимостей Nessus для архитектуры arm64**. Некоторые из них: [hub.docker.com](https://hub.docker.com/search?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=nessus&starCount=0&architecture=arm64)

-   **tenable/nessus** — официальный образ Nessus;
-   **isaudits/nessus** — Docker-имплементация сканера Nessus с наложением s6 (AMD64 + ARM64);
-   **mcnamee/nessus** — образы Nessus для AMD64 и arm64.

 [hub.docker.com](https://hub.docker.com/search?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=nessus&starCount=0&architecture=arm64)[github.com](https://github.com/mcnamee/nessus)

Также на GitHub есть репозиторий **j-schmied/nessus-arm**, который предлагает Docker-контейнер для запуска Nessus на устройствах на базе arm (например, Apple Silicon). [github.com](https://github.com/j-schmied/nessus-arm)

**Ссылка на Docker Hub**: [hub.docker.com](https://hub.docker.com/search?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=nessus&starCount=0&architecture=arm64). [hub.docker.com](https://hub.docker.com/search?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=nessus&starCount=0&architecture=arm64)

## Инструкция по установке

**Чтобы установить Nessus через Docker, нужно**: [help.sweb.ru](https://help.sweb.ru/kak-ispol6zovat6-nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-2204_1399.html)

1.  **Загрузить образ** из Docker Hub с помощью команды, например:
    
    ```
    docker pull tenable/nessus:latest-ubuntu
    ```
    
    .
2.  **Создать и запустить контейнер** с помощью команды:
    
    ```
    docker run --name "newnessus" -d -p 8834:8834 tenable/nessus:latest-ubuntu
    ```
    
    .

 [help.sweb.ru](https://help.sweb.ru/kak-ispol6zovat6-nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-2204_1399.html)[timeweb.cloud](https://timeweb.cloud/tutorials/servers/nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-22-04)

**Объяснение команд**:

-   ```
    --name "newnessus"
    ```
    
    — задаёт имя контейнера.
-   ```
    -d
    ```
    
    — указывает Docker запускать контейнер в фоновом режиме.
-   ```
    -p 8834:8834
    ```
    
    — перенаправляет порт 8834 контейнера на порт 8834 хоста, делая веб-интерфейс Nessus доступным по адресу
    
    ```
    http://localhost:8834
    ```
    
    .

 [help.sweb.ru](https://help.sweb.ru/kak-ispol6zovat6-nessus-dlya-skanirovaniya-uyazvimostej-v-ubuntu-2204_1399.html)

**Важно**: Tenable не рекомендует размещать Nessus в контейнере Docker, который разделяет контроллер сетевого интерфейса (NIC) с другим контейнером. [docs.tenable.com](https://docs.tenable.com/nessus/Content/DeployNessusDocker.htm)

## Настройка

**Nessus умеет сканировать не только хост, но и контейнеры**, если дать ему доступ к сокету Docker. Также можно настроить расписание сканов (например, каждую ночь). [arenda-server.cloud](https://arenda-server.cloud/blog/kak-ispolzovat-nessus-dlja-skanirovanija-ujazvimostej-na-ubuntu-24-04/)

**Официальная документация Nessus**: [docs.tenable.com](https://docs.tenable.com/nessus/). [arenda-server.cloud](https://arenda-server.cloud/blog/kak-ispolzovat-nessus-dlja-skanirovanija-ujazvimostej-na-ubuntu-24-04/)

**Важно**: использование Nessus может быть связано с рисками, и перед применением инструмента рекомендуется проконсультироваться со специалистом по безопасности.

# Run Scaner

docker run -dt -p 8834:8834 --name nessus_scanner mcnamee/nessus 
