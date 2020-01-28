//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 15/01/20, 15:15:16
  // ----------------------------------------------------
  // Method: VIEW_FORM_BUILD_DISPLAY_FIELD
  // Description
  // Populates the collection Form.displayFields
  // according to selected tableName and fields
  // Parameters
  // ----------------------------------------------------
C_BOOLEAN:C305($vb_add)
C_LONGINT:C283($vl_idx;$vl_idx2)
C_OBJECT:C1216($vo_field)

$vl_idx:=UTIL_Col_Find_Index (Form:C1466.fields;"table";al_tableNum{at_tableName})
If ($vl_idx>=0)
	Form:C1466.displayFields:=New collection:C1472
	For each ($vo_field;Form:C1466.fields[$vl_idx].fields)
		If ($vo_field.kind="storage")
			  //Check if field is apart of view
			$vl_idx2:=UTIL_Col_Find_Index (Form:C1466.view.detail.cols;"table";Form:C1466.fields[$vl_idx].table;"field";$vo_field.fieldNumber)
			  //if not, add to list of possible fields
			If ($vl_idx2=-1)
				$vb_add:=True:C214
			Else 
				$vb_add:=Not:C34(Form:C1466.view.detail.cols[$vl_idx2].selected)
			End if 
			
			If ($vb_add)
				Form:C1466.displayFields.push(OB Copy:C1225($vo_field))
			End if 
		End if 
	End for each 
End if 
