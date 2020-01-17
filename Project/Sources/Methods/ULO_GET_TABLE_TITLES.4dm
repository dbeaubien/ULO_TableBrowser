//%attributes = {"invisible":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 08/11/19, 14:21:47
  // ----------------------------------------------------
  // Method: ULO_GET_TABLE_TITLES
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_POINTER:C301($1;$2)
C_LONGINT:C283($cp)
ARRAY TEXT:C222($at_tableName;0)
ARRAY LONGINT:C221($al_tableNum;0)
$cp:=Count parameters:C259
COLLECTION TO ARRAY:C1562(Storage:C1525.tableTitles;$at_tableName;"name"\
;$al_tableNum;"id")

COPY ARRAY:C226($at_tableName;$1->)
If ($cp>1)
	COPY ARRAY:C226($al_tableNum;$2->)
End if 
