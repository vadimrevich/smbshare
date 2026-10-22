Установил Windows Server Core русскую версию (шла в комплекте с сервером)
По умолчанию выбралась русская раскладка.
Как сменить ее на английскую без копания в реестре? Должны же быть стандартные средства.
А то каждый раз раскладку переключать - напрягает.

Вопрос задан более трёх лет назад
853 просмотра
3 комментария

Погуглить "Windows server core change default keyboard language"

Написано более трёх лет назад
Alexey Dmitriev, Все утро гуглил, там все ссылки ведут в копание в реестре.
Ну неужели нет простого решения для такой заурядной задачи?
Написано более трёх лет назад
Написано более трёх лет назад
Реклама
Решения вопроса 1
Попробуйте так:
# здесь проверяете порядок языков (первый = 0, второй = 1 и т.д. )
$List = Get-WinUserLanguageList
$List 
# предположим русский стоит первым в списке
$List[0].InputMethodTips.Clear()
$List[0].InputMethodTips.Add('0409:00000409')
# устанавливаем язык ввода и проверяем
Set-WinUserLanguageList $List -Force
$List
Ответ написан более трёх лет назад
1 комментарий
Да! Это сработало!
Спасибо большое!

Написано более трёх лет назад
Пригласить эксперта
Ответы на вопрос 1
Роман Безруков - не совсем прав.
Ответ (кратко):
Set-WinDefaultInputMethodOverride -InputTip "0409:...

Если более развернуто, так как при инсталляции бывает не верно выставляются раскладки, надо привести к такому виду:
PS C:\Users\Administrator> Get-WinUserLanguageList

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

PS C:\Users\Administrator> Get-WinDefaultInputMethodOverride

InputMethodTip Description
-------------- -----------
0409:00000409 English (United States) - US

И вот, теперь задаем английский по умолчанию ( у меня правда как видно уже английский)
PS C:\Users\Administrator> Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"
Ответ написан более года назад
