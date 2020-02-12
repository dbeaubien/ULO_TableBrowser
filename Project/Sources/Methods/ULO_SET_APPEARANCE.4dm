//%attributes = {"shared":true,"preemptive":"capable"}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 11/02/20, 10:32:31
  // ----------------------------------------------------
  // Method: ULO_SET_APPEARANCE
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_VARIANT:C1683(${1})
C_LONGINT:C283($cp)
$cp:=Count parameters:C259

If ($cp=4)
	Use (Storage:C1525.appearance)
		Storage:C1525.appearance.formBGColour:=$1
		Storage:C1525.appearance.listFontColour:=$2
		Storage:C1525.appearance.listBackgroundColour:=$3
		Storage:C1525.appearance.listBackgroundColourAlt:=$4
	End use 
End if 
