//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/02/20, 14:27:16
  // ----------------------------------------------------
  // Method: ULO_LOAD_WEB_AREA
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

If (Form:C1466.navItem.targetUrl#Null:C1517)
	FORM GOTO PAGE:C247(2)
	
	WA OPEN URL:C1020(*;"ULO_WebArea";Form:C1466.navItem.targetUrl)
	OBJECT SET ENABLED:C1123(*;"ULO_Button@";False:C215)
	  //TODO: need a way to reenable `To Do Items` 
	
End if 
