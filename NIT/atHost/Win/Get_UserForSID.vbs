' *********************************************************
'
' Get_UserForSID.vbs
'  Returns Account's User Name for SID
'
' *********************************************************

Dim aSID, aSIDComplex
Dim Result

'aSID = "S-1-5-21-3172013636-3473875061-2000677823-1001"
aSID = "S-1-5-32-500"

aSIDComplex = "Win32_SID.SID=" + Chr(39) + aSID + Chr(39)
Result = ""

'Wscript.Echo aSIDComplex

strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set objAccount = objWMIService.Get(aSIDComplex)

Result = Result + "SID = " + aSID + vbCrLf
Result = Result + "Name = " + objAccount.AccountName + vbCrLf
Result = Result + "Domain = " + objAccount.ReferencedDomainName + vbCrLf

Wscript.Echo Result
