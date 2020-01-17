C_LONGINT:C283($index;$row)
If (FORM Event:C1606.code=On Data Change:K2:15)
	$index:=(OBJECT Get pointer:C1124(Object current:K67:2)->-1)
	$row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
	Form:C1466.parent.lastQuery[$row].oper:=Form:C1466.parent.queryOperators[$index].operand
End if 