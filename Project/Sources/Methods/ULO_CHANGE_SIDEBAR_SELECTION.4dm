//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 20/03/20, 13:01:42
  // ----------------------------------------------------
  // Method: ULO_CHANGE_SIDEBAR_SELECTION
  // Description
  // Forces ULO to change the selected sidebar according to given handle
  //
  // Parameters
  // $1 - String - Handle
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_targetHandle)


$vt_targetHandle:=$1

$vl_sidebarIdx:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"handle";$vt_targetHandle)
If ($vl_sidebarIdx>=0)
	
	If (OB Is defined:C1231(Form:C1466.sidebarSource[$vl_sidebarIdx];"childOfIndex"))
		Form:C1466.sidebarSource[Form:C1466.sidebarSource[$vl_sidebarIdx].childOfIndex].expanded:=True:C214
		If (OB Is defined:C1231(Form:C1466.sidebarSource[Form:C1466.sidebarSource[$vl_sidebarIdx].childOfIndex];"childOfIndex"))
			Form:C1466.sidebarSource[Form:C1466.sidebarSource[Form:C1466.sidebarSource[$vl_sidebarIdx].childOfIndex].childOfIndex].expanded:=True:C214
		End if 
	End if 
	
	SIDEBAR_REBUILD 
	
	$vl_navitemIndex:=UTIL_Col_Find_Index (Form:C1466.navItems;"handle";$vt_targetHandle)
	If ($vl_navitemIndex>=0)
		LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$vl_navitemIndex+1;lk replace selection:K53:1)
		
		Form:C1466.lastNavItemIndex:=$vl_navitemIndex+1
	End if 
	
	If (Storage:C1525.hostMethods.sidebarLoad#"")
		EXECUTE METHOD:C1007(Storage:C1525.hostMethods.sidebarLoad;$es_return;Form:C1466.tableNumber;Form:C1466.navItem.handle)
		Form:C1466.uloRecords:=$es_return
	End if 
	ULO_CREATE_SHORTCUTS 
	
	Form:C1466.fullRefresh:=True:C214
	SET TIMER:C645(-1)
End if 


