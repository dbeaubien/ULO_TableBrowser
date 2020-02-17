//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 14/02/20, 11:29:58
  // ----------------------------------------------------
  // Method: SORT_FORM_MOVE_SELECTED_FIELD
  // Description
  // Adds selected displayField to view.details.sortData
  //
  // Parameters
  // $1 - Collection - Target Collection
  // ----------------------------------------------------

C_LONGINT:C283($vl_idx)
C_OBJECT:C1216($vo_sort;$vo_field)
C_COLLECTION:C1488($1;$vc_target)

$vc_target:=$1

For each ($vo_field;Form:C1466.selectedFields)
	$vl_idx:=UTIL_Col_Find_Index ($vc_target;"table";al_tableNum{at_tableName};"field";$vo_field.fieldNumber)
	If ($vl_idx>=0)
		  //Field is already there!
		ALERT:C41("Field already added?!")
	Else 
		
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.fields;"table";al_tableNum{at_tableName})
		If ($vl_idx>=0)
			$vo_sort:=New object:C1471
			$vo_sort.table:=al_tableNum{at_tableName}
			$vo_sort.field:=$vo_field.fieldNumber
			$vo_sort.fieldName:=$vo_field.fieldName
			$vo_sort.formula:=""
			$vo_sort.relation:=""
			
			If (OB Is defined:C1231(Form:C1466.fields[$vl_idx];"relation"))
				$vo_sort.relation:=Form:C1466.fields[$vl_idx].relation
				If ($vo_sort.relation#"")
					$vo_sort.formula:=$vo_sort.relation+"."+Field name:C257(al_tableNum{at_tableName};$vo_sort.field)
				End if 
			End if 
			
			If ($vo_sort.formula="")
				$vo_sort.formula:=Field name:C257(al_tableNum{at_tableName};$vo_sort.field)
			End if 
			
			$vo_sort.sortDir:="ASC"
			
			$vc_target.push(OB Copy:C1225($vo_sort))
		End if 
	End if 
End for each 
$vc_target:=$vc_target
VIEW_FORM_BUILD_DISPLAY_FIELD ($vc_target)
