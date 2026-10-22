$aFilePath = "C:\Util\AutoIt3.exe"

$var = FileGetVersion($aFilePath)
MsgBox(0, "Версия Explorer", $var)

$var = FileGetVersion($aFilePath, 'CompanyName') ; Одно из доступных полей
MsgBox(0, "Имя компании", $var)

