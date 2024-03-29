//%attributes = {}
C_OBJECT:C1216($0;$e_sort)
C_VARIANT:C1683($1)
C_LONGINT:C283($2)  //User & table
C_TEXT:C284($3)

If (Count parameters:C259=1)
	$e_sort:=ds:C1482["uloData"].get($1)
Else 
	  //First check for User specific default sort
	$e_sort:=ds:C1482["uloData"].query("user == :1 & table == :2 & default == True & type == 13";$1;$2).first()
	If ($e_sort=Null:C1517)
		  //If not found, get system default a.k.a userId = 0
		$e_sort:=ds:C1482["uloData"].query("user == :1 & table == :2 & default == True & type == 13";0;$2).first()
	End if 
End if 

If ($e_sort#Null:C1517)
	$0:=$e_sort.toObject()
Else 
	$0:=Null:C1517
End if 
