//%attributes = {"shared":true}
C_LONGINT:C283($1;$vl_table;$vl_fieldType;$vl_fieldLength;$vl_wind;$vl_fia)
C_COLLECTION:C1488($vc_fields)
C_OBJECT:C1216($vo_queryForm;$vo_field;$vo_prop)
C_BOOLEAN:C305($vb_fieldIndexed;$vb_fieldUnique;$vb_fieldInvisible)
C_TEXT:C284($vt_tableName;$vt_prop)

If (Count parameters:C259>0)
	$vl_table:=$1
	ARRAY LONGINT:C221($al_fields;0)
	ARRAY TEXT:C222($at_fields;0)
	$vo_queryForm:=New object:C1471
	$vo_queryForm.tableNumber:=$vl_table
	$vo_queryForm.querySelection:=0
	$vt_tableName:=Table name:C256($vl_table)
	$vc_fields:=ULO_Get_Table_Fields ($vt_tableName)
	$vc_fields:=$vc_fields.query("kind == 'storage'")
	$vo_queryForm.queryFields:=New collection:C1472
	COLLECTION TO ARRAY:C1562($vc_fields;$al_fields;"fieldNumber";$at_fields;"fieldName")
	ARRAY TO COLLECTION:C1563($vo_queryForm.queryFields;$al_fields;"fieldNum";$at_fields;"fieldName")
	For each ($vo_field;$vo_queryForm.queryFields)
		GET FIELD PROPERTIES:C258($vl_table;$vo_field.fieldNum;$vl_fieldType;\
			$vl_fieldLength;$vb_fieldIndexed;$vb_fieldUnique;$vb_fieldInvisible)
		$vo_field.fieldType:=$vl_fieldType
		$vo_field.fieldLength:=$vl_fieldLength
		$vo_field.fieldIndexed:=$vb_fieldIndexed
		$vo_field.fieldUnique:=$vb_fieldUnique
		$vo_field.fieldInvisible:=$vb_fieldInvisible
		$vo_field.tableNum:=$vl_table
	End for each 
	$vo_queryForm.queryFields:=$vo_queryForm.queryFields.query("fieldInvisible = :1";False:C215)
	$vo_queryForm.queryOperators:=New collection:C1472
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"=";"name";"is equal to"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"#";"name";"is not equal to"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"<";"name";"is less than"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";">";"name";"is greater than"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"<=";"name";"less or equal to"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";">=";"name";"greater or equal to"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"==";"name";"contains"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"in";"name";"is in list"))
	$vo_queryForm.queryOperators.push(New object:C1471("operand";"not in";"name";"is not in list"))
	
	$vo_queryForm.queryConjunctions:=New collection:C1472
	$vo_queryForm.queryConjunctions.push(New object:C1471("operand";"";"name";"-"))
	$vo_queryForm.queryConjunctions.push(New object:C1471("operand";"&";"name";"and"))
	$vo_queryForm.queryConjunctions.push(New object:C1471("operand";"|";"name";"or"))
	$vo_queryForm.queryConjunctions.push(New object:C1471("operand";"#";"name";"except"))
	
	ARRAY TEXT:C222($at_tableName;0)
	ARRAY LONGINT:C221($al_tableNum;0)
	ULO_GET_TABLE_TITLES (->$at_tableName;->$al_tableNum)
	
	$vo_queryForm.currentTable:=$vl_table
	$vo_queryForm.linkedTables:=New collection:C1472
	$vo_queryForm.linkedTables.push(New object:C1471("tableName";$vt_tableName;"tableNum";$vl_table;"relation";""))
	For each ($vt_prop;ds:C1482[$vt_tableName])
		$vo_prop:=ds:C1482[$vt_tableName][$vt_prop]
		If ($vo_prop.kind="relatedEntities") | ($vo_prop.kind="relatedEntity")
			$vl_fia:=Find in array:C230($at_tableName;$vo_prop.relatedDataClass)
			If ($vl_fia>0)
				$vo_queryForm.linkedTables.push(New object:C1471("tableName";$vo_prop.relatedDataClass;\
					"tableNum";$al_tableNum{$vl_fia};"relation";$vo_prop.name))
			End if 
		End if 
	End for each 
	
	  //Load last query (if it exists) from sidebar navItem
	If (OB Is defined:C1231(Form:C1466.navItem;"lastQuery"))
		$vo_queryForm.lastQuery:=Form:C1466.navItem.lastQuery
	Else 
		$vo_queryForm.lastQuery:=New collection:C1472
		$vo_queryForm.lastQuery.push(New object:C1471("lBracket";False:C215;"table";$vo_queryForm.tableNumber;\
			"field";$vo_queryForm.queryFields[0].fieldNum;"type";$vo_queryForm.queryFields[0].fieldType;\
			"oper";$vo_queryForm.queryOperators[0].operand;\
			"value";"";"rBracket";False:C215;"conjunction";"-";"fieldName";$vo_queryForm.queryFields[0].fieldName))
	End if 
	$vl_wind:=UTIL_Open_Window_Centre ("ULO_Query_Editor_New";Movable dialog box:K34:7;"Query Editor")
	DIALOG:C40("ULO_Query_Editor_New";$vo_queryForm)
	CLOSE WINDOW:C154($vl_wind)
	
	If (OK=1)
		Form:C1466.navItem.lastQuery:=$vo_queryForm.lastQuery
		Form:C1466.uloRecords:=QE_Run ($1;$vo_queryForm.lastQuery;$vo_queryForm.querySelection)
	End if 
End if 
