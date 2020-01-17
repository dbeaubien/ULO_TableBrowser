//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
C_OBJECT:C1216($1)
C_LONGINT:C283($vl_table)

If (Not:C34(Undefined:C82($1.table)))
	$vl_table:=$1.table
	Use (Storage:C1525.defaultViews)
		$vl_index:=Storage:C1525.defaultViews.findIndex("UTIL_Find_Collection_Number";"table";$vl_table)
		If ($vl_index>0)
			Storage:C1525.defaultViews.remove($vl_index)
		End if 
		Storage:C1525.defaultViews.push($1)
	End use 
End if 