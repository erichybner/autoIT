#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=A3Service_Wrapper_X86.exe
#AutoIt3Wrapper_Outfile_x64=A3Service_Wrapper_X64.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=Written by Bitboy for Autoit.de, Administrator.de
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Winapi.au3>
#include <Services.au3>

Func _main($iArg, $sArgs)
	;_WinAPI_WaitForSingleObject($service_stop_event, 0)
	While $bServiceRunning ; REQUIRED  ( dont change variable name ) ; there are several ways to find that service have to be stoped - $Running flag in loop is the first method
		#region --> insert your running code here

		#endregion --> insert your running code here
		_Sleep(100)
	WEnd
EndFunc   ;==>_main

Func _Sleep($delay)
	Local $result = DllCall($hKernel32_DLL, "none", "Sleep", "dword", $delay)
EndFunc   ;==>_Sleep

Func _exit()
	#region --> insert your exiting code here

	#endregion --> insert your exiting code here
EndFunc   ;==>_exit

;=================================
;===        Script Start       ===
;=================================
;~ If $bDebug Then logprint("script started")
If $cmdline[0] > 0 Then
	Switch $cmdline[1]
		Case "install", "-i", "/i"
;~ 			msgbox(0,"","toto")
			InstallService()
		Case "remove", "-u", "/u", "uninstall"
			RemoveService()

		Case Else
			ConsoleWrite(" - - - Help - - - " & @CRLF)
			ConsoleWrite("params : " & @CRLF)
			ConsoleWrite(" -i : install service" & @CRLF)
			ConsoleWrite(" -u : remove service" & @CRLF)
			ConsoleWrite(" - - - - - - - - " & @CRLF)
			Exit
			;start service.
	EndSwitch
Else
	_Service_init($sServiceName)
	Exit
EndIf


; some loging func
Func logprint($text, $nolog = 0)
	If $nolog Then
		MsgBox(0, "MyService", $text, 1)
	Else
		If Not FileExists($MainLog) Then FileWriteLine($MainLog, "Log created: " & @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC)
		FileWriteLine($MainLog, @YEAR & @MON & @MDAY & " " & @HOUR & @MIN & @SEC & " [" & @AutoItPID & "] >> " & $text)
	EndIf
	Return 0
;~ ConsoleWrite($text & @CRLF)
EndFunc   ;==>logprint
Func InstallService()
	#RequireAdmin
	Local $bDebug = True
;~ 	If $bDebug Then ConsoleWrite("InstallService(): Installing service, please wait")
	If $cmdline[0] > 1 Then

		$sServiceName = $cmdline[2]
	EndIf
	If $bDebug Then ConsoleWrite("InstallService("&$sServiceName &"): Installing service, please wait")
	_Service_Create($sServiceName, "Au3Service " & $sServiceName, $SERVICE_WIN32_OWN_PROCESS, $SERVICE_DEMAND_START, $SERVICE_ERROR_SEVERE, '"' & @ScriptFullPath & '"')
	If @error Then

		If $bDebug Then ConsoleWrite("InstallService(): Problem installing service, Error number is " & @error & @CRLF & " message : " & _WinAPI_GetLastErrorMessage())
	Else
		If $bDebug Then ConsoleWrite("InstallService(): Installation of service successful")
	EndIf
	Exit
EndFunc   ;==>InstallService
Func RemoveService()
	_Service_Stop($sServiceName)
	_Service_Delete($sServiceName)
	If Not @error Then
;~ 		If $bDebug Then logprint("RemoveService(): service removed successfully" & @CRLF)
	EndIf
	Exit
EndFunc

