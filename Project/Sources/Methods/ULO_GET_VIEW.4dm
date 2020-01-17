//%attributes = {"preemptive":"capable"}
C_OBJECT:C1216($0;$vo_view)
C_VARIANT:C1683($1)
C_LONGINT:C283($2)  //User & table
C_TEXT:C284($3)

If ($2=-1)
	$vo_view:=ds:C1482["uloData"].query("id == :1";$1).first()
Else 
	$vo_view:=ds:C1482["uloData"].query("user == :1 & table == :2 & default == True & handle == :3";$1;$2;$3).first()
End if 
If ($vo_view#Null:C1517)
	$0:=$vo_view.toObject()
Else 
	$0:=Null:C1517
End if 
