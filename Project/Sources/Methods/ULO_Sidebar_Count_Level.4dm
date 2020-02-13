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




$0:=$vl_count