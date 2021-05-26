//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 26/05/21, 10:33:03
  // ----------------------------------------------------
  // Method: ULO_UPDATE_BUTTON_STATE
  // Description
  // Allows host method to enable/disable ulo toolbar buttons on the fly 
  // To be called via 'CALL FORM' with the relevant ULO Window reference
  // Parameters
  // $1 - Text - Button Suffix
  // $2 - Bool - Button state
  // ----------------------------------------------------

C_TEXT:C284($1)
C_BOOLEAN:C305($2)

OBJECT SET ENABLED:C1123(*;"ULO_Button_"+$1;$2)
