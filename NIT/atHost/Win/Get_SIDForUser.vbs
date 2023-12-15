' *********************************************************
'
' Get_UserForSID.vbs
'  Returns Account's SID for User Name
'
' *********************************************************

Dim aSID, aString, aDomain, aUser
Dim Result

aDomain = "LAPTOP-VG"
aUser = "yuden"

aString = "Win32_UserAccount.Name=" + Chr(39) + aUser + Chr(39) + ",Domain=" + Chr(39) + aDomain +Chr(39)
Result = ""

strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set objAccount = objWMIService.Get(aString)
aSID = objAccount.SID

Result = Result + "SID = " + aSID + vbCrLf
Result = Result + "Name = " + aUser + vbCrLf
Result = Result + "Domain = " + aDomain + vbCrLf

Wscript.Echo Result
