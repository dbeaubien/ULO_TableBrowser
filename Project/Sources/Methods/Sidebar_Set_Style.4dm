//%attributes = {"preemptive":"capable"}
C_LONGINT:C283($0;$vl_return)
C_OBJECT:C1216($1)
If ($1.styleMethod#Null:C1517)
	EXECUTE METHOD:C1007($1.styleMethod;$vl_return;$1)
Else 
	$0:=Choose:C955(($1.id=1);Bold:K14:2;Plain:K14:1)
End if 
$0:=$vl_return