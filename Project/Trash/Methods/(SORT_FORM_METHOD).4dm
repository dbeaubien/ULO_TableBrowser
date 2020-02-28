//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 14/02/20, 11:03:25
  // ----------------------------------------------------
  // Method: SORT_FORM_METHOD
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($1;$vo_formEvent;$vo_data;$vo_field;$vo_col)
C_COLLECTION:C1488($vc_cols)
C_TEXT:C284($vt_objectName)
C_LONGINT:C283($vl_dropPos;$vl_startPos;$vl_idx;$vl_row;$vl_col)

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
				OBJECT SET ENABLED:C1123(*;"bt_deleteSort";Form:C1466.allowDelete)
				OBJECT SET ENABLED:C1123(*;"bt_addField";False:C215)
				Form:C1466.fieldFilter:=""
				
				ULO_SET_BACKGROUND 
				ULO_SET_LIST_COLOURS ("lb_viewFields")
				ULO_SET_LIST_COLOURS ("lb_sortData")
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.sort.detail.sortData)
				OBJECT SET ENABLED:C1123(*;"bt_moveField";Form:C1466.selectedField#Null:C1517)
				
		End case 
		
	: ($vt_objectName="lb_sortData")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				OBJECT SET ENABLED:C1123(*;"bt_deleteField";Form:C1466.selectedSort#Null:C1517)
				
				LISTBOX GET CELL POSITION:C971(*;"lb_sortData";$vl_col;$vl_row)
				If ($vl_col=2)
					If (Form:C1466.selectedSort#Null:C1517)
						Form:C1466.selectedSort.sortDir:=Choose:C955(Form:C1466.selectedSort.sortDir="ASC";"DES";"ASC")
					End if 
				End if 
				
			: ($vo_formEvent.code=On Begin Drag Over:K2:44)
				SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217(Form:C1466.selectedSort))
				
			: ($vo_formEvent.code=On Drop:K2:12)
				$vl_dropPos:=Drop position:C608-1
				$vo_data:=JSON Parse:C1218(Get text from pasteboard:C524)
				$vl_startPos:=UTIL_Col_Find_Index (Form:C1466.sort.detail.sortData;"table";$vo_data.table;"field";$vo_data.field)
				
				If ($vl_startPos#$vl_dropPos)
					Form:C1466.sort.detail.sortData.remove($vl_startPos)
					If ($vl_dropPos=-2)
						Form:C1466.sort.detail.sortData.push($vo_data)
					Else 
						Form:C1466.sort.detail.sortData.insert($vl_dropPos;$vo_data)
					End if 
				End if 
		End case 
		
	: ($vt_objectName="bt_deleteSort")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				CONFIRM:C162("Are you sure you wish to delete the Sort "+Form:C1466.sort.name+"?")
				If (OK=1)
					Form:C1466.delete:=True:C214
					CANCEL:C270
				End if 
				
		End case 
		
		
	: ($vt_objectName="bt_deleteField")
		  //deselect the highlighted col
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.sort.detail.sortData;"table";Form:C1466.selectedSort.table;"field";Form:C1466.selectedSort.field)
		If ($vl_idx>=0)
			If (Form:C1466.selectedSort.table>0)
				Form:C1466.sort.detail.sortData.remove($vl_idx)
				Form:C1466.sort.detail.sortData:=Form:C1466.sort.detail.sortData
				If (Form:C1466.selectedSort.table=al_tableNum{at_tableName})
					VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.sort.detail.sortData)
				End if 
			End if 
		End if 
		
	: ($vt_objectName="bt_moveField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				SORT_FORM_MOVE_SELECTED_FIELD (Form:C1466.sort.detail.sortData)
				
		End case 
		
	: ($vt_objectName="dropdown_table")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4) | ($vo_formEvent.code=On Data Change:K2:15)
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.sort.detail.sortData)
				
		End case 
		
	: ($vt_objectName="lb_viewFields")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				OBJECT SET ENABLED:C1123(*;"bt_moveField";Form:C1466.selectedField#Null:C1517)
				
			: ($vo_formEvent.code=On Double Clicked:K2:5)
				If (Form:C1466.selectedField#Null:C1517)
					SORT_FORM_MOVE_SELECTED_FIELD (Form:C1466.sort.detail.sortData)
				End if 
		End case 
		
	: ($vt_objectName="txt_fieldFilter")
		
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.sort.detail.sortData)
				
		End case 
End case 



