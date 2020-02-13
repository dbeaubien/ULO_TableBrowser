//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 16/01/20, 11:09:31
  // ----------------------------------------------------
  // Method: VIEW_FORM_MOVE_SELECTED_FIELD
  // Description
  // Adds selected displayField to displayCols and View.detail.cols
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($vl_idx)
C_OBJECT:C1216($vo_col;$vo_field)

For each ($vo_field;Form:C1466.selectedFields)
	$vl_idx:=UTIL_Col_Find_Index (Form:C1466.view.detail.cols;"table";al_tableNum{at_tableName};"field";$vo_field.fieldNumber)
	If ($vl_idx>=0)
		Form:C1466.view.detail.cols[$vl_idx].selected:=True:C214
	Else 
		  //Build and add col obj
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.fields;"table";al_tableNum{at_tableName})
		If ($vl_idx>=0)
			$vo_col:=New object:C1471
			$vo_col.selected:=True:C214
			$vo_col.table:=al_tableNum{at_tableName}
			$vo_col.field:=$vo_field.fieldNumber
			$vo_col.fieldName:=$vo_field.fieldName
			$vo_col.header:=$vo_field.fieldName
			$vo_col.formula:=""
			$vo_col.relation:=""
			
			If (OB Is defined:C1231(Form:C1466.fields[$vl_idx];"relation"))
				$vo_col.relation:=Form:C1466.fields[$vl_idx].relation
				If ($vo_col.relation#"")
					$vo_col.formula:=$vo_col.relation+"."+Field name:C257(al_tableNum{at_tableName};$vo_col.field)
				End if 
			End if 
			
			If ($vo_col.formula="")
				$vo_col.formula:=Field name:C257(al_tableNum{at_tableName};$vo_col.field)
			End if 
			
			$vo_col.width:=100
			$vo_col.fieldType:=Type:C295(Field:C253(al_tableNum{at_tableName};$vo_field.fieldNumber)->)
			$vo_col.format:=""
			$vo_col.fontStyle:=0
			$vo_col.fontColour:=0x0000  //Black
			$vo_col.fontColourHex:="000000"
			$vo_col.alignment:="Left"
			$vo_col.total:=False:C215
			$vo_col.min:=False:C215
			$vo_col.max:=False:C215
			$vo_col.average:=False:C215
			Form:C1466.view.detail.cols.push(OB Copy:C1225($vo_col))
		End if 
	End if 
End for each 
VIEW_FORM_BUILD_DISPLAY_COL 
VIEW_FORM_BUILD_DISPLAY_FIELD 
