C_LONGINT:C283($index;$row)
$index:=(OBJECT Get pointer:C1124(Object current:K67:2)->-1)
$row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
OBJECT SET VISIBLE:C603(*;"ql_value@"+String:C10($row;"0000");False:C215)

Case of 
	: (Form:C1466.parent.queryFields[$index].fieldType=Is text:K8:3) | (Form:C1466.parent.queryFields[$index].fieldType=Is alpha field:K8:1)
		OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
	: (Form:C1466.parent.queryFields[$index].fieldType=Is longint:K8:6) | (Form:C1466.parent.queryFields[$index].fieldType=Is real:K8:4)
		OBJECT SET VISIBLE:C603(*;"ql_valueNum"+String:C10($row;"0000");True:C214)
	: (Form:C1466.parent.queryFields[$index].fieldType=Is date:K8:7)
		OBJECT SET VISIBLE:C603(*;"ql_valueDate"+String:C10($row;"0000");True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
		
End case 
Form:C1466.parent.lastQuery[$row].field:=Form:C1466.parent.queryFields[$index].fieldNum