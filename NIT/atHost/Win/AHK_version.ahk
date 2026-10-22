;shows what version of ahk the user is running
; i think sinkfaze might have come up with this originally (dist. by camerb)

info := "AutoHotkey:`t"  "AutoHotkey" ((A_AhkVersion < 1.1) ? " Classic ": ((A_IsDll ? "_H (DLL)":"_L")))
   . "`nAHK Version:`t" A_AhkVersion
   . "`nUnicode:`t`t" (A_IsUnicode ? "Yes " ((A_PtrSize=8) ? "(64-bit)" : "(32-bit)") : "No")
   . "`nOperating System:`t" (!A_OSVersion ? A_OSType : A_OSVersion) " " (A_Is64bitOS ? "(64-bit)" : "(32-bit)")
   . "`nAdmin Rights:`t" (A_IsAdmin ? "Yes" : "No")
MsgBox, 68, Support Information, %info%`n`nWould you like to copy this information to the Clipboard?
IfMsgBox Yes
{
   Clipboard := info
   ClipWait
   MsgBox, The information was sent to the Clipboard.
}
return