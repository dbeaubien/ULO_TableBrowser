//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/03/20, 10:49:56
  // ----------------------------------------------------
  // Method: ULO_DISABLE_BUTTON
  // Description
  // Disables the button with the given action
  // To be called during table load to restrict access to e.g. `new`
  // Parameters
  // $1 - String - Button action
  // ----------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($vl_idx)

$vl_idx:=UTIL_Col_Find_Index (Form:C1466.buttons;"action";$1)
If ($vl_idx>=0)
	OBJECT SET ENABLED:C1123(*;Form:C1466.buttons[$vl_idx].reference;False:C215)
End if 


