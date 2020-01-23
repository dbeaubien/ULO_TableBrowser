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
	
	$vc_fields:=ULO_Get_Table_Fields (Table name:C256(Form:C1466.tableNumber))
	For each ($vo_field;$vc_fields)
		If ($vo_field.kind="relatedEntities")
			$vl_count:=Form:C1466.uloList[$vo_field.fieldName].length
			APPEND MENU ITEM:C411($vt_menu;$vo_field.relatedDataClass+" ["+String:C10($vl_count)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;$vo_field.fieldName)
		End if 
	End for each 
	
	$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_RELATE")
	
	$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
	If ($vt_selected#"")
		BUTTON_SEARCH_POP ($vt_selected)
	End if 
	
	
Else 
	  //swap selected table!
	
	
End if 
