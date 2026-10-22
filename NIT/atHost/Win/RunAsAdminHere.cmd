:: //***************************************************************************
:: // ***** Script Header *****
:: // =======================================================
:: // Elevation PowerToys for Windows Vista v1.1 (04/29/2008)
:: // =======================================================
:: //
:: // File:      CmdAsAdmin.cmd
:: //
:: // Purpose:   To provide a command to start a command prompt running "As
:: //            Administrator" on Windows Vista.  
:: //
:: // Additional requirement:  "Elevate Command" PowerToy for Windows Vista
:: //                          must be installed
:: //
:: // Usage:     CmdAsAdmin.cmd "<optional folder path>"
:: //
:: // Version:   1.0.0
:: // Date :     04/29/2008
:: //
:: // History:
:: // 1.0.0   04/29/2008  Created initial version.
:: //
:: // ***** End Header *****
:: //***************************************************************************

@echo Off

setlocal enableextensions enabledelayedexpansion

if %1=="" goto Empty
goto NoneEmpty

:Empty
Elevate.cmd "%SystemRoot%\system32\cmd.exe" /k
goto Finish

:NoneEmpty
Elevate.cmd "%SystemRoot%\system32\cmd.exe" /k %CD%\%~nx1
goto Finish

:Finish

