//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/03/20, 10:44:02
  // ----------------------------------------------------
  // Method: ULO_ENABLE_BUTTONS
  // Description
  // Sets given enable state for all Form.buttons, except show / omit subset
  //
  // Parameters
  // $1 - Boolean - Enabled state to set
  // ----------------------------------------------------

For each ($vo_button;Form:C1466.buttons)
	If ($vo_button.action#"SHOWSUBSET") & ($vo_button.action#"OMITSUBSET")
		OBJECT SET ENABLED:C1123(*;$vo_button.reference;True:C214)
	End if 
End for each 

