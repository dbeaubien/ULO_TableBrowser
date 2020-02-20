//%attributes = {"invisible":true,"preemptive":"incapable"}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 19/02/20, 17:01:21
  // ----------------------------------------------------
  // Method: ULO_LOAD_SHORTCUTS
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($vo_shortcut)

For each ($vo_shortcut;Storage:C1525.shortcuts)
	OBJECT DUPLICATE:C1111(*;"ULO_Shortcut";$vo_shortcut.name)
	OBJECT SET SHORTCUT:C1185(*;$vo_shortcut.name;Lowercase:C14($vo_shortcut.key);$vo_shortcut.modifier)
End for each 

