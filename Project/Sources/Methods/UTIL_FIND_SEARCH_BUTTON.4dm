//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 20/05/21, 16:20:23
  // ----------------------------------------------------
  // Method: UTIL_FIND_SEARCH_BUTTON
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_POINTER:C301($1;$2;$3;$4)

If (Is macOS:C1572)
	OBJECT GET COORDINATES:C663(*;"SearchButton_Mac";$1->;$2->;$3->;$4->)
	OBJECT SET VISIBLE:C603(*;"SearchButton_Mac";False:C215)
Else 
	OBJECT GET COORDINATES:C663(*;"SearchButton_Win";$1->;$2->;$3->;$4->)
	OBJECT SET VISIBLE:C603(*;"SearchButton_Win";False:C215)
End if 
