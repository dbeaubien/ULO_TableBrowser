//%attributes = {"shared":true,"preemptive":"capable"}
C_COLLECTION:C1488($0;$2;$vc_relations)
C_TEXT:C284($1;$vt_tableName;$vt_prop)
C_LONGINT:C283($vl_index)
$vt_tableName:=$1
If (Count parameters:C259>1)
	$vc_relations:=$2.copy()
Else 
	$vc_relations:=New collection:C1472
End if 
For each ($vt_prop;ds:C1482[$vt_tableName])
	If (ds:C1482[$vt_tableName][$vt_prop].kind="relatedEntit@")  //Handles Entity & Entities
		$vc_relations.push(ds:C1482[$vt_tableName][$vt_prop])  //Adding here reduces the depth of the chain.
		$vl_index:=UTIL_Col_Find_Index ($vc_relations;"relatedDataClass";ds:C1482[$vt_tableName][$vt_prop].relatedDataClass)
		If (Not:C34((ds:C1482[$vt_tableName][$vt_prop].relatedDataClass=$vt_tableName))) & ($vl_index=-1)
			  //$vc_relations.push(ds[$vt_tableName][$vt_prop])//Adding here increases the depth of the chain.
			$vc_relations:=ULO_Get_Related_Tables (ds:C1482[$vt_tableName][$vt_prop].relatedDataClass;$vc_relations)
		End if 
	End if 
End for each 
$0:=$vc_relations.copy()

