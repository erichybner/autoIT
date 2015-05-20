#include <GUIConstants.au3>

Const $adStateClosed = 0
Const $adStateOpen = 1

Global $oError
; Initializes COM handler
$oError = ObjEvent("AutoIt.Error", "ErrHandler")
Global $adoCn = ObjCreate( "ADODB.Connection" )
$adoCn.Properties("Prompt") = 2; 1=PromptAlways, 2=PromptComplete
Global $adoRs = ObjCreate( "ADODB.RecordSet" )
Local $Txt, $I, $J

; Set your Default Oracle Connection String Here
$Txt = "DRIVER={OraHome92};SERVER=ORASERV;DBQ=ORADB;UID=userid;PWD=password;"

$Form1 = GUICreate("Oracle ADO Test", 633, 447, 193, 115)
$ButtonConnect = GUICtrlCreateButton("&Connect", 8, 8, 89, 25, 0)
$InputConnect = GUICtrlCreateInput($Txt, 104, 8, 521, 21)
$ButtonSQL = GUICtrlCreateButton("&Query", 8, 40, 89, 25, 0)
$EditSQL = GUICtrlCreateEdit("SELECT * FROM <TABLE> WHERE <condition>", 104, 40, 521, 145)
$Label1 = GUICtrlCreateLabel("Results:", 8, 176, 42, 17)
$EditResults = GUICtrlCreateEdit("", 8, 200, 617, 241)
GUISetState(@SW_SHOW)
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
    Case $GUI_EVENT_CLOSE
        If $adoCn.State = $adStateOpen Then $adoCn.Close
        Exit
    Case $ButtonConnect
        If $adoCn.State = $adStateOpen Then $adoCn.Close
        $adoCn.ConnectionString = GUICtrlRead($InputConnect)
        $adoCn.Open
        $Txt = "Connected"
        If $adoCn.State <> $adStateOpen Then $Txt = "Not " & $Txt
        GUICtrlSetData($EditResults, $Txt & @CRLF & $adoCn.ConnectionString)
    Case $ButtonSQL
        $Txt = GUICtrlRead($EditSQL)
        If $adoRs.State = $adStateOpen Then $adoRs.Close
        GUICtrlSetData($EditResults, "Executing " & $Txt);"")
        $adoRs = $adoCn.Execute($Txt)
        If $adoRs.State = $adStateOpen Then
           $Txt = ""
           $J = $adoRs.Fields.Count - 1
           For $I = 0 To $J
                 $Txt = $Txt & $adoRs.Fields($I).Name & @TAB
           Next;$I
           $Txt = $Txt & @CRLF
           $Txt = $Txt & $adoRs.GetString(2, -1, @TAB, @CRLF, "Null")
           $adoRs.Close
           GUICtrlSetData($EditResults, $Txt)
        EndIf
    EndSwitch
WEnd

Func ErrHandler()
  $HexNumber=Hex($oError.number,8)
  Msgbox(0, StringReplace( $oError.windescription, "error", "COM Error #") & $oError.Number, _
            $oError.Description & @CRLF & _
            "Source: "       & @TAB & $oError.source         & @CRLF & _
            "at Line #: " & $oError.ScriptLine & @TAB & _
            "Last DllError: " & @TAB & $oError.lastdllerror   & @CRLF & _
             "Help File: " & @TAB & $oError.helpfile & @TAB & "Context: " & @TAB & $oError.helpcontext _
            )
  SetError(1) ; to check for after this function returns
 ;Exit
Endfunc