//%attributes = {"shared":true,"preemptive":"capable"}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 19/02/20, 16:55:44
  // ----------------------------------------------------
  // Method: ULO_SET_SHORTCUT
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1;$2)  //Name & shortcut key
C_LONGINT:C283($3)  //Modifier

If ($1="INIT")
	Use (Storage:C1525.shortcuts)
		Storage:C1525.shortcuts:=New shared collection:C1527
	End use 
Else 
	Use (Storage:C1525.shortcuts)
		Storage:C1525.shortcuts.push(New shared object:C1526("name";$1;"key";$2;"mask";$3))
	End use 
End if 