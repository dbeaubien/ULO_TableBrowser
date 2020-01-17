//%attributes = {"shared":true,"preemptive":"capable"}
C_LONGINT:C283($1)
C_TEXT:C284($2)
Use (Storage:C1525)
	If (Not:C34(OB Is defined:C1231(Storage:C1525;"user")))
		Storage:C1525.user:=New shared object:C1526
	End if 
	Use (Storage:C1525.user)
		Storage:C1525.user.id:=$1
		Storage:C1525.user.name:=$2
	End use 
End use 