C_LONGINT:C283($index;$row)
If (FORM Event:C1606.code=On Data Change:K2:15)
	$index:=(OBJECT Get pointer:C1124(Object current:K67:2)->-1)
	$row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
	Form:C1466.parent.lastQuery[$row].oper:=Form:C1466.parent.queryOperators[$index].operand
	
	OBJECT SET VISIBLE:C603(*;"ql_value@"+String:C10($row;"0000");False:C215)
	OBJECT SET VISIBLE:C603(*;"ql_attribute"+String:C10($row;"0000");False:C215)
	
	If (Form:C1466.parent.lastQuery[$row].oper="in") | (Form:C1466.parent.lastQuery[$row].oper="not in")
		OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
	Else 
		Case of 
			: (Form:C1466.parent.lastQuery[$row].type=Is text:K8:3) | (Form:C1466.parent.lastQuery[$row].type=Is alpha field:K8:1)
				OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
			: (Form:C1466.parent.lastQuery[$row].type=Is longint:K8:6) | (Form:C1466.parent.lastQuery[$row].type=Is real:K8:4)
				OBJECT SET VISIBLE:C603(*;"ql_valueNum"+String:C10($row;"0000");True:C214)
			: (Form:C1466.parent.lastQuery[$row].type=Is date:K8:7)
				OBJECT SET VISIBLE:C603(*;"ql_valueDate"+String:C10($row;"0000");True:C214)
			: (Form:C1466.parent.lastQuery[$row].type=Is object:K8:27)
				OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
				OBJECT SET VISIBLE:C603(*;"ql_attribute"+String:C10($row;"0000");True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
		End case 
	End if 
End if 