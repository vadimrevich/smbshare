Option Explicit
Dim FilePath,TaskName,Repeat_Task
'Run this vbscript as Admin
If Not WScript.Arguments.Named.Exists("elevate") Then
'   CreateObject("Shell.Application").ShellExecute DblQuote(WScript.FullName) _
'   , DblQuote(WScript.ScriptFullName) & " /elevate", "", "runas", 1
   CreateObject("Shell.Application").ShellExecute DblQuote(WScript.FullName) _
   , DblQuote(WScript.ScriptFullName) & " /elevate", "", "", 1
    WScript.Quit
End If

FilePath = WScript.ScriptFullName
TaskName = "MyJokeTaskNotGenue"
' Repeat_Task = 60      '60 minutes = 1 Hour
Repeat_Task = 5      '5 minutes

Call Create_Schedule_Task(Repeat_Task,TaskName,FilePath)

'MsgBox "some thing here that be repeated every hour !",vbInformation,"some other thing"
OutputAMessage

'-------------------------------------------------------------------------
Sub Create_Schedule_Task(Repeat_Task,TaskName,FilePath)
Dim Ws,Task,Result
Set Ws = CreateObject("WScript.Shell")
Task = "CMD /C Schtasks /Create /SC DAILY /ST 08:00 /F /RI "&_
Repeat_Task &" /DU 24:00 /TN "& TaskName &" /TR "& FilePath &""
Result = Ws.run(Task,0,True)
End Sub
'-------------------------------------------------------------------------
Function Dblquote(str)
    Dblquote = chr(34) & str & chr(34)
End Function
'-------------------------------------------------------------------------


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

