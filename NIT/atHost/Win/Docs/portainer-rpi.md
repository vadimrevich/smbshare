**Portainer** — лёгкий веб-интерфейс для управления контейнерами Docker, который упрощает развёртывание, настройку и мониторинг контейнеров. Его можно установить на Raspberry Pi, используя Docker. [38-3d.co.uk](https://38-3d.co.uk/blogs/blog/installing-portainer-on-the-raspberry-pi)[sunfounder.com](https://www.sunfounder.com/blogs/news/raspberry-pi-portainer-complete-setup-and-management-guide)[fleetstack.io](https://fleetstack.io/blog/install-portainer-raspberry-pi)

## Требования

Для установки Portainer на Raspberry Pi необходимо: [38-3d.co.uk](https://38-3d.co.uk/blogs/blog/installing-portainer-on-the-raspberry-pi)

-   **Raspberry Pi** (любая модель с поддержкой Docker, например, Pi 3, Pi 4). Старые версии Raspberry Pi могут работать с Docker и Portainer, но ограниченная мощность обработки и ОЗУ может вызывать задержки, особенно при управлении несколькими контейнерами. [38-3d.co.uk](https://38-3d.co.uk/blogs/blog/installing-portainer-on-the-raspberry-pi)[raspi.dev](https://raspi.dev/posts/setup-portainer)
-   **Операционная система** — Raspberry Pi OS или другой совместимый дистрибутив Linux. [raspi.dev](https://raspi.dev/posts/setup-portainer)[fleetstack.io](https://fleetstack.io/blog/install-portainer-raspberry-pi)
-   **Установлен Docker** — Portainer требует, чтобы Docker работал. Если Docker не установлен, его нужно установить. [38-3d.co.uk](https://38-3d.co.uk/blogs/blog/installing-portainer-on-the-raspberry-pi)
-   **Есть интернет-соединение** для загрузки Portainer. [raspi.dev](https://raspi.dev/posts/setup-portainer)[fleetstack.io](https://fleetstack.io/blog/install-portainer-raspberry-pi)

## Пошаговая инструкция

Установка Portainer на Raspberry Pi включает несколько шагов: [38-3d.co.uk](https://38-3d.co.uk/blogs/blog/installing-portainer-on-the-raspberry-pi)

1.  **Установить Docker**. Если Docker не установлен, нужно:
    -   Обновить список пакетов:
        
        ```
        sudo apt update
        ```
        
        ,
        
        ```
        sudo apt upgrade -y
        ```
        
        .
    -   Установить Docker с помощью официального скрипта:
        
        ```
        curl -sSL https://get.docker.com | sh
        ```
        
        .
    -   После установки добавить текущего пользователя в группу Docker, чтобы запускать команды Docker без sudo:
        
        ```
        sudo usermod -aG docker ${USER}
        ```
        
        .
    -   Перезагрузить Raspberry Pi, чтобы применить изменения:
        
        ```
        sudo reboot
        ```
        
        .
2.  **Установить Portainer как контейнер Docker**:
    -   Скачать образ Portainer из Docker Hub:
        
        ```
        docker pull portainer/portainer-ce:latest
        ```
        
        .
    -   Создать и запустить контейнер Portainer:
        
        ```
        docker volume create portainer_data
        ```
        
        ,
        
        ```
        docker run -d -p 8000:8000 -p 9000:9000 -p 9443:9443 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
        ```
        
        .
3.  **Получить доступ к веб-интерфейсу Portainer**:
    -   Открыть веб-браузер и перейти по адресу:
        
        ```
        http://&lt;raspberry_pi_ip&gt;:9000
        ```
        
        (заменить <raspberry\_pi\_ip> на IP-адрес Raspberry Pi).
    -   При первом доступе к веб-интерфейсу Portainer нужно создать учётную запись администратора: установить имя и пароль, нажать «Создать пользователя».
    -   Выбрать «Локальный» для управления локальной средой Docker на Raspberry Pi, нажать «Подключить».
4.  **Использовать Portainer**:
    -   **Посмотреть запущенные контейнеры** — контролировать статус всех активных контейнеров.
    -   **Развёртывать новые контейнеры** — создавать новые контейнеры Docker из интерфейса Portainer.
    -   **Управлять объёмами и сетями** — просматривать и настраивать объёмы и сети Docker.
    -   **Посмотреть логи и статистику** — контролировать логи и статистику запущенных контейнеров.

 [38-3d.co.uk](https://38-3d.co.uk/blogs/blog/installing-portainer-on-the-raspberry-pi)

## Возможные ошибки

Некоторые ошибки при установке Portainer на Raspberry Pi и их решение:

-   **Portainer не доступен** — убедиться, что брандмауэр Raspberry Pi позволяет доступ к портам 9000 и 9443. Если используется HTTPS, проверить, правильно ли настроены сертификаты SSL.
-   **Контейнер Docker падает** — проверить логи контейнера на ошибки:
    
    ```
    docker logs portainer
    ```
    
    .
-   **Нет доступа к Docker** — убедиться, что пользователь входит в группу Docker:
    
    ```
    sudo usermod -aG docker ${USER}
    ```
    
    [Skip to content](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#main)

[![WunderTech](https://www.wundertech.net/wp-content/uploads/2025/05/cropped-WunderTechTutorials-Logo.png)](https://www.wundertech.net/)

-   [Home](https://www.wundertech.net)
-   [Synology](https://www.wundertech.net/synology-nas-guides/)
    -   [Best Synology NAS Devices](https://www.wundertech.net/which-synology-nas-should-i-buy/)
    -   [Synology NAS Setup Guide](https://www.wundertech.net/synology-nas-initial-setup-ultimate-guide/)
-   [Proxmox](https://www.wundertech.net/proxmox-ve/)
-   [UniFi](https://www.wundertech.net/unifi-guides/)
    -   [Best UniFi Router & Firewall](https://www.wundertech.net/best-unifi-router-firewall/)
-   [Home Lab](https://www.wundertech.net/my-complete-home-lab/)
    -   [Docker Guides](https://www.wundertech.net/docker-guides/)
    -   [Firewall Guides](https://www.wundertech.net/firewall-guides/)
-   [Contact Us](https://www.wundertech.net/contact-us/)
-   [About Us](https://www.wundertech.net/about-us/)
-   [Hire Me](https://www.wundertech.net/wundertech-consulting/)
-   [Toggle website search](https://www.wundertech.net/#)

Search this website 

[Menu Close](https://www.wundertech.net/#mobile-menu-toggle)

How to Setup Apache Guacamole on a Raspberry Pi!

3.  [Home](https://www.wundertech.net)\>
4.  [Raspberry Pi](https://www.wundertech.net/category/raspberry-pi/)\>
5.  [How to Setup Apache Guacamole on a Raspberry Pi!](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi/)

# How to Setup Apache Guacamole on a Raspberry Pi!

-   Post author:[Frank Joseph](https://www.wundertech.net/author/wundertechtutorials/ "Posts by Frank Joseph")
-   Post last modified:May 5, 2025
-   Post category:[Raspberry Pi](https://www.wundertech.net/category/raspberry-pi/)
-   Reading time:5 mins read

Today we are going to look at how to install [Apache Guacamole](https://guacamole.apache.org/) on a Raspberry Pi.

<iframe loading="lazy" title="How to Setup Apache Guacamole on a Raspberry Pi!" width="1200" height="675" src="https://www.youtube.com/embed/dmLS5YiPecU?feature=oembed" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" data-rocket-lazyload="fitvidscompatible" data-lazy-src="https://www.youtube.com/embed/dmLS5YiPecU?feature=oembed" data-ll-status="loaded" class="entered lazyloaded"></iframe>

<iframe title="How to Setup Apache Guacamole on a Raspberry Pi!" width="1200" height="675" src="https://www.youtube.com/embed/dmLS5YiPecU?feature=oembed" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe>

Apache Guacamole is a clientless remote desktop gateway that runs in your browser. In summary, you’re able to RDP, VNC, or SSH into devices on your network through a web browser. You can also setup Telnet and Kubernetes, but we won’t be going over that in this tutorial. The tool works very well and allows you to manage all your connections in a centralized location accessible by a web browser.

**It is my recommendation that you use** a Raspberry Pi 4 when using Guacamole since it supports gigabit ethernet. This will work on all Raspberry Pi devices, but the network bandwidth is what will ultimately limit you when using older devices.

We will set this up by using Docker and Portainer, so if you haven’t set that up yet, [please check out my tutorial here](https://www.wundertech.net/portainer-raspberry-pi-install-how-to-install-docker-and-portainer/).

If you’d like to learn about the Apache Guacamole Docker container or install it without using Portainer, [you can find the github page here](https://github.com/oznu/docker-guacamole).

**Table of Contents** [show](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#)

-   [1\. Instructions – Raspberry Pi Apache Guacamole](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#1_Instructions_-_Raspberry_Pi_Apache_Guacamole)
-   [2\. Remote Connection Setup](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#2_Remote_Connection_Setup)
    -   [2.1 How to Create a Connection Group](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#21_How_to_Create_a_Connection_Group)
    -   [2.2 How to Create a New Connection](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#22_How_to_Create_a_New_Connection)
    -   [2.3 Multi-Factor Authentication](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#23_Multi-Factor_Authentication)
-   [3\. Conclusion – Raspberry Pi Apache Guacamole](https://www.wundertech.net/how-to-setup-apache-guacamole-on-a-raspberry-pi//#3_Conclusion_-_Raspberry_Pi_Apache_Guacamole)

## 1\. Instructions – Raspberry Pi Apache Guacamole

1\. First, we are going to create a volume in Portainer. Open Portainer and select Volumes. Then, select **Add Volume**.

![portainer volumes section](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi1.jpg)

2\. Enter the name as **Guacamole** and then **create the volume**.

![raspberry pi apache guacamole container setup](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi2.jpg)

![raspberry pi apache guacamole container setup](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi2.jpg)

3\. Go to **Containers** and **Add** **Container**.

![raspberry pi apache guacamole - selecting containers to add a new one](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi3.jpg)

![raspberry pi apache guacamole - selecting containers to add a new one](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi3.jpg)

<iframe frameborder="0" src="https://d9911fa10af87cf1867ba039232d0665.safeframe.googlesyndication.com/safeframe/1-0-45/html/container.html" id="google_ads_iframe_/1030006,22526537531/wundertech/content_4" title="3rd party ad content" name="" scrolling="no" marginwidth="0" marginheight="0" width="1" height="1" data-is-safeframe="true" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" allow="private-state-token-redemption;attribution-reporting" aria-label="Advertisement" tabindex="0" data-google-container-id="8" style="border: 0px; vertical-align: bottom; height: 90px; width: 728px;" data-load-complete="true" data-hooks="true"></iframe>

4\. Enter the name as **Guacamole** and under image, enter **oznu/guacamole:armhf**. Select **Publish a new network port** and enter **8080** for both the host and container. **NOTE**: If you are using port 8080 for anything else, you can use a different port.

![raspberry pi apache guacamole creation process with name, container, and port](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi4.jpg)

![raspberry pi apache guacamole creation process with name, container, and port](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi4.jpg)

5\. At the bottom, select **Volumes** and then **map additional volume** with the path as **/config** and the volume that we created earlier. Select **Restart Policy** and change the restart policy to **Always.** You can then **deploy the container**!

<iframe frameborder="0" src="https://d9911fa10af87cf1867ba039232d0665.safeframe.googlesyndication.com/safeframe/1-0-45/html/container.html" id="google_ads_iframe_/1030006,22526537531/wundertech/content_5" title="3rd party ad content" name="" scrolling="no" marginwidth="0" marginheight="0" width="1" height="1" data-is-safeframe="true" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" allow="private-state-token-redemption;attribution-reporting" aria-label="Advertisement" tabindex="0" data-google-container-id="9" style="border: 0px; vertical-align: bottom; height: 90px; width: 728px;" data-load-complete="true" data-hooks="true"></iframe>

![raspberry pi apache guacamole - volume creation](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi4.5.jpg)

![raspberry pi apache guacamole - volume creation](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi4.5.jpg)

![container restart always policy](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi16.jpg)

![container restart always policy](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi16.jpg)

6\. The image will now download and then install. **You will need to give this upwards of 5-10 minutes for the entire process to finish**. When it does, you can navigate to Apache Guacamole by your Raspberry Pi’s IP address and port 8080.

```
http://[RASPBERRY_PI_IP]:[PORT]
```

7\. When you access the landing page, log in with the username **guacadmin** and password **guacadmin**.

![raspberry pi apache guacamole login page](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi5.jpg)

![raspberry pi apache guacamole login page](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi5.jpg)

8\. The first thing we will do is create a new username and delete **guacadmin**. In the top right, select **guacadmin** and then **settings**. Select **Users** and then **New User**.

![raspberry pi apache guacamole setting section to add a new user](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi6.jpg)

![raspberry pi apache guacamole setting section to add a new user](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi6.jpg)

9\. Create a new user and save. **NOTE**: There are a bunch of different options here that you can tinker with if you’d like.

<iframe frameborder="0" src="https://d9911fa10af87cf1867ba039232d0665.safeframe.googlesyndication.com/safeframe/1-0-45/html/container.html" id="google_ads_iframe_/1030006,22526537531/wundertech/content_8" title="3rd party ad content" name="" scrolling="no" marginwidth="0" marginheight="0" width="1" height="1" data-is-safeframe="true" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" allow="private-state-token-redemption;attribution-reporting" aria-label="Advertisement" tabindex="0" data-google-container-id="c" style="border: 0px; vertical-align: bottom; height: 250px; width: 300px;" data-load-complete="true" data-hooks="true"></iframe>

![raspberry pi apache guacamole - user profile](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi7.jpg)

![raspberry pi apache guacamole - user profile](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi7.jpg)

10\. **Logout** and then **log** **in** with your newly created user. Navigate to the settings and then delete the **guacadmin** user.

<iframe frameborder="0" src="https://d9911fa10af87cf1867ba039232d0665.safeframe.googlesyndication.com/safeframe/1-0-45/html/container.html" id="google_ads_iframe_/1030006,22526537531/wundertech/content_9" title="3rd party ad content" name="" scrolling="no" marginwidth="0" marginheight="0" width="1" height="1" data-is-safeframe="true" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" allow="private-state-token-redemption;attribution-reporting" aria-label="Advertisement" tabindex="0" data-google-container-id="d" style="border: 0px; vertical-align: bottom; height: 90px; width: 728px;" data-load-complete="true" data-hooks="true"></iframe>

11\. The setup process is now complete!

## 2\. Remote Connection Setup

Setting up a remote connection is super simple. The key is to ensure that the destination device (Windows, Mac, Linux PC) is configured properly. Generally, you will be using RDP or VNC sessions if you’d like to view the desktop of a destination PC and SSH if you’d like to connect to the terminal. I’m not going to go over each example, but I will go over the general way of adding a new group and connection.

### 2.1 How to Create a Connection Group

Groups give you an easy way of structuring your machines. This will need to be created based on your requirements, but I generally split my machines up by category (Windows, Linux).

1\. Navigate to the settings and select **Connections**, then **New** **Group**.

![creating groups in apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi9.jpg)

![creating groups in apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi9.jpg)

<iframe frameborder="0" src="https://d9911fa10af87cf1867ba039232d0665.safeframe.googlesyndication.com/safeframe/1-0-45/html/container.html" id="google_ads_iframe_/1030006,22526537531/wundertech/content_11" title="3rd party ad content" name="" scrolling="no" marginwidth="0" marginheight="0" width="1" height="1" data-is-safeframe="true" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" allow="private-state-token-redemption;attribution-reporting" aria-label="Advertisement" tabindex="0" data-google-container-id="f" style="border: 0px; vertical-align: bottom; height: 250px; width: 300px;" data-load-complete="true" data-hooks="true"></iframe>

2\. Give your group a name, modify any settings you’d like, and select **Save**.

![connection group settings](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi10.jpg)

![connection group settings](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi10.jpg)

### 2.2 How to Create a New Connection

Connections are what you’ll use to connect to your machines. I am not going to give specific examples but will show you how you can create RDP, VNC, or SSH connections.

1\. Navigate to the **settings** and select **Connections**, then **New Connection**.

![creating a new connection in apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi9.jpg)

![creating a new connection in apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi9.jpg)

2\. Enter a **Name** and then select Location to pick a group. Under **Protocol**, select RDP, VNC, or SSH.

3\. There are a **ton of settings** here, but simply entering the information in the **Parameters** section will allow you to connect. Add your **Hostname** and port (3389 for RDP, 5900 for VNC, 22 for SSH). Then add your **Username** and **Password** to the destination device and **save** the connection. There are a ton of other options that can be changed, but in general, these are the most important.

<iframe id="google_ads_iframe_/1030006,22526537531/wundertech/content_13" name="google_ads_iframe_/1030006,22526537531/wundertech/content_13" title="3rd party ad content" width="300" height="250" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" aria-label="Advertisement" tabindex="0" allow="private-state-token-redemption;attribution-reporting" data-load-complete="true" data-google-container-id="h" data-hooks="true" style="border: 0px; vertical-align: bottom;"></iframe>

![adding a new device to apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi11.jpg)

![adding a new device to apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi11.jpg)

### 2.3 Multi-Factor Authentication

There are many reasons why someone would want to expose Apache Guacamole to the outside internet. Generally, it’s suggested that rather than exposing the service, you use a VPN to tunnel back to your home network. However, if you want to expose this to the internet, you can use [Nginx Proxy Manager](https://www.wundertech.net/nginx-proxy-manager-raspberry-pi-install-instructions/), set up an SSL certificate, and enable two-factor authentication on Guacamole. To enable two-factor authentication, follow these steps.

<iframe id="google_ads_iframe_/1030006,22526537531/wundertech/content_14" name="google_ads_iframe_/1030006,22526537531/wundertech/content_14" title="3rd party ad content" width="300" height="250" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" aria-label="Advertisement" tabindex="0" allow="private-state-token-redemption;attribution-reporting" data-load-complete="true" data-google-container-id="i" data-hooks="true" style="border: 0px; vertical-align: bottom;"></iframe>

1\. Open Portainer, navigate to the container, and select **Duplicate/Edit.**  
![how to stop apache guacamole container](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi13.jpg)

![how to stop apache guacamole container](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi13.jpg)

  
2\. At the bottom, select **Env** and **add an environment variable.**

![portainer environment variables](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi14.jpg)

![portainer environment variables](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi14.jpg)

3\. Enter **EXTENSIONS** in the name and **auth-totp** in the value.

![adding the extensions environment variable](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi15.jpg)

![adding the extensions environment variable](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi15.jpg)

4\. Select **Deploy the container.** The container will now redeploy and when you login, you will be asked to set up two-factor authentication!

![editing multi-factor authentication in apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi12.jpg)

![editing multi-factor authentication in apache guacamole](https://www.wundertech.net/wp-content/uploads/2020/10/G_Pi12.jpg)

## 3\. Conclusion – Raspberry Pi Apache Guacamole

Apache Guacamole is an awesome little tool and it’s super easy to setup on a Raspberry Pi. It’s very nice to be able to manage remote connections in a central location and it’s great that it works on all devices with a web browser! I’ve always used remote desktop connection tools but it was an entire setup every time I’d like to implement it on a new device. This is an easy way to hit all of your devices at the same time!

If you have any questions, please leave them in the comments. Thanks for reading!

![Post author avatar](data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20100%20100'%3E%3C/svg%3E)

![Post author avatar](https://secure.gravatar.com/avatar/b520f1b124552d5ff1297a33cf63a1961fda8bea2bb998893bd1f5430cb4100c?s=100&r=g)

["Visit author page"](https://www.wundertech.net/author/wundertechtutorials/)

### [Frank Joseph](https://www.wundertech.net/author/wundertechtutorials/ "Visit author page")

Frank Joseph is the founder of WunderTech, where he shares tutorials on NAS, servers, virtualization, and home lab setups. Frank has over 15 years of experience in corporate IT and application management. Frank holds a Bachelor of Science in Computer Information Systems and an MBA. He publishes content on his [**website**](https://www.wundertech.net/) and [**YouTube channel**](https://www.youtube.com/@WunderTechTutorials) to help users build and manage their home lab solutions.

### You Might Also Like

![Read more about the article How to Set Up a Raspberry Pi Headless](data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20300%20169'%3E%3C/svg%3E)

![Read more about the article How to Set Up a Raspberry Pi Headless](https://www.wundertech.net/wp-content/uploads/2020/05/RPiZero-300x169.jpg)

[how-to-setup-a-raspberry-pi-zero-without-a-monitor-keyboard-or-mouse](https://www.wundertech.net/how-to-setup-a-raspberry-pi-zero-without-a-monitor-keyboard-or-mouse/)

### [How to Set Up a Raspberry Pi Headless](https://www.wundertech.net/how-to-setup-a-raspberry-pi-zero-without-a-monitor-keyboard-or-mouse/)

May 30, 2020

![Read more about the article How to Set Up WireGuard on a Raspberry Pi](data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%201280%20720'%3E%3C/svg%3E)

![Read more about the article How to Set Up WireGuard on a Raspberry Pi](https://www.wundertech.net/wp-content/uploads/2024/04/How-to-Set-Up-WireGuard-on-a-Raspberry-Pi.jpg)

[setup-wireguard-on-a-raspberry-pi-vpn-setup-tutorial](https://www.wundertech.net/setup-wireguard-on-a-raspberry-pi-vpn-setup-tutorial/)

### [How to Set Up WireGuard on a Raspberry Pi](https://www.wundertech.net/setup-wireguard-on-a-raspberry-pi-vpn-setup-tutorial/)

April 17, 2025

![Read more about the article How to Install Pi-hole on a Raspberry Pi](data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20300%20169'%3E%3C/svg%3E)

![Read more about the article How to Install Pi-hole on a Raspberry Pi](https://www.wundertech.net/wp-content/uploads/2020/06/PiHole5-300x169.jpg)

[how-to-setup-pi-hole-on-a-raspberry-pi](https://www.wundertech.net/how-to-setup-pi-hole-on-a-raspberry-pi/)

### [How to Install Pi-hole on a Raspberry Pi](https://www.wundertech.net/how-to-setup-pi-hole-on-a-raspberry-pi/)

June 6, 2020

![Read more about the article How to Configure the Raspberry Pi Firewall with UFW](data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20300%20169'%3E%3C/svg%3E)

![Read more about the article How to Configure the Raspberry Pi Firewall with UFW](https://www.wundertech.net/wp-content/uploads/2023/01/thumb-1-300x169.jpg)

[raspberry-pi-firewall-configuration-with-ufw](https://www.wundertech.net/raspberry-pi-firewall-configuration-with-ufw/)

### [How to Configure the Raspberry Pi Firewall with UFW](https://www.wundertech.net/raspberry-pi-firewall-configuration-with-ufw/)

January 26, 2023

Search

Search


**Check out all of our social channels below, and make sure you subscribe to our [YouTube channel](https://www.youtube.com/@WunderTechTutorials?sub_confirmation=1)!**

-   [YouTube](https://www.youtube.com/@WunderTechTutorials)
-   [Reddit](https://www.reddit.com/user/WunderTechTutorials)
-   [Twitter](https://twitter.com/_wundertech)
-   [Facebook](https://www.facebook.com/WunderTechTutorials)
-   [Instagram](https://www.instagram.com/wundertechtutorials/)

**WHO WE ARE & AFFILIATE DISCLOSURE**

WunderTech provides tutorials and guides on Synology, UniFi, Proxmox, TrueNAS, Docker, and more. WunderTech is maintained by [**Frank Joseph**](https://www.wundertech.net/author/wundertechtutorials/), an IT professional with 15+ years of experience in corporate IT and application management. He holds a Bachelor of Science degree in Computer Information Systems and a Master of Business Administration (MBA). He focuses on sharing his experience with others on his website and [**YouTube channel**](https://www.youtube.com/@WunderTechTutorials).  
  
Certain offers on this page may promote our affiliates, which means we earn an affiliate commission if you purchase products or services through some of our links provided. Please view our complete [**disclaimer**](https://www.wundertech.net/disclaimer/) for more information. WunderTech is a trade name of WunderTech, LLC.

© 2025 WunderTech, All Rights Reserved