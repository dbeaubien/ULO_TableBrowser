C_LONGINT:C283($row)
$row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
If (FORM Event:C1606.code=On Data Change:K2:15)
	Form:C1466.parent.lastQuery[$row].attribute:=OBJECT Get pointer:C1124(Object current:K67:2)->
End if 