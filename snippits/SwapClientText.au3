#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Fileversion=0.0.0.21
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****\
HotKeySet("`", "DoEdit")
HotKeySet("~", "DoExit")


While 1
    Sleep ( 100 )
WEnd
Exit


Func DoEdit()
	Dim $OldPos = MouseGetPos()
	WinWait("Edit Option for Custom Field : Client - Tyler JIRA Greenhopper","")
	MouseClick("left",-643,-33,1)
	Send("{HOME}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{SHIFTDOWN}{END}{SHIFTUP}{CTRLDOWN}x{CTRLUP}{BACKSPACE}{BACKSPACE}{BACKSPACE}{HOME}{CTRLDOWN}v{CTRLUP},{SPACE}{HOME}{SHIFTDOWN}{END}{SHIFTUP}{CTRLDOWN}c{CTRLUP}{ENTER}")
	WinWait("Edit Option for Custom Field : Client - Tyler JIRA Greenhopper","")
	Sleep(750)
	Send("{CTRLDOWN}fv{CTRLUP}{ESC}")
	MouseMove($OldPos[0], $OldPos[1])
EndFunc

Func DoExit()
	Exit 0
EndFunc









