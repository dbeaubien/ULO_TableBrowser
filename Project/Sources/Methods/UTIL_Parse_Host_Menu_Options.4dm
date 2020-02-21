//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 21/02/20, 09:12:08
  // ----------------------------------------------------
  // Method: UTIL_Parse_Host_Menu_Options
  // Description
  // Parses collection of Host Menu Options into 
  // returned 4D menu
  //
  // Parameters
  // $0 - String     - Constructed Menu
  // $1 - String     - Menu to build on
  // $2 - Collection - Host Options
  // ----------------------------------------------------

C_TEXT:C284($0;$1;$vt_menu)
C_COLLECTION:C1488($2;$vc_hostOptions)

C_TEXT:C284($vt_subMenu)
C_COLLECTION:C1488($vc_children)
C_OBJECT:C1216($vo_child;$vo_option)

$vt_menu:=$1
$vc_hostOptions:=$2

For each ($vo_option;$vc_hostOptions)
	$vc_children:=$vc_hostOptions.query("parent == :1";$vo_option.function)
	If ($vc_children.length>0)
		$vt_subMenu:=Create menu:C408
		
		For each ($vo_child;$vc_children)
			APPEND MENU ITEM:C411($vt_subMenu;$vo_child.label)
			SET MENU ITEM PARAMETER:C1004($vt_subMenu;-1;$vo_child.function)
			If (OB Is defined:C1231($vo_child;"shortcut")) & (OB Is defined:C1231($vo_child;"modifier"))
				SET MENU ITEM SHORTCUT:C423($vt_subMenu;-1;$vo_child.shortcut;$vo_child.modifier)
			End if 
			If (OB Is defined:C1231($vo_child;"enabled"))
				If (Not:C34($vo_child.enabled))
					DISABLE MENU ITEM:C150($vt_subMenu;-1)
				End if 
			End if 
		End for each 
		
		APPEND MENU ITEM:C411($vt_menu;$vo_option.label;$vt_subMenu)
		If (OB Is defined:C1231($vo_option;"enabled"))
			If (Not:C34($vo_option.enabled))
				DISABLE MENU ITEM:C150($vt_menu;-1)
			End if 
		End if 
		RELEASE MENU:C978($vt_subMenu)
	Else 
		If (Not:C34(OB Is defined:C1231($vo_option;"parent")))
			APPEND MENU ITEM:C411($vt_menu;$vo_option.label)
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;$vo_option.function)
			If (OB Is defined:C1231($vo_option;"shortcut")) & (OB Is defined:C1231($vo_option;"modifier"))
				SET MENU ITEM SHORTCUT:C423($vt_menu;-1;$vo_option.shortcut;$vo_option.modifier)
			End if 
			If (OB Is defined:C1231($vo_option;"enabled"))
				If (Not:C34($vo_option.enabled))
					DISABLE MENU ITEM:C150($vt_menu;-1)
				End if 
			End if 
		End if 
	End if 
End for each 

$0:=$vt_menu