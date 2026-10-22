# Установить правильное переключение клавиатуры в Windpws Sever Core

Иногда при установке операционной системы Windows Server Core Russian неправильно устанавливается локаль клавиатуры, в результате чего клавиатура не переключается должным образом. Особенно это неудобно при переключении клавиатуры на удалённой консоли или виртуальной машины. Найден способ решшить эту прблему, при помощи стандартных командлетов Powershell, доступных в Microsoft Windows Server Core.

Для реализации указанных действий перейдите в консоль Powershell.

## Вводные действия.

Инструкция применима для русской версии Microsoft Windows Server 2025 Core. Для остальных версий, возможно, будет аналогично.

Вначале проверьте порядок языков порядок языков (первый = 0, второй = 1 и т.д.). Обычно после установки первым языком будет русский, вторым — американский английский.

## Алгоритм действий

1. Подайте следующую команду:

```powershell
$List = Get-WinUserLanguageList
```
2. Затем команду:

```powershell
$List
```
3. Если языки настроены правильно (что вряд ли), то вы увидете следующее:

```batch

LanguageTag : ru
Autonym : русский
EnglishName : Russian
LocalizedName : Russian
ScriptName : Cyrillic
InputMethodTips : {0419:00000419}
Spellchecking : True
Handwriting : False

LanguageTag : en-US
Autonym : English (United States)
EnglishName : English
LocalizedName : English (United States)
ScriptName : Latin
InputMethodTips : {0409:00000409}
Spellchecking : True
Handwriting : False


```

4. Допустим, у вас ошибка в параметре InputMethodTips (что весьма вероятно, если у вас русский интерфейс, а клавиатура не переключается на русский язык). Если да, выполните следующие команды:

```powershell
$List[0].InputMethodTips.Clear()
```

```powrshell
$List[0].InputMethodTips.Add('0419:00000419')
```
```powershell
Set-WinUserLanguageList $List -Force
```

```powershell
$List

```

если нет, перейдите к пункту 6.

5. После последней команды у Вас должен появится вывод, как в пункте 3. Если это так, перейдите к пункту 6. Иначе вернитесь к пункту 4. и измените другие параметры аналогично.

6. Подайте команды:

```powershell
Get-WinUserLanguageList
```

```powershell
Get-WinDefaultInputMethodOverride
```

7. Должен появится следующий выод:

```powershell

InputMethodTip Description
-------------- -----------
0409:00000409  English (United States) - US


```

8. И вот, теперь задаем английский по умолчанию (если у Вас любой другой вывод, отличный от английского):

```powershell
Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"
```

9. Bingo! Теперь у вас клавиатурная раскладка должна переключаться нормально, и по умолчанию будет активной английская раскладка.
