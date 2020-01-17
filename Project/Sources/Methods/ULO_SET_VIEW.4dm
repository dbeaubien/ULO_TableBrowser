//%attributes = {"shared":true}
C_OBJECT:C1216($1)
C_LONGINT:C283($vl_table;$vl_index)

If (Not:C34(Undefined:C82($1.table)))
	$vl_table:=$1.table
	$vl_index:=Form:C1466.navItems.findIndex("UTIL_Find_Collection";"id";$vl_table)
	Form:C1466.navItems[$vl_index].view:=$1
End if 

