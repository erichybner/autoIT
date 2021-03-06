#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Func _WinWaitActivate($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc

Func _Copy()
	_WinWaitActivate("ClientList - Notepad","")
	Send("{HOME}{CTRLDOWN}{HOME}{CTRLUP}{SHIFTDOWN}{END}{SHIFTUP}{CTRLDOWN}x{CTRLUP}{DEL}")
EndFunc

Func _Paste()
	_WinWaitActivate("Edit Options for Custom Field : Client - Tyler JIRA Greenhopper - Google Chrome","")
	Send("{CTRLDOWN}v{CTRLUP}{ENTER}")
	ClipPut("")
EndFunc

_Copy()
While ClipGet() <>  ""
	_Paste()
	Sleep(500)
	_Copy()
	Sleep(500)
WEnd



