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
TaskName = "MyTask"
' Repeat_Task = 60      '60 minutes = 1 Hour
Repeat_Task = 5      '5 minutes

Call Create_Schedule_Task(Repeat_Task,TaskName,FilePath)

MsgBox "some thing here that be repeated every hour !",vbInformation,"some other thing"

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
