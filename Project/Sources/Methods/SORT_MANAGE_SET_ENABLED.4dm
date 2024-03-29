//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 17/02/20, 12:31:54
  // ----------------------------------------------------
  // Method: SORT_MANAGE_SET_ENABLED
  // Description
  // Sets buttons enabled state according to selected 
  // Sort etc..
  // Parameters
  // ----------------------------------------------------

OBJECT SET ENABLED:C1123(*;"txt_sortName";False:C215)
OBJECT SET ENABLED:C1123(*;"bt_moveField";False:C215)
OBJECT SET ENABLED:C1123(*;"bt_deleteField";False:C215)
OBJECT SET ENABLED:C1123(*;"bt_deleteSort";False:C215)
OBJECT SET ENABLED:C1123(*;"bt_addField";False:C215)
OBJECT SET ENABLED:C1123(*;"bt_addSort";False:C215)
OBJECT SET ENABLED:C1123(*;"dropdown_table";False:C215)
OBJECT SET ENABLED:C1123(*;"cb_default";False:C215)

If (Form:C1466.sortTab="user")
	If (Form:C1466.selectedSort#Null:C1517)
		OBJECT SET ENABLED:C1123(*;"txt_sortName";True:C214)
		OBJECT SET ENABLED:C1123(*;"bt_deleteSort";True:C214)
		OBJECT SET ENABLED:C1123(*;"bt_addField";False:C215)  //No functions as of yet, leave disabled
		OBJECT SET ENABLED:C1123(*;"dropdown_table";True:C214)
		OBJECT SET ENABLED:C1123(*;"cb_default";True:C214)
		
		If (Form:C1466.selectedField#Null:C1517)
			OBJECT SET ENABLED:C1123(*;"bt_moveField";True:C214)
		End if 
		If (Form:C1466.selectedSortCol#Null:C1517)
			OBJECT SET ENABLED:C1123(*;"bt_deleteField";True:C214)
		End if 
	End if 
	OBJECT SET ENABLED:C1123(*;"bt_addSort";True:C214)
End if 

  //Only enable buttons in system tab if logged in as Designer
If (Form:C1466.sortTab="system") & (Storage:C1525.user.id=1)
	If (Form:C1466.selectedSort#Null:C1517)
		OBJECT SET ENABLED:C1123(*;"txt_sortName";True:C214)
		OBJECT SET ENABLED:C1123(*;"bt_deleteSort";True:C214)
		OBJECT SET ENABLED:C1123(*;"bt_addField";False:C215)  //No functions as of yet, leave disabled
		OBJECT SET ENABLED:C1123(*;"dropdown_table";True:C214)
		OBJECT SET ENABLED:C1123(*;"cb_default";True:C214)
		
		If (Form:C1466.selectedField#Null:C1517)
			OBJECT SET ENABLED:C1123(*;"bt_moveField";True:C214)
		End if 
		If (Form:C1466.selectedSortCol#Null:C1517)
			OBJECT SET ENABLED:C1123(*;"bt_deleteField";True:C214)
		End if 
	End if 
	OBJECT SET ENABLED:C1123(*;"bt_addSort";True:C214)
End if 
