C_COLLECTION:C1488($vc_fields)
C_OBJECT:C1216($vo_field)
C_LONGINT:C283($vl_fieldLength;$vl_fieldType;$vl_table)
C_BOOLEAN:C305($vb_fieldIndexed;$vb_fieldInvisible;$vb_fieldUnique)

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		$vc_fields:=ULO_Get_Table_Fields (at_tableName{OBJECT Get pointer:C1124(Object current:K67:2)->})
		$vc_fields:=$vc_fields.query("kind == 'storage'")
		$vl_table:=al_tableNum{OBJECT Get pointer:C1124(Object current:K67:2)->}
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
		
End case 
