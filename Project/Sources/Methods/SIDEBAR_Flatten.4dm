//%attributes = {"preemptive":"capable"}
C_COLLECTION:C1488($0;$1;$vc_flat)
C_OBJECT:C1216($vo_sb;$vo_sbl2;$vo_sbl3)
C_LONGINT:C283($vl_index)

$vc_flat:=New collection:C1472
For each ($vo_sb;$1)
	$vl_index:=$vl_index+1
	$vo_sb.index:=$vl_index
	$vo_sb.collapsed:=False:C215
	$vc_flat.push($vo_sb)
	If (OB Is defined:C1231($vo_sb;"sub"))
		For each ($vo_sbl2;$vo_sb.sub)
			$vl_index:=$vl_index+1
			$vo_sbl2.index:=$vl_index
			$vo_sbl2.title:="  "+$vo_sbl2.title
			$vo_sbl2.collapsed:=False:C215
			$vc_flat.push($vo_sbl2)
			  //This probably needs to be removed and items inserted only on demand.
			If (OB Is defined:C1231($vo_sbl2;"sub"))
				For each ($vo_sbl3;$vo_sbl2.sub)
					$vl_index:=$vl_index+1
					$vo_sbl3.index:=$vl_index
					$vo_sbl3.title:="    "+$vo_sbl3.title
					$vc_flat.push($vo_sbl3)
				End for each 
				  //End Level 3
			End if 
		End for each 
	End if 
End for each 
$0:=$vc_flat
