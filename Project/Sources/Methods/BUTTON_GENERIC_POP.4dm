//%attributes = {"invisible":true,"shared":true}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 24/02/20, 10:45:14
  // ----------------------------------------------------
  // Method: BUTTON_GENERIC_POP
  // Description
  //Manages all of the popup actions for a row contextual click
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_menu;$vt_selected;$vt_shortcut;$vt_method;$vt_eventObject)
C_LONGINT:C283($cp;$vl_menuNum;$index;$vl_modifier;$vl_buttonNumber)
C_POINTER:C301($vp_table)
C_OBJECT:C1216($vo_option;$vo_coord)
C_COLLECTION:C1488($vc_hostOptions)
$vt_eventObject:=$1
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259
$vc_hostOptions:=New collection:C1472

If ($cp>0)  //True passed as second parameter
	$vl_buttonNumber:=UTIL_Col_Find_Index (Form:C1466.buttons;"reference";$vt_eventObject)
	If ($vl_buttonNumber#-1)
		$vt_method:=Form:C1466.buttons[$vl_buttonNumber].method
	End if 
	$vt_menu:=Create menu:C408
	If ($vt_method#"")
		EXECUTE METHOD:C1007($vt_method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //Return a collection
	End if 
	If ($vc_hostOptions.length>0)
		$vt_menu:=UTIL_Parse_Host_Menu_Options ($vt_menu;$vc_hostOptions)
	End if 
	$vt_selected:=Dynamic pop up menu:C1006($vt_menu)
	If ($vt_selected#"")  //If there is a host search method specified
		EXECUTE METHOD:C1007($vt_method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle;$vt_selected)  //Runs the action
	End if 
	
End if 

