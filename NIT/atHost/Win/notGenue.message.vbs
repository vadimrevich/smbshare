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
  MessArray(0) = "������������ Windows" & vbNewLine & vbNewLine & "��������� � ���������, ����� ������������ Windows"
  MessArray(1) = "�������������� ���� ����� Windows �� �������� ��������� ��������"
  MessArray(2) = "��� ����� Windows �� �������� ���������" & vbNewLine & vbNewLine & "��������, �� ����� �������� �������� ������������ �����������"
  MessArray(3) = "�� ���� ���������� ����������� �� ��������� Windows" & vbNewLine & vbNewLine & "����� ������������ Windows ��� ��������, �� ���� ���������� ������ ���� ����������� ��������� Windows"
  MessArray(4) = "�� ������ ������������ �������" & vbNewLine & vbNewLine & "����������� Windows ����� ������"
  MessArray(5) = "������������ Windows ������" & vbNewLine & vbNewLine & "������� �� ��� ���������, ����� ������ ���������"

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