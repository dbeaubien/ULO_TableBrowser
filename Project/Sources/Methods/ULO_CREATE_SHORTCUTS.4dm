//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/03/20, 09:29:57
  // ----------------------------------------------------
  // Method: ULO_CREATE_SHORTCUTS
  // Description
  // Creates / Updates shortcut buttons for the current table
  //
  // Parameters
  // ----------------------------------------------------

C_COLLECTION:C1488($vc_hostOptions)
C_OBJECT:C1216($vo_button;$vo_shortcut;$vo_hostOption)
C_LONGINT:C283($vl_idx)
C_TEXT:C284($vt_newName)

  //Clear the function on existing shortcuts
For each ($vo_shortcut;Form:C1466.shortcuts)
	$vo_shortcut.function:=""
End for each 

For each ($vo_button;Storage:C1525.buttons)
	$vc_hostOptions:=New collection:C1472
	
	If ($vo_button.method#"")
		EXECUTE METHOD:C1007($vo_button.method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //Return a collection
		
		For each ($vo_hostOption;$vc_hostOptions)
			  //Look for an existing button with this shortcut
			$vl_idx:=UTIL_Col_Find_Index (Form:C1466.shortcuts;"shortcut";$vo_hostOption.shortcut;"modifier";$vo_hostOption.modifier)
			If ($vl_idx=-1)
				$vt_newName:="ULO_Shortcut_"+String:C10(Form:C1466.shortcuts.length+1)
				OBJECT DUPLICATE:C1111(*;"ULO_Shortcut";$vt_newName)
				OBJECT SET SHORTCUT:C1185(*;$vt_newName;$vo_hostOption.shortcut;$vo_hostOption.modifier)
				
				$vo_shortcut:=OB Copy:C1225($vo_hostOption)
				$vo_shortcut.name:=$vt_newName
				Form:C1466.shortcuts.push(OB Copy:C1225($vo_shortcut))
				$vl_idx:=Form:C1466.shortcuts.length-1
			End if 
			
			Form:C1466.shortcuts[$vl_idx].method:=$vo_button.method
			Form:C1466.shortcuts[$vl_idx].function:=$vo_hostOption.function
			
			
		End for each 
		
	End if 
End for each 


