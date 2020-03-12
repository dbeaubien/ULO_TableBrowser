//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/03/20, 11:58:27
  // ----------------------------------------------------
  // Method: ULO_VIEW_CUSTOM_COL
  // Description
  // Puts given data into Form.customColumns for use
  // by View edit screen.
  // Parameters
  // $1 - String  - Name
  // $2 - String  - Method
  // $3 - String  - Parameters
  // $4 - Longint - Data Type
  // $5 - String  - Header
  // $6 - String - Display Format (optional)
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$3;$5;$6)
C_LONGINT:C283($4)

C_OBJECT:C1216($vo_col)

If (UTIL_Col_Find_Index (Form:C1466.customColumns;"name";$1)=-1)
	$vo_col:=New object:C1471
	$vo_col.name:=$1
	$vo_col.method:=$2
	$vo_col.formula:=$2+$3
	$vo_col.dataType:=$4
	$vo_col.header:=$5
	If (Count parameters:C259>5)
		$vo_col.format:=$6
	Else 
		$vo_col.format:=""
	End if 
	Form:C1466.customColumns.push(OB Copy:C1225($vo_col))
End if 
