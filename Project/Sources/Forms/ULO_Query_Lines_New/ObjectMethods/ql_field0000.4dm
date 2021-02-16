C_OBJECT:C1216($vo_field;$vo_table)
C_TEXT:C284($vt_menu;$vt_selected)
C_LONGINT:C283($vl_index;$vl_tableIndex;$row)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		$vt_menu:=Create menu:C408
		
		For each ($vo_field;Form:C1466.parent.queryFields)
			APPEND MENU ITEM:C411($vt_menu;$vo_field.fieldName)
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;String:C10($vo_field.fieldNum))
		End for each 
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu)
		
		If ($vt_selected#"")
			$vl_tableIndex:=UTIL_Col_Find_Index (Form:C1466.parent.linkedTables;"tableNum";Form:C1466.parent.currentTable)
			If ($vl_tableIndex>=0)
				$vo_table:=Form:C1466.parent.linkedTables[$vl_tableIndex]
			Else 
				$vo_table:=New object:C1471
			End if 
			
			$vl_index:=UTIL_Col_Find_Index (Form:C1466.parent.queryFields;"fieldNum";Num:C11($vt_selected))
			If ($vl_index>=0)
				$vo_field:=Form:C1466.parent.queryFields[$vl_index]
				OBJECT Get pointer:C1124(Object current:K67:2)->:=$vo_field.fieldName
				$row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
				
				OBJECT SET VISIBLE:C603(*;"ql_value@"+String:C10($row;"0000");False:C215)
				OBJECT SET VISIBLE:C603(*;"ql_attribute"+String:C10($row;"0000");False:C215)
				
				If (Form:C1466.parent.lastQuery[$row].oper="in") | (Form:C1466.parent.lastQuery[$row].oper="not in")
					OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
				Else 
					Case of 
						: ($vo_field.fieldType=Is text:K8:3) | ($vo_field.fieldType=Is alpha field:K8:1)
							OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
						: ($vo_field.fieldType=Is longint:K8:6) | ($vo_field.fieldType=Is real:K8:4)
							OBJECT SET VISIBLE:C603(*;"ql_valueNum"+String:C10($row;"0000");True:C214)
						: ($vo_field.fieldType=Is date:K8:7)
							OBJECT SET VISIBLE:C603(*;"ql_valueDate"+String:C10($row;"0000");True:C214)
						: ($vo_field.fieldType=Is object:K8:27)
							OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
							OBJECT SET VISIBLE:C603(*;"ql_attribute"+String:C10($row;"0000");True:C214)
						Else 
							OBJECT SET VISIBLE:C603(*;"ql_valueText"+String:C10($row;"0000");True:C214)
					End case 
				End if 
				
				OBJECT GET COORDINATES:C663(*;"ql_field"+String:C10($row;"0000");$vl_left;$vl_top;$vl_right;$vl_bottom)
				If ($vo_field.fieldType=Is object:K8:27)
					OBJECT SET COORDINATES:C1248(*;"ql_field"+String:C10($row;"0000");$vl_left;$vl_top;124;$vl_bottom)
				Else 
					OBJECT SET COORDINATES:C1248(*;"ql_field"+String:C10($row;"0000");$vl_left;$vl_top;244;$vl_bottom)
					Form:C1466.parent.lastQuery[$row].attribute:=""
				End if 
				
				Form:C1466.parent.lastQuery[$row].fieldName:=$vo_field.fieldName
				Form:C1466.parent.lastQuery[$row].table:=$vo_field.tableNum
				Form:C1466.parent.lastQuery[$row].field:=$vo_field.fieldNum
				Form:C1466.parent.lastQuery[$row].type:=$vo_field.fieldType
				If (OB Is defined:C1231($vo_table;"relation"))
					Form:C1466.parent.lastQuery[$row].relation:=$vo_table.relation
				Else 
					Form:C1466.parent.lastQuery[$row].relation:=""
				End if 
			End if 
		End if 
		
		RELEASE MENU:C978($vt_menu)
		
End case 
