//%attributes = {"preemptive":"capable"}
C_OBJECT:C1216($0;$e_view)
C_VARIANT:C1683($1)
C_LONGINT:C283($2)  //User & table
C_TEXT:C284($3)

If ($2=-1)
	$e_view:=ds:C1482["uloData"].query("id == :1";$1).first()
Else 
	  //First check for User specific default view
	$e_view:=ds:C1482["uloData"].query("user == :1 & table == :2 & default == True & handle == :3";$1;$2;$3).first()
	If ($e_view=Null:C1517)
		  //If not found, get system default a.k.a userId = 0
		$e_view:=ds:C1482["uloData"].query("user == :1 & table == :2 & default == True & handle == :3";0;$2;$3).first()
		If ($e_view=Null:C1517)
			  //Default system view missing, get from json definition
			
			ULO_CREATE_DEFAULT_VIEW 
			
		End if 
		
	End if 
End if 
If ($e_view#Null:C1517)
	$0:=$e_view.toObject()
Else 
	$0:=Null:C1517
End if 
