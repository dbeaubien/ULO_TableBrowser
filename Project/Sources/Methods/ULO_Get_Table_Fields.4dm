//%attributes = {"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 26/11/19, 12:02:59
  // ----------------------------------------------------
  // Method: ULO_Get_Table_Fields
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_COLLECTION:C1488($0)
C_OBJECT:C1216($vo_prop)
C_TEXT:C284($1;$vt_prop)
$0:=New collection:C1472
For each ($vt_prop;ds:C1482[$1])
	$vo_prop:=New object:C1471
	$vo_prop:=ds:C1482[$1][$vt_prop]
	$vo_prop.fieldName:=$vt_prop
	$0.push($vo_prop)
End for each 


