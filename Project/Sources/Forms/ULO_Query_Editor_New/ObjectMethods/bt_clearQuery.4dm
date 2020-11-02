C_LONGINT:C283($vl_fia;$vl_fieldLength;$vl_fieldType;$vl_table)
C_BOOLEAN:C305($vb_fieldIndexed;$vb_fieldInvisible;$vb_fieldUnique)
C_COLLECTION:C1488($vc_fields)
C_OBJECT:C1216($vo_field)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		ARRAY TEXT:C222($at_tableName;0)
		ARRAY LONGINT:C221($al_tableNum;0)
		
		COLLECTION TO ARRAY:C1562(Form:C1466.linkedTables;$at_tableName;"tableName";$al_tableNum;"tableNum")
		
		  //Reset source fields to default table
		$vl_fia:=Find in array:C230($al_tableNum;Form:C1466.tableNumber)
		If ($vl_fia>0)
			OBJECT Get pointer:C1124(Object named:K67:5;"tableList")->:=$vl_fia
		End if 
		
		$vc_fields:=ULO_Get_Table_Fields (Table name:C256(Form:C1466.tableNumber))
		$vc_fields:=$vc_fields.query("kind == 'storage'")
		$vl_table:=Form:C1466.tableNumber
		Form:C1466.currentTable:=$vl_table
		
		ARRAY LONGINT:C221($al_fields;0)
		ARRAY TEXT:C222($at_fields;0)
		
		Form:C1466.queryFields:=New collection:C1472
		COLLECTION TO ARRAY:C1562($vc_fields;$al_fields;"fieldNumber";$at_fields;"fieldName")
		ARRAY TO COLLECTION:C1563(Form:C1466.queryFields;$al_fields;"fieldNum";$at_fields;"fieldName")
		For each ($vo_field;Form:C1466.queryFields)
			GET FIELD PROPERTIES:C258($vl_table;$vo_field.fieldNum;$vl_fieldType;\
				$vl_fieldLength;$vb_fieldIndexed;$vb_fieldUnique;$vb_fieldInvisible)
			$vo_field.fieldType:=$vl_fieldType
			$vo_field.fieldLength:=$vl_fieldLength
			$vo_field.fieldIndexed:=$vb_fieldIndexed
			$vo_field.fieldUnique:=$vb_fieldUnique
			$vo_field.fieldInvisible:=$vb_fieldInvisible
			$vo_field.tableNum:=$vl_table
		End for each 
		Form:C1466.queryFields:=Form:C1466.queryFields.query("fieldInvisible = :1";False:C215)
		
		EXECUTE METHOD IN SUBFORM:C1085("queryLines";"QE_LINES_METHOD";*;"UPDATE";Form:C1466)
		
		  //Clear current query collection, add default line
		Form:C1466.lastQuery:=New collection:C1472
		Form:C1466.lastQuery.push(New object:C1471("lBracket";False:C215;"table";Form:C1466.queryFields[0].tableNum;\
			"field";Form:C1466.queryFields[0].fieldNum;"type";Form:C1466.queryFields[0].fieldType;\
			"oper";Form:C1466.queryOperators[0].operand;"value";"";\
			"rBracket";False:C215;"conjunction";"";"fieldName";Form:C1466.queryFields[0].fieldName))
		
		EXECUTE METHOD IN SUBFORM:C1085("queryLines";"QE_LINES_METHOD";*;"CLEAR")
		
		
End case 
