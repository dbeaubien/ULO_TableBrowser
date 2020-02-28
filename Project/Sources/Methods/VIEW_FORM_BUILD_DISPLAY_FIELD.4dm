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
  // $1 - Collection - Collection of `view` / `sort` fields for
  //                   omitting fields from listbox
  // ----------------------------------------------------
C_BOOLEAN:C305($vb_add)
C_LONGINT:C283($vl_idx;$vl_idx2)
C_OBJECT:C1216($vo_field)
C_COLLECTION:C1488($1;$vc_data;$vc_fields)

$vc_data:=$1

$vl_idx:=UTIL_Col_Find_Index (Form:C1466.fields;"table";al_tableNum{at_tableName})
If ($vl_idx>=0)
	Form:C1466.displayFields:=New collection:C1472
	If (Form:C1466.fieldFilter#"")
		$vc_fields:=Form:C1466.fields[$vl_idx].fields.query("name == :1";"@"+Form:C1466.fieldFilter+"@")
	Else 
		$vc_fields:=Form:C1466.fields[$vl_idx].fields
	End if 
	For each ($vo_field;$vc_fields)
		If ($vo_field.kind="storage")
			
			  //Check if field is apart of view
			$vl_idx2:=UTIL_Col_Find_Index ($vc_data;"table";Form:C1466.fields[$vl_idx].table;"field";Choose:C955($vo_field.fieldNumber=Null:C1517;$vo_field.field;$vo_field.fieldNumber))
			  //if not, add to list of possible fields
			If ($vl_idx2=-1)
				$vb_add:=True:C214
			Else 
				If (OB Is defined:C1231($vc_data[$vl_idx2];"selected"))
					$vb_add:=Not:C34($vc_data[$vl_idx2].selected)
				Else 
					$vb_add:=False:C215
				End if 
			End if 
			
			If ($vb_add)
				Form:C1466.displayFields.push(OB Copy:C1225($vo_field))
			End if 
		End if 
	End for each 
	Form:C1466.displayFields:=Form:C1466.displayFields.orderBy("name asc")
End if 
