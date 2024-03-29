//%attributes = {}
C_OBJECT:C1216($1;$vo_formEvent;$vo_data;$vo_field;$vo_col;$vo_column;$es_userThemes;\
$e_userTheme;$e_userSort;$es_userSorts)
C_COLLECTION:C1488($vc_cols)
C_TEXT:C284($vt_objectName;$vt_menu;$vt_selected)
C_LONGINT:C283($vl_dropPos;$vl_startPos;$vl_idx;$vl_pos)
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
				Form:C1466.fieldFilter:=""
				OBJECT SET ENABLED:C1123(*;"bt_deleteView";Form:C1466.allowDelete)
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.view.detail.cols)
				VIEW_FORM_BUILD_DISPLAY_COL 
				ULO_SET_BACKGROUND 
				ULO_SET_LIST_COLOURS ("lb_viewFields")
				ULO_SET_LIST_COLOURS ("lb_viewCols")
				
				Form:C1466.themeMenu:=Create menu:C408
				APPEND MENU ITEM:C411(Form:C1466.themeMenu;"Default")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.themeMenu;-1;"Default:")
				
				$es_userThemes:=ds:C1482["uloData"].query("type == 3 && user == :1";Storage:C1525.user.id)
				If ($es_userThemes.length>0)
					APPEND MENU ITEM:C411(Form:C1466.themeMenu;"-")
					
					For each ($e_userTheme;$es_userThemes)
						APPEND MENU ITEM:C411(Form:C1466.themeMenu;$e_userTheme.name)
						SET MENU ITEM PARAMETER:C1004(Form:C1466.themeMenu;-1;$e_userTheme.name+":"+$e_userTheme.id)
					End for each 
				End if 
				
				Form:C1466.sortMenu:=Create menu:C408
				APPEND MENU ITEM:C411(Form:C1466.sortMenu;"Default")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.sortMenu;-1;"Default:")
				
				$es_userSorts:=ds:C1482["uloData"].query("type == 13 && user == :1 && table == :2";Storage:C1525.user.id;Form:C1466.view.table)
				If ($es_userSorts.length>0)
					APPEND MENU ITEM:C411(Form:C1466.sortMenu;"-")
					
					For each ($e_userSort;$es_userSorts)
						APPEND MENU ITEM:C411(Form:C1466.sortMenu;$e_userSort.name)
						SET MENU ITEM PARAMETER:C1004(Form:C1466.sortMenu;-1;$e_userSort.name+":"+$e_userSort.id)
					End for each 
				End if 
				
			: ($vo_formEvent.code=On Timer:K2:25)
				SET TIMER:C645(0)
				VIEW_FORM_EDIT_COL_DETAIL (True:C214)
				
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
				$vl_startPos:=UTIL_Col_Find_Index (Form:C1466.displayCols;"table";$vo_data.table;"field";$vo_data.field)
				
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
						If (UTIL_Col_Find_Index ($vc_cols;"table";$vo_field.table;"field";$vo_field.field)=-1)
							$vc_cols.push(OB Copy:C1225($vo_field))
						End if 
					End for each 
					
					Form:C1466.view.detail.cols:=$vc_cols
					
				End if 
				
		End case 
		
		
		
		
	: ($vt_objectName="dropdown_table")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4) | ($vo_formEvent.code=On Data Change:K2:15)
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.view.detail.cols)
				
		End case 
		
	: ($vt_objectName="bt_moveField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				VIEW_FORM_MOVE_SELECTED_FIELD 
				
		End case 
		
	: ($vt_objectName="bt_deleteView")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				CONFIRM:C162("Are you sure you wish to delete the View "+Form:C1466.view.name+"?")
				If (OK=1)
					Form:C1466.delete:=True:C214
					CANCEL:C270
				End if 
				
		End case 
		
	: ($vt_objectName="bt_deleteField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				  //deselect the highlighted col
				$vl_idx:=UTIL_Col_Find_Index (Form:C1466.view.detail.cols;"table";Form:C1466.selectedCol.table;"field";Form:C1466.selectedCol.field)
				If ($vl_idx>=0)
					If (Form:C1466.selectedCol.table>0)
						Form:C1466.view.detail.cols[$vl_idx].selected:=False:C215
						VIEW_FORM_BUILD_DISPLAY_COL 
						If (Form:C1466.selectedCol.table=al_tableNum{at_tableName})
							VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.view.detail.cols)
						End if 
					Else 
						CONFIRM:C162("Are you sure you wish to delete the Column "+Form:C1466.selectedCol.header+"?")
						
						If (OK=1)
							Form:C1466.displayCols.remove(Form:C1466.selectedColIndex-1)
							Form:C1466.displayCols:=Form:C1466.displayCols
							Form:C1466.view.detail.cols.remove($vl_idx)
						End if 
					End if 
				End if 
				
		End case 
		
	: ($vt_objectName="bt_addField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				  //Popup for adding custom formulas?
				
				If (Form:C1466.customColumns.length>0)
					
					$vt_menu:=Create menu:C408
					
					APPEND MENU ITEM:C411($vt_menu;"Custom Formula")
					SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"Custom Formula")
					
					APPEND MENU ITEM:C411($vt_menu;"-")
					DISABLE MENU ITEM:C150($vt_menu;-1)
					
					For each ($vo_column;Form:C1466.customColumns)
						APPEND MENU ITEM:C411($vt_menu;$vo_column.name)
						SET MENU ITEM PARAMETER:C1004($vt_menu;-1;$vo_column.name)
					End for each 
					
					$vt_selected:=Dynamic pop up menu:C1006($vt_menu)
					
					RELEASE MENU:C978($vt_menu)
					
				Else 
					$vt_selected:="Custom Formula"
				End if 
				
				If ($vt_selected#"")
					  //temp, add new empty formula
					$vo_col:=New object:C1471
					$vo_col.selected:=True:C214
					$vo_col.table:=-1
					$vo_col.fontColourOverride:=False:C215
					If (Form:C1466.view.detail.cols.query("table == -1").length=0)
						$vo_col.field:=1
					Else 
						$vo_col.field:=Form:C1466.view.detail.cols.query("table == -1").max("field")+1
					End if 
					$vo_col.fontStyle:=0
					$vo_col.fontColour:=0x0000  //Black
					$vo_col.fontColourHex:="000000"
					$vo_col.alignment:="Left"
					$vo_col.total:=False:C215
					$vo_col.min:=False:C215
					$vo_col.max:=False:C215
					$vo_col.average:=False:C215
					$vo_col.width:=100
					
					If ($vt_selected="Custom Formula")
						$vo_col.fieldName:="Custom Formula"
						$vo_col.header:="New Column"
						$vo_col.formula:=""
						$vo_col.relation:=""
						$vo_col.fieldType:=Is alpha field:K8:1
						$vo_col.format:=""
						
					Else 
						$vl_idx:=UTIL_Col_Find_Index (Form:C1466.customColumns;"name";$vt_selected)
						If ($vl_idx>=0)
							
							$vo_col.fieldName:=Form:C1466.customColumns[$vl_idx].name
							$vo_col.header:=Form:C1466.customColumns[$vl_idx].header
							$vo_col.formula:=Form:C1466.customColumns[$vl_idx].formula
							$vo_col.method:=Form:C1466.customColumns[$vl_idx].method
							$vo_col.sortFormula:=Form:C1466.customColumns[$vl_idx].sortFormula
							$vo_col.footerFormula:=Form:C1466.customColumns[$vl_idx].footerFormula
							$vo_col.fieldType:=Form:C1466.customColumns[$vl_idx].dataType
							$vo_col.format:=Form:C1466.customColumns[$vl_idx].format
							$vo_col.aggregates:=OB Copy:C1225(Form:C1466.customColumns[$vl_idx].aggregates)
						End if 
					End if 
					
					Form:C1466.view.detail.cols.push(OB Copy:C1225($vo_col))
					Form:C1466.displayCols.push(OB Copy:C1225($vo_col))
					LISTBOX SELECT ROW:C912(*;"lb_viewCols";Form:C1466.displayCols.length;lk replace selection:K53:1)
					SET TIMER:C645(-1)
					
				End if 
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
		
	: ($vt_objectName="ULO_VIEW_Name")
		
		Case of 
			: ($vo_formEvent.code=On Getting Focus:K2:7)
				Form:C1466.backupName:=Form:C1466.view.name
				
			: ($vo_formEvent.code=On Data Change:K2:15)
				If (Form:C1466.view.name="")
					Form:C1466.view.name:=Form:C1466.backupName
				End if 
		End case 
		
	: ($vt_objectName="txt_fieldFilter")
		
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.view.detail.cols)
				
		End case 
		
	: ($vt_objectName="bt_selectTheme")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$vt_selected:=Dynamic pop up menu:C1006(Form:C1466.themeMenu)
				If ($vt_selected#"")
					If ($vt_selected="Default:")
						Form:C1466.view.detail.themeName:="Default"
						Form:C1466.view.detail.themeId:=""
					Else 
						$vl_pos:=Position:C15(":";$vt_selected)
						Form:C1466.view.detail.themeName:=Substring:C12($vt_selected;1;$vl_pos-1)
						Form:C1466.view.detail.themeId:=Substring:C12($vt_selected;$vl_pos+1)
					End if 
				End if 
		End case 
		
	: ($vt_objectName="bt_selectSort")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$vt_selected:=Dynamic pop up menu:C1006(Form:C1466.sortMenu)
				If ($vt_selected#"")
					If ($vt_selected="Default:")
						Form:C1466.view.detail.sortName:="Default"
						Form:C1466.view.detail.sortId:=""
					Else 
						$vl_pos:=Position:C15(":";$vt_selected)
						Form:C1466.view.detail.sortName:=Substring:C12($vt_selected;1;$vl_pos-1)
						Form:C1466.view.detail.sortId:=Substring:C12($vt_selected;$vl_pos+1)
					End if 
				End if 
		End case 
		
End case 