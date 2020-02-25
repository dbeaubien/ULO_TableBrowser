//%attributes = {"invisible":true}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 24/02/20, 10:45:14
  // ----------------------------------------------------
  // Method: CONTEXT_CLICK_POP
  // Description
  //Manages all of the popup actions for a row contextual click
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_menu;$vt_selected;$vt_shortcut;$vt_method)
C_LONGINT:C283($cp;$vl_menuNum;$index;$vl_modifier)
C_POINTER:C301($vp_table)
C_OBJECT:C1216($vo_option;$vo_coord)
C_COLLECTION:C1488($vc_hostOptions)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259
$vc_hostOptions:=New collection:C1472
$vt_method:=Storage:C1525.hostMethods.rowContext

If ($cp=0)
	$vt_menu:=Create menu:C408
	
	If ($vt_method#"")
		EXECUTE METHOD:C1007($vt_method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //Return a collection
	End if 
	
	If ($vc_hostOptions.length>0)
		$vt_menu:=UTIL_Parse_Host_Menu_Options ($vt_menu;$vc_hostOptions)
	End if 
	
	$vt_selected:=Dynamic pop up menu:C1006($vt_menu)
	If ($vt_selected#"")
		CONTEXT_CLICK_POP ($vt_selected)
	End if 
	
Else 
	  //Must be a host option so call the host method
	If ($vt_method#"")  //If there is a host search method specified
		EXECUTE METHOD:C1007($vt_method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle;$1)  //Runs the action
		  //$vc_hostOptions - Should return an empty collection at this point.appearance
	End if 
	
End if 


