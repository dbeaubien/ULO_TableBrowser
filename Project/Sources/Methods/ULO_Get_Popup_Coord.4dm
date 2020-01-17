//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 15/01/20, 12:29:27
  // ----------------------------------------------------
  // Method: ULO_Get_Popup_Coord
  // Description
  // Returns object containing x and y pos of Popup menu 
  // for a given button name
  // Parameters
  // $0 - Object - "x" and "y" coords
  // $1 - String - Name of object to create popup menu against
  // ----------------------------------------------------

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_LONGINT:C283($vl_l;$vl_t;$vl_r;$vl_b)

OBJECT GET COORDINATES:C663(*;$1;$vl_l;$vl_t;$vl_r;$vl_b)

$0:=New object:C1471("x";$vl_l;"y";$vl_t+60)
