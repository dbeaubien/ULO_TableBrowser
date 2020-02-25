//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 24/02/20, 16:27:03
  // ----------------------------------------------------
  // Method: UTIL_Num_To_Excel_Cell
  // Description
  // Converts number to Excel Cell character
  // E.G. 3 = C, or 27 = AA
  // Parameters
  // $0 - String  - Excel Cell
  // $1 - Longint - Number to convert
  // ----------------------------------------------------

C_TEXT:C284($0;$vt_1;$vt_2)
C_LONGINT:C283($1)

If ($1>25)
	$vt_1:=Char:C90(64+(($1)\26))
Else 
	$vt_1:=""
End if 
  //first split = B, orig order has A appended to it
$vt_2:=Char:C90(64+($1%26))
$0:=$vt_1+$vt_2


