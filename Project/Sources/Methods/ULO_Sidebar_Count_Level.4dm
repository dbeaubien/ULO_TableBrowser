//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/02/20, 15:09:30
  // ----------------------------------------------------
  // Method: ULO_Sidebar_Count_Level
  // Description
  // Counts the number of parents a sidebar item has
  // Used to calc the indent 
  // Parameters
  // $0 - Longint - Number of parents 
  // $1 - Longint - Storage.sidebar $index
  // ----------------------------------------------------

C_LONGINT:C283($0;$vl_count;$1;$vl_idx)

$vl_idx:=$1

If (OB Is defined:C1231(Storage:C1525.sidebar[$vl_idx];"childOfIndex"))
	$vo_item:=OB Copy:C1225(Storage:C1525.sidebar[$vl_idx])
	Repeat 
		$vl_count:=$vl_count+1
		$vo_item:=OB Copy:C1225(Storage:C1525.sidebar[$vo_item.childOfIndex])
	Until (Not:C34(OB Is defined:C1231($vo_item;"childOfIndex")))
End if 

$0:=$vl_count