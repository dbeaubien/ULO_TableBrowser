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
			: ($vo_formEvent.code=On Timer:K2:25)
				TRACE:C157
				SET TIMER:C645(0)
				VIEW_FORM_EDIT_COL_DETAIL 
				
				
		End case 
		
	: ($vt_objectName="lb_viewCols")
		Case of 
			: ($vo_formEvent.code=On Double Clicked:K2:5)
				  //Display the property entry screen
				If (Form:C1466.selectedCol#Null:C1517)
					VIEW_FORM_EDIT_COL_DETAIL 
				End if 
				
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
					If (Form:C1466.selectedCol.table>0)
						Form:C1466.view.detail.cols[$vl_idx].selected:=False:C215
						VIEW_FORM_BUILD_DISPLAY_COL 
						If (Form:C1466.selectedCol.table=al_tableNum{at_tableName})
							VIEW_FORM_BUILD_DISPLAY_FIELD 
						End if 
					Else 
						CONFIRM:C162("Are you sure you wish to delete the Column "+Form:C1466.selectedCol.header+"?")
						If (OK=1)
							Form:C1466.selectedCol.remove(Form:C1466.selectedColIndex)
							Form:C1466.view.detail.cols.remove($vl_idx)
						End if 
					End if 
				End if 
				
		End case 
		
	: ($vt_objectName="bt_addField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				  //Popup for adding custom formulas?
				
				  //temp, add new empty formula
				$vo_col:=New object:C1471
				$vo_col.selected:=True:C214
				$vo_col.table:=-1
				If (Form:C1466.view.detail.cols.query("table == -1").length=0)
					$vo_col.field:=1
				Else 
					$vo_col.field:=Form:C1466.view.detail.cols.query("table == -1").max("field")+1
				End if 
				$vo_col.fieldName:="Custom Formula"
				$vo_col.header:="New Column"
				$vo_col.formula:=""
				$vo_col.relation:=""
				$vo_col.width:=100
				$vo_col.fieldType:=Is alpha field:K8:1
				$vo_col.format:=""
				$vo_col.fontStyle:=0
				$vo_col.fontColour:=0x0000  //Black
				$vo_col.fontColourHex:="000000"
				$vo_col.alignment:="Left"
				$vo_col.total:=False:C215
				$vo_col.min:=False:C215
				$vo_col.max:=False:C215
				$vo_col.average:=False:C215
				TRACE:C157
				Form:C1466.view.detail.cols.push(OB Copy:C1225($vo_col))
				Form:C1466.displayCols.push(OB Copy:C1225($vo_col))
				LISTBOX SELECT ROW:C912(*;"lb_viewCols";Form:C1466.displayCols.length;lk replace selection:K53:1)
				SET TIMER:C645(-1)
		End case 
		
	: ($vt_objectName="lb_viewFields")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				OBJECT SET ENABLED:C1123(*;"bt_moveField";Form:C1466.selectedField#Null:C1517)
				
			: ($vo_formEvent.code=On Double Clicked:K2:5)
				If (Form:C1466.selectedField#Null:C1517)
					VIEW_FORM_MOVE_SELECTED_FIELD 
				End if 
		End case 
		
End case 