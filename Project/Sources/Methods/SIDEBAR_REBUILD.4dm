//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 27/01/20, 15:57:18
  // ----------------------------------------------------
  // Method: SIDEBAR_REBUILD
  // Description
  // Rebuilds Form.navItems according to Form.sidebarSource
  // 
  // Parameters
  // $1 - Longint - Clicked Index
  // ----------------------------------------------------

C_COLLECTION:C1488($vc_navItems)
C_OBJECT:C1216($vo_item)
C_LONGINT:C283($vl_lastSelected)

  //Need to tweak Form.lastSelectedIndex according to amount of item added / removed
  //after the index

$vl_lastSelected:=Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].index

$vc_navItems:=New collection:C1472
For each ($vo_item;Form:C1466.sidebarSource)
	If (OB Is defined:C1231($vo_item;"childOfIndex"))
		  //Check if parent header is `expanded`
		If (Form:C1466.sidebarSource[$vo_item.childOfIndex].expanded)
			$vc_navItems.push(OB Copy:C1225($vo_item))
		End if 
	Else 
		  //Has no parent, therefore always display
		$vc_navItems.push(OB Copy:C1225($vo_item))
	End if 
End for each 
Form:C1466.navItems:=$vc_navItems

  //TRACE

$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItems;"index";$vl_lastSelected)
If ($vl_idx>=0)
	Form:C1466.lastNavItemIndex:=$vl_idx+1
	  //ALERT(String($vl_idx+1))
End if 
