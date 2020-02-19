//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 17/02/20, 09:57:26
  // ----------------------------------------------------
  // Method: SORT_MANAGE_FORM_METHOD
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($1;$vo_formEvent;$vo_data;$vo_field;$vo_col;$e_uloData;\
$vo_coord)
C_COLLECTION:C1488($vc_cols)
C_TEXT:C284($vt_objectName;$vt_menu;$vt_selected)
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
				SORT_MANAGE_SET_ENABLED 
				
				ULO_SET_BACKGROUND 
				ULO_SET_LIST_COLOURS ("lb_viewFields")
				ULO_SET_LIST_COLOURS ("lb_sortData")
				ULO_SET_LIST_COLOURS ("lb_sort")
				
			: ($vo_formEvent.code=On Timer:K2:25)
				SET TIMER:C645(0)
				LISTBOX SELECT ROW:C912(*;"lb_sort";0;lk replace selection:K53:1)
				
		End case 
		
	: ($vt_objectName="lb_sortData")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				SORT_MANAGE_SET_ENABLED 
				If (Form:C1466.sortTab="user")
					LISTBOX GET CELL POSITION:C971(*;"lb_sortData";$vl_col;$vl_row)
					If ($vl_col=2)
						If (Form:C1466.selectedSortCol#Null:C1517)
							Form:C1466.selectedSortCol.sortDir:=Choose:C955(Form:C1466.selectedSortCol.sortDir="ASC";"DES";"ASC")
						End if 
					End if 
				End if 
			: ($vo_formEvent.code=On Begin Drag Over:K2:44)
				SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217(Form:C1466.selectedSortCol))
				
			: ($vo_formEvent.code=On Drop:K2:12)
				$vl_dropPos:=Drop position:C608-1
				$vo_data:=JSON Parse:C1218(Get text from pasteboard:C524)
				$vl_startPos:=UTIL_Col_Find_Index (Form:C1466.workingSort.detail.sortData;"table";$vo_data.table;"field";$vo_data.field)
				
				If ($vl_startPos#$vl_dropPos)
					Form:C1466.workingSort.detail.sortData.remove($vl_startPos)
					If ($vl_dropPos=-2)
						Form:C1466.workingSort.detail.sortData.push($vo_data)
					Else 
						Form:C1466.workingSort.detail.sortData.insert($vl_dropPos;$vo_data)
					End if 
				End if 
		End case 
		
	: ($vt_objectName="bt_deleteSort")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				CONFIRM:C162("Are you sure you wish to delete the Sort "+Form:C1466.workingSort.name+"?")
				If (OK=1)
					Form:C1466.workingSort.drop()
					
				End if 
				
		End case 
		
	: ($vt_objectName="bt_addSort")
		
		$vt_menu:=Create menu:C408
		APPEND MENU ITEM:C411($vt_menu;"New Sort")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"NEW")
		
		APPEND MENU ITEM:C411($vt_menu;"Duplicate Selected")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"DUPE")
		If (Form:C1466.selectedSort=Null:C1517)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		
		$vo_coord:=ULO_Get_Popup_Coord ("bt_addSort")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y-40)
		
		If ($vt_selected="NEW") | ($vt_selected="DUPE")
			
			If (Form:C1466.workingSort#Null:C1517) & (Form:C1466.sortTab="user")
				Form:C1466.workingSort.save()
			End if 
			
			$e_uloData:=ds:C1482["uloData"].new()
			$e_uloData.detail:=New object:C1471
			$e_uloData.type:=13
			$e_uloData.name:="New Sort for "+Form:C1466.helpfulData.tableHandle
			$e_uloData.handle:=Form:C1466.helpfulData.tableHandle
			$e_uloData.user:=Storage:C1525.user.id
			$e_uloData.table:=Form:C1466.helpfulData.tableNumber
			If ($vt_selected="NEW")
				$e_uloData.detail.sortData:=New collection:C1472
			Else 
				$e_uloData.detail:=OB Copy:C1225(Form:C1466.workingSort.detail)
			End if 
			$e_uloData.save()
			Form:C1466.userSorts.add($e_uloData)
			
			Form:C1466.displaySort:=Form:C1466.userSorts
			SET TIMER:C645(-1)
		End if 
		
		
		
	: ($vt_objectName="bt_deleteField")
		  //deselect the highlighted col
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.workingSort.detail.sortData;"table";Form:C1466.selectedSortCol.table;"field";Form:C1466.selectedSortCol.field)
		If ($vl_idx>=0)
			If (Form:C1466.selectedSortCol.table>0)
				Form:C1466.workingSort.detail.sortData.remove($vl_idx)
				Form:C1466.workingSort.detail.sortData:=Form:C1466.workingSort.detail.sortData
				If (Form:C1466.selectedSortCol.table=al_tableNum{at_tableName})
					VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.workingSort.detail.sortData)
				End if 
			End if 
		End if 
		
	: ($vt_objectName="bt_moveField")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				SORT_FORM_MOVE_SELECTED_FIELD (Form:C1466.workingSort.detail.sortData)
				
		End case 
		
		
	: ($vt_objectName="dropdown_table")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4) | ($vo_formEvent.code=On Data Change:K2:15)
				VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.workingSort.detail.sortData)
				
		End case 
		
	: ($vt_objectName="lb_viewFields")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				SORT_MANAGE_SET_ENABLED 
				
			: ($vo_formEvent.code=On Double Clicked:K2:5)
				If (Form:C1466.sortTab="user")
					If (Form:C1466.selectedField#Null:C1517)
						SORT_FORM_MOVE_SELECTED_FIELD (Form:C1466.workingSort.detail.sortData)
					End if 
				End if 
		End case 
		
		
	: ($vt_objectName="tab_sortSelect")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				If (Form:C1466.workingSort#Null:C1517) & (Form:C1466.sortTab="user")
					Form:C1466.workingSort.save()
				End if 
				
				If (at_sortTab=1)
					Form:C1466.sortTab:="user"
					Form:C1466.displaySort:=Form:C1466.userSorts
				Else 
					Form:C1466.sortTab:="system"
					Form:C1466.displaySort:=Form:C1466.systemSorts
				End if 
				
				LISTBOX SELECT ROW:C912(*;"lb_sort";0;lk remove from selection:K53:3)  //deselect all rows
				
				SORT_MANAGE_SET_ENABLED 
		End case 
		
	: ($vt_objectName="lb_sort")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				If (Form:C1466.workingSort#Null:C1517) & (Form:C1466.sortTab="user")
					Form:C1466.workingSort.save()
				End if 
				
				If (Form:C1466.selectedSort#Null:C1517)
					Form:C1466.workingSort:=Form:C1466.selectedSort
					Form:C1466.workingIndex:=Form:C1466.selectedSortIndex
					
					VIEW_FORM_BUILD_DISPLAY_FIELD (Form:C1466.workingSort.detail.sortData)
				Else 
					Form:C1466.displayFields:=New collection:C1472
					Form:C1466.workingSort:=Null:C1517
					Form:C1466.workingIndex:=0
					
				End if 
				SORT_MANAGE_SET_ENABLED 
		End case 
		
	: ($vt_objectName="bt_OK")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				If (Form:C1466.sortTab="user")
					Form:C1466.workingSort.save()
				End if 
				
				ACCEPT:C269
		End case 
		
		
	: ($vt_objectName="txt_sortName")
		Case of 
			: ($vo_formEvent.code=On Getting Focus:K2:7)
				Form:C1466.backupName:=Form:C1466.workingSort.name
				
			: ($vo_formEvent.code=On Data Change:K2:15)
				If (Form:C1466.workingSort.name="")
					Form:C1466.workingSort.name:=Form:C1466.backupName
				End if 
		End case 
		
		
		
End case 