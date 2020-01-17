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

$vl_idx:=Form:C1466.view.detail.cols.findIndex("UTIL_Find_Collection";"table";al_tableNum{at_tableName};"field";Form:C1466.selectedField.fieldNumber)
If ($vl_idx>=0)
	Form:C1466.view.detail.cols[$vl_idx].selected:=True:C214
Else 
	  //Build and add col obj
	$vl_idx:=Form:C1466.fields.findIndex("UTIL_Find_Collection";"table";al_tableNum{at_tableName})
	If ($vl_idx>=0)
		$vo_col:=New object:C1471
		$vo_col.selected:=True:C214
		$vo_col.table:=al_tableNum{at_tableName}
		$vo_col.field:=Form:C1466.selectedField.fieldNumber
		$vo_col.fieldName:=Form:C1466.selectedField.fieldName
		$vo_col.header:=Form:C1466.selectedField.fieldName
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
		$vo_col.fieldType:=""
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
VIEW_FORM_BUILD_DISPLAY_COL 
VIEW_FORM_BUILD_DISPLAY_FIELD 
