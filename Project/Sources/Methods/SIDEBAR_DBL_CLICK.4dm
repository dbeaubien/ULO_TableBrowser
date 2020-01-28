//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 28/01/20, 09:21:45
  // ----------------------------------------------------
  // Method: SIDEBAR_DBL_CLICK
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305($vb_okToContinue)
C_LONGINT:C283($vl_idx;$vl_index;$i)

$vb_okToContinue:=True:C214


$vl_idx:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"index";Form:C1466.navItem.index)
If ($vl_idx>=0)
	If (Form:C1466.sidebarSource[$vl_idx].sub.length>0)  //This whole process is only relevant when the clicked header has children
		
		
		If (OB Is defined:C1231(Form:C1466.navItems[Form:C1466.lastNavItemIndex-1];"childOfIndex"))
			$vb_okToContinue:=(Form:C1466.navItem.index#(Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].childOfIndex+1))
			If ($vb_okToContinue)
				For each ($vl_index;Form:C1466.sidebarSource[$vl_idx].sub)
					If (Form:C1466.sidebarSource[$vl_index-1].index=(Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].childOfIndex+1))
						$vb_okToContinue:=False:C215
					End if 
				End for each 
			End if 
		End if 
		
		If ($vb_okToContinue)
			Form:C1466.sidebarSource[$vl_idx].expanded:=Not:C34(Form:C1466.sidebarSource[$vl_idx].expanded)
			If (Not:C34(Form:C1466.sidebarSource[$vl_idx].expanded))  //if top level is closed, close all children
				For each ($i;Form:C1466.sidebarSource[$vl_idx].sub)
					Form:C1466.sidebarSource[$i-1].expanded:=False:C215
				End for each 
			End if 
			SIDEBAR_REBUILD 
		End if 
	End if 
End if 

