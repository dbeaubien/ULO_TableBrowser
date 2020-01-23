//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 23/01/20, 16:41:31
  // ----------------------------------------------------
  // Method: BUTTON_RELATE_POP
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_menu;$vt_selected)
C_LONGINT:C283($vl_CurrentUser;$cp;$vl_menuNum;$index)
C_OBJECT:C1216($vo_view;$vo_option;$vo_coord)
C_COLLECTION:C1488($vc_hostOptions)
C_POINTER:C301($vp_table)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259

If ($cp=0)
	
	$vt_menu:=Create menu:C408
	
	$vc_fields:=ULO_Get_Table_Fields (Table name:C256(Form:C1466.tableNumber))  //TODO: Validate the view is accessible by navBar / user permissions
	For each ($vo_field;$vc_fields)
		If ($vo_field.kind="relatedEntities")
			$vl_count:=Form:C1466.uloList[$vo_field.fieldName].length
			APPEND MENU ITEM:C411($vt_menu;$vo_field.relatedDataClass+" ["+String:C10($vl_count)+"]")
			$vl_idx:=Form:C1466.navItems.findIndex("UTIL_Find_Collection";"handle";$vo_field.relatedDataClass)  //This needs changing
			If ($vl_idx>=0)
				SET MENU ITEM PARAMETER:C1004($vt_menu;-1;JSON Stringify:C1217(New object:C1471("relation";$vo_field.fieldName;"table";Form:C1466.navItems[$vl_idx].table)))
			Else 
				  //Can't find nav item for this table number
				TRACE:C157
			End if 
		End if 
	End for each 
	
	$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_RELATE")
	$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
	If ($vt_selected#"")
		BUTTON_RELATE_POP ($vt_selected)
	End if 
	
Else 
	  //swap selected table!
	$vo_param:=JSON Parse:C1218($1)
	
	Form:C1466.uloList:=Form:C1466.uloList[$vo_param.relation]
	Form:C1466.tableNumber:=$vo_param.table
	$vl_idx:=Form:C1466.navItems.findIndex("UTIL_Find_Collection";"table";$vo_param.table;"type";"DATA")
	If ($vl_idx>=0)
		Form:C1466.fullRefresh:=True:C214
		LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$vl_idx+1;lk replace selection:K53:1)
		SET TIMER:C645(-1)
	Else 
		TRACE:C157
		  //Can't find nav item with selected relation table number
	End if 
End if 
