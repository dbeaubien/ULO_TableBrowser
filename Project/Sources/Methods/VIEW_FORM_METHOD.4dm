//%attributes = {}
C_OBJECT:C1216($1;$vo_formEvent;$vo_data;$vo_field)
C_COLLECTION:C1488($vc_cols)
C_TEXT:C284($vt_objectName)
C_LONGINT:C283($vl_dropPos;$vl_startPos;$vl_idx)
$vo_formEvent:=$1
If (OB Is defined:C1231($vo_formEvent;"objectName"))
	$vt_objectName:=$vo_formEvent.objectName
Else 
	$vt_objectName:="form"
End if 

Case of 
	: ($vt_objectName="form")
		
		Case of 
			: ($vo_formEvent.code=On Load:K2:1)
				VIEW_FORM_BUILD_DISPLAY_FIELD 
				VIEW_FORM_BUILD_DISPLAY_COL 
		End case 
		
	: ($vt_objectName="ViewFields")
		Case of 
			: ($vo_formEvent.code=On Double Clicked:K2:5)
				  //Display the property entry screen
				VIEW_FORM_EDIT_COL_DETAIL 
				
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				OBJECT SET ENABLED:C1123(*;"bt_deleteField";Form:C1466.selectedCol#Null:C1517)
				
			: ($vo_formEvent.code=On Begin Drag Over:K2:44)
				SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217(Form:C1466.selectedCol))
			: ($vo_formEvent.code=On Drag Over:K2:13)
				
			: ($vo_formEvent.code=On Drop:K2:12)
				$vl_dropPos:=Drop position:C608-1
				$vo_data:=JSON Parse:C1218(Get text from pasteboard:C524)
				$vl_startPos:=Form:C1466.displayCols.findIndex("UTIL_Find_Collection";"table";$vo_data.table;"field";$vo_data.field)
				
				If ($vl_startPos#$vl_dropPos)
					Form:C1466.displayCols.remove($vl_startPos)
					If ($vl_dropPos=-2)
						Form:C1466.displayCols.push($vo_data)
					Else 
						Form:C1466.displayCols.insert($vl_dropPos;$vo_data)
					End if 
					  //save new sort order to Form.view.detail.cols
					  //Get displayed cols to preserve column order
					$vc_cols:=Form:C1466.displayCols.copy()
					
					  //Add unselected cols 
					For each ($vo_field;Form:C1466.view.detail.cols)
						If ($vc_cols.findIndex("UTIL_Find_Collection";"table";$vo_field.table;"field";$vo_field.field)=-1)
							$vc_cols.push(OB Copy:C1225($vo_field))
						End if 
					End for each 
					
					Form:C1466.view.detail.cols:=$vc_cols
					
				End if 
		End case 
		
	: ($vt_objectName="View_UseFooter")
		Case of 
			: ($vo_formEvent.code=On Load:K2:1)
				Form:C1466.useFooters:=Num:C11(Form:C1466.view.detail.useFooter)
			: ($vo_formEvent.code=On Clicked:K2:4)
				Form:C1466.view.detail.useFooter:=(Form:C1466.useFooters=1)
		End case 
		
		
	: ($vt_objectName="dropdown_table")
		
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4) | ($vo_formEvent.code=On Data Change:K2:15)
				VIEW_FORM_BUILD_DISPLAY_FIELD 
				
		End case 
		
	: ($vt_objectName="bt_moveField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				VIEW_FORM_MOVE_SELECTED_FIELD 
				
		End case 
		
	: ($vt_objectName="bt_deleteField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				  //deselect the highlighted col
				$vl_idx:=Form:C1466.view.detail.cols.findIndex("UTIL_Find_Collection";"table";Form:C1466.selectedCol.table;"field";Form:C1466.selectedCol.field)
				If ($vl_idx>=0)
					Form:C1466.view.detail.cols[$vl_idx].selected:=False:C215
					VIEW_FORM_BUILD_DISPLAY_COL 
					If (Form:C1466.selectedCol.table=al_tableNum{at_tableName})
						VIEW_FORM_BUILD_DISPLAY_FIELD 
					End if 
				End if 
				
		End case 
		
	: ($vt_objectName="bt_addField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				  //Popup for adding custom formulas?
				
		End case 
		
	: ($vt_objectName="ViewFieldsSource")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				OBJECT SET ENABLED:C1123(*;"bt_moveField";Form:C1466.selectedField#Null:C1517)
				
			: ($vo_formEvent.code=On Double Clicked:K2:5)
				VIEW_FORM_MOVE_SELECTED_FIELD 
				
		End case 
		
End case 