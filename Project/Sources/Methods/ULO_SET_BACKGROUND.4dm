//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 11/02/20, 09:26:06
  // ----------------------------------------------------
  // Method: ULO_SET_BACKGROUND
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

  // DECLARE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
C_BOOLEAN:C305($1;$vb_hideBackground)
C_LONGINT:C283($cp)
C_VARIANT:C1683($vv_backgroundColour)

$cp:=Count parameters:C259
If ($cp>0)
	$vb_hideBackground:=$1
End if 
  //INIT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$vv_backgroundColour:=Storage:C1525.appearance.formBGColour  //0x00EDEDED - Default unless set

  //METHOD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If (Not:C34($vb_hideBackground))
	OBJECT SET VISIBLE:C603(*;"BackgroundColour@";True:C214)
	OBJECT SET RGB COLORS:C628(*;"BackgroundColour";$vv_backgroundColour;$vv_backgroundColour)
End if 