**Команда

```
docker container commit
```

в Docker позволяет создать новый образ (image) на основе изменений, внесённых в контейнер**. Это полезно, если внутри контейнера вносили изменения, например, устанавливали пакеты или изменяли конфигурации. [labex.io](https://labex.io/ru/tutorials/docker-how-to-use-docker-container-commit-command-to-create-new-images-555104)[docs.docker.com](https://docs.docker.com/reference/cli/docker/container/commit/)[baeldung.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fwww.baeldung.com%2Fops%2Fdocker-save-container-state)

**Особенности**:

-   Сгенерированное изображение — базовое изображение с дополнительным слоем, который содержит текущее состояние контейнера.
-   По умолчанию контейнер и его процессы останавливаются во время коммита, чтобы снизить вероятность повреждения данных. Если это поведение нежелательно, можно установить опцию
    
    ```
    --pause
    ```
    
    на false.
-   Команда не фиксирует всё: например, образ не содержит подключённых томов, настроенных с помощью опций
    
    ```
    -v
    ```
    
    или
    
    ```
    --mount
    ```
    
    .

 [baeldung.com](https://tr-page.yandex.ru/translate?lang=en-ru&url=https%3A%2F%2Fwww.baeldung.com%2Fops%2Fdocker-save-container-state)[docs.docker.com](https://docs.docker.com/reference/cli/docker/container/commit/)

## Синтаксис

**Базовый синтаксис**:

```
docker commit [имя_контейнера] [имя_нового_образа]
```

. [labex.io](https://labex.io/ru/tutorials/docker-how-to-use-docker-container-commit-command-to-create-new-images-555104)

**Некоторые опции**:

-   ```
    -a, --author
    ```
    
    — указать имя автора образа.
-   ```
    -c, --change
    ```
    
    — применить инструкцию Dockerfile к новому образу. Поддерживаются инструкции CMD, ENTRYPOINT, ENV, EXPOSE, LABEL, ONBUILD, USER, VOLUME и WORKDIR.
-   ```
    -m, --message
    ```
    
    — включить пользовательское сообщение с образом.
-   ```
    -p, --pause
    ```
    
    — остановить контейнер во время операции коммита. Если опция не указана, команда предполагает, что значение — true.

 [phoenixnap.com](https://phoenixnap.com/kb/how-to-commit-changes-to-docker-image)[docs.docker.com](https://docs.docker.com/reference/cli/docker/container/commit/)

## Пример

**Пример создания нового образа из контейнера my-ubuntu**:  

```
docker commit my-ubuntu my-ubuntu-modified
```

. [labex.io](https://labex.io/ru/tutorials/docker-how-to-use-docker-container-commit-command-to-create-new-images-555104)

**Важно**: в результате команды выводится длинная строка символов — это ID вновь созданного образа. [labex.io](https://labex.io/ru/tutorials/docker-how-to-use-docker-container-commit-command-to-create-new-images-555104)

## Ошибки

**Некоторые ошибки, которые могут возникнуть при использовании команды docker container commit**:

-   **Образ не содержит подключённых томов** — файлы, хранящиеся на этих томах, не являются частью нового образа.
-   **В образе не сохраняются параметры, относящиеся к конкретному контейнеру**, такие как сетевые конфигурации, IP-адреса, ограничения процессора и памяти, политики перезапуска или рабочий каталог.
