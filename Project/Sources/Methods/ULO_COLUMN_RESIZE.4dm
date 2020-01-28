//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 22/01/20, 10:21:49
  // ----------------------------------------------------
  // Method: ULO_COLUMN_RESIZE
  // Description
  // Saves resized column widths where user has permission
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($vt_colName)
C_OBJECT:C1216($e_uloData;$vo_col)
C_LONGINT:C283($vl_width;$vl_idx)


If (Form:C1466.navItem.selectedView.user=Storage:C1525.user.id)
	
	$e_uloData:=ds:C1482["uloData"].get(Form:C1466.navItem.selectedView.id)
	
	For each ($vo_col;$e_uloData.detail.cols)
		$vt_colName:="h_"+String:C10($vo_col.table)+"_"+String:C10($vo_col.field)
		$vl_width:=LISTBOX Get column width:C834(*;$vt_colName)
		$vo_col.width:=$vl_width
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItem.selectedView.detail.cols;"table";$vo_col.table;"field";$vo_col.field)
		If ($vl_idx>=0)
			Form:C1466.navItem.selectedView.detail.cols[$vl_idx].width:=$vl_width
		End if 
	End for each 
	$e_uloData.detail:=$e_uloData.detail
	$e_uloData.save()
	
Else 
	  //Not allowed (to save)
	  //TRACE
End if 


