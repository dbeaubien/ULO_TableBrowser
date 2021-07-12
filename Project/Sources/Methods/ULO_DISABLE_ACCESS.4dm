//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/07/21, 11:30:25
  // ----------------------------------------------------
  // Method: ULO_DISABLE_ACCESS
  // Description
  // Ran when the selected navItem access is false
  // Instead of displaying the data listing, a custom image 
  // for informing the user they do not have access is displayed
  // Parameters
  // ----------------------------------------------------

C_PICTURE:C286($vg_accessImage)

OBJECT SET ENABLED:C1123(*;"ULO_Button@";False:C215)

READ PICTURE FILE:C678(Storage:C1525.prefs.noAccessImage;$vg_accessImage)
Form:C1466.noAccessImage:=$vg_accessImage

FORM GOTO PAGE:C247(3)
