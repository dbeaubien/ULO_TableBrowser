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
C_LONGINT:C283($vl_lastSelected;$vl_idx)

$vl_lastSelected:=Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].index
If (Form:C1466.navItem#Null:C1517)
	$vl_idx:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"index";Form:C1466.navItem.index)
	If ($vl_idx>=0)
		If (OB Is defined:C1231(Form:C1466.navItem;"selection"))
			Form:C1466.sidebarSource[$vl_idx].selection:=Form:C1466.navItem.selection
		End if 
		If (OB Is defined:C1231(Form:C1466.navItem;"selectedView"))
			Form:C1466.sidebarSource[$vl_idx].selectedView:=Form:C1466.navItem.selectedView
		End if 
	End if 
End if 

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

$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItems;"index";$vl_lastSelected)
If ($vl_idx>=0)
	Form:C1466.lastNavItemIndex:=$vl_idx+1
End if 
