' *********************************************************
' notGenue.message.vbs
' This File Contents a Subroutines and Functions
' to Output a Message Box for not genue Windows
'
' This is a Joke, not a virus!
'
' *********************************************************

' *********************************************************
' random_number_generator (lowerLim, upperLim)
' This Function will Generate a Rundom Number
' withing Limits
' *********************************************************
Function random_number_generator (lowerLim, upperLim)
    Randomize
    randNumber = Int(((upperLim-lowerLim+1)* Rnd())+ lowerLim)
    random_number_generator = randNumber
End Function

' *********************************************************
' Function GetAJokeMessage
' This Function will Get a Random Message that
' Windows is not Genue
' *********************************************************
Function GetAJokeMessage()

  ' Declere a Messages Array
  Dim MessArray(5)
  Dim RndNunber

  ' Define Messages
  MessArray(0) = "Активировать Windows" & vbNewLine & vbNewLine & "Перейдите в настройки, чтобы активировать Windows"
  MessArray(1) = "Использованная Вами копия Windows не проходит подлинную проверку"
  MessArray(2) = "Эта копия Windows не является подлинной" & vbNewLine & vbNewLine & "Возможно, Вы стали жертвами подделки программного обеспечения"
  MessArray(3) = "На этом компьютере установлена не подлинная Windows" & vbNewLine & vbNewLine & "Чтобы использовать Windows без перерыва, на этом компьютере должна быть установлена подлинная Windows"
  MessArray(4) = "Вы должны активировать сегодня" & vbNewLine & vbNewLine & "Активируйте Windows прямо сейчас"
  MessArray(5) = "Активировать Windows сейчас" & vbNewLine & vbNewLine & "Нажмите на это сообщение, чтобы начать активацию"

  ' Run Payload = random_number_generator(0,5)
  RndNumber = random_number_generator(0,5)
  GetAJokeMessage = MessArray(RndNumber)
  ' GetAJokeMessage = RndNumber
End Function

' *********************************************************
' Subroutine OutputAMessage
'
' *********************************************************
Sub OutputAMessage()

  ' Run Payload
  MsgBox "Alert!" & vbNewLine & GetAJokeMessage(), vbOKOnly Or vbInformation, "Alert Activation Message"
  
End Sub ' OutputAMessage

OutputAMessage