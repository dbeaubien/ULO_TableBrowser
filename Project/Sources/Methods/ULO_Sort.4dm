//%attributes = {}
C_LONGINT:C283($1;$vl_table;$vl_fieldType;$vl_fieldLength;$vl_wind)
C_COLLECTION:C1488($vc_fields)
C_OBJECT:C1216($0;$vo_sortForm;$vo_field;$es_data)
C_BOOLEAN:C305($vb_fieldIndexed;$vb_fieldUnique;$vb_fieldInvisible)
C_TEXT:C284($vt_tableName)
If (Count parameters:C259>0)
	$vl_table:=$1
	ARRAY LONGINT:C221($al_fields;0)
	ARRAY TEXT:C222($at_fields;0)
	$vo_sortForm:=New object:C1471
	$vo_sortForm.tableNumber:=$vl_table
	$vt_tableName:=Table name:C256($vl_table)
	$vc_fields:=ULO_Get_Table_Fields ($vt_tableName)
	$vo_sortForm.sortFields:=New collection:C1472
	COLLECTION TO ARRAY:C1562($vc_fields;$al_fields;"fieldNumber";$at_fields;"fieldName")
	ARRAY TO COLLECTION:C1563($vo_sortForm.sortFields;$al_fields;"fieldNum";$at_fields;"fieldName")
	For each ($vo_field;$vo_sortForm.sortFields)
		GET FIELD PROPERTIES:C258($vl_table;$vo_field.fieldNum;$vl_fieldType;\
			$vl_fieldLength;$vb_fieldIndexed;$vb_fieldUnique;$vb_fieldInvisible)
		$vo_field.fieldType:=$vl_fieldType
		$vo_field.fieldLength:=$vl_fieldLength
		$vo_field.fieldIndexed:=$vb_fieldIndexed
		$vo_field.fieldUnique:=$vb_fieldUnique
		$vo_field.fieldInvisible:=$vb_fieldInvisible
	End for each 
	$vo_sortForm.sortFields:=$vo_sortForm.sortFields.query("fieldInvisible = :1";False:C215)
	$vo_sortForm.sortOperators:=New collection:C1472
	$vo_sortForm.queryOperators.push(New object:C1471("operand";">";"name";"asc"))
	$vo_sortForm.queryOperators.push(New object:C1471("operand";"<";"name";"dec"))
	
	
	  //Load last sort (if it exists) from sidebar navItem
	$vo_sortForm.lastSort:=New collection:C1472
	  //$vo_queryForm.lastSort.push(New object("lBracket";False;"table";$vo_queryForm.tableNumber;\
		"field";$vo_queryForm.queryFields[0].fieldNum;"type";$vo_queryForm.queryFields[0].fieldType;\
		"oper";$vo_queryForm.queryOperators[0].operand;\
		"value";"";"rBracket";False;"conjunction";"-"))
	$vl_wind:=Open form window:C675("ULO_Sort_Editor";Sheet form window:K39:12)
	DIALOG:C40("ULO_Sort_Editor";$vo_sortForm)
	CLOSE WINDOW:C154($vl_wind)
	If (OK=1)
		  //$es_data:=QE_Run ($1;$vo_queryForm.lastQuery)
	End if 
	
End if 
$0:=$es_data
