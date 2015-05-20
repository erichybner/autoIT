Global $o_adoCon, $o_adoRs 

Global $strSQL

$strSQL = "Select * From Mytable;" 

_OracleConn ($o_adoCon)

$o_adoRs = ObjCreate("ADODB.Recordset") 

$o_adoRs =$o_adoCon.Execute($strSQL) 

if $o_adoRs.BOF = -1 And $o_adoRs.EOF = -1 Then

      Msgbox (16, $conProgName, "No Data to Display with the given conditions with this SQL " & @CRLF & @CRLF & $strSQL) 

      exit

     EndIf

$o_adoRs.MoveFirst

Msgbox (0,"", $o_adoRs.Fields(0).Value) ; you have to tube .Value which is not required in MS-Access !!!!

$o_adoCon.Close

;----------------------------

Func _OracleConn(ByRef $o_adoCon) 

Local $strCon = "Driver={Microsoft ODBC for Oracle}; " & _ "SERVER=mp2iprod

; USER id=myservrname

; password=mypassword;" 

; Local $strCon = "Driver={Microsoft ODBC for Oracle}

; " & _ ; "SERVER=" & $Server & "; " & _ 

; "USER=" & $USER & "; " & _ 

; "Password=" & $PWD & "; " 

 ;Msgbox (0,"Test", $strCon)

$o_adoCon = ObjCreate("ADODB.Connection")

$o_adoCon.Open ($strCon) ;$o_adoCon.Open ( "Driver={Microsoft ODBC for Oracle}

Return $o_adoCon

EndFunc ;==>_AccessConnectConnFunc 