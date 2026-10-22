**Перенос файлов внутрь контейнера Docker** может осуществляться с помощью команды

```
docker cp
```

или инструкции

```
COPY
```

в Dockerfile. [labex.io](https://labex.io/ru/tutorials/docker-how-to-copy-a-file-into-a-docker-container-411522)[purpleschool.ru](https://purpleschool.ru/knowledge-base/article/copy-1)[labex.io](https://labex.io/ru/tutorials/docker-how-to-copy-files-to-docker-container-paths-418107)

## Команда docker cp

**Позволяет копировать файлы или каталоги** между локальной файловой системой и работающим контейнером Docker. [labex.io](https://labex.io/ru/tutorials/docker-how-to-copy-a-file-into-a-docker-container-411522)

**Синтаксис**:

```
docker cp &lt;src&gt; &lt;dest&gt;
```

. [dev.to](https://dev.to/spacelift/using-docker-cp-command-to-copy-files-in-containers-331o)

**Параметры**:

-   ```
    &lt;src&gt;
    ```
    
    — путь к файлу или папке на хосте.
-   ```
    &lt;dest&gt;
    ```
    
    — путь внутри контейнера к файлу или папке, в которую требуется скопировать.

 [dev-notes.ru](https://www.dev-notes.ru/articles/devops/docker-container-copy-files/)[dev.to](https://dev.to/spacelift/using-docker-cp-command-to-copy-files-in-containers-331o)

**Примеры использования**:

-   Копирование файла из локальной файловой системы в работающий контейнер:
    
    ```
    docker cp local_file.txt container_name:/path/in/container
    ```
    
    .
-   Копирование файла из работающего контейнера в локальную файловую систему:
    
    ```
    docker cp container_name:/path/in/container local_file.txt
    ```
    
    .

 [labex.io](https://labex.io/ru/tutorials/docker-how-to-copy-a-file-into-a-docker-container-411522)

**Особенности**:

-   Если копируется каталог, всё содержимое каталога будет скопировано рекурсивно.
-   Опция
    
    ```
    -L, --follow-link
    ```
    
    позволяет следовать символическим ссылкам во время процесса копирования.
-   Опция
    
    ```
    -q, --quiet
    ```
    
    автоматически подавляет вывод прогресса при копировании с подключением терминала.

 [dev-notes.ru](https://www.dev-notes.ru/articles/devops/docker-container-copy-files/)

**Важно**: напрямую копировать файлы между контейнерами с помощью команды

```
docker cp
```

нельзя — нужно сначала скопировать файл на хост, а затем использовать другую команду

```
docker cp
```

для копирования во второй контейнер. [dev.to](https://dev.to/spacelift/using-docker-cp-command-to-copy-files-in-containers-331o)

## Dockerfile

**Инструкция

```
COPY
```

в Dockerfile** позволяет переносить файлы и папки из локальной файловой системы в контейнер во время сборки образа. [purpleschool.ru](https://purpleschool.ru/knowledge-base/article/copy-1)[labex.io](https://labex.io/ru/tutorials/docker-how-to-copy-files-to-docker-container-paths-418107)

**Синтаксис**:

```
COPY &lt;SOURCE&gt; &lt;DESTINATION&gt;
```

. [purpleschool.ru](https://purpleschool.ru/knowledge-base/article/copy-1)

**Параметры**:

-   ```
    &lt;SOURCE&gt;
    ```
    
    — источник, указывающий на файл или папку в локальной файловой системе, которую нужно скопировать.
-   ```
    &lt;DESTINATION&gt;
    ```
    
    — путь в контейнере, куда нужно поместить эти данные.

 [purpleschool.ru](https://purpleschool.ru/knowledge-base/article/copy-1)

**Пример**:

```
COPY index.html /usr/share/nginx/html/
```

— локальный файл index.html копируется в директорию /usr/share/nginx/html/ внутри контейнера. [purpleschool.ru](https://purpleschool.ru/knowledge-base/article/copy-1)

**Особенности**:

-   COPY работает в контексте сборки образа — можно скопировать только те файлы, которые доступны в текущем контексте.
-   Каждый раз, когда используется команда COPY, создаётся новый слой образа, поэтому для оптимизации пространства рекомендуется минимизировать количество команд COPY в Dockerfile.
-   COPY поддерживает дополнительную функциональность, например, использование
    
    ```
    --chown
    ```
    
    , чтобы изменить владельца файлов при их копировании.
