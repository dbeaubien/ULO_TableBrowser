C_LONGINT:C283($index;$row)
If (FORM Event:C1606.code=On Data Change:K2:15)
	$index:=(OBJECT Get pointer:C1124(Object current:K67:2)->-1)
	$row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
	Form:C1466.parent.lastQuery[$row].conjunction:=Form:C1466.parent.queryConjunctions[$index].operand
	If ($row=(Form:C1466.parent.lastQuery.length-1))  //ql_conjunction0000
		QE_ADD_LINE 
	End if 
End if 
