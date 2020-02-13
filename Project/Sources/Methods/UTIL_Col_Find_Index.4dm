//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 27/01/20, 11:39:29
  // ----------------------------------------------------
  // Method: UTIL_Col_Find_Index
  // Description
  // Home-grown replacement for collection.findIndex()
  //
  // Parameters
  // $0 - Longint    - Index of first successful element, -1 if none found
  // $1 - Collection - Collection to search
  // ${2} - Variant  - Property / Value to test
  // ----------------------------------------------------

C_LONGINT:C283($0;$i;$j)
C_COLLECTION:C1488($1)
C_VARIANT:C1683(${2})
C_BOOLEAN:C305($vb_res)

$0:=-1

For ($i;0;$1.length-1)
	$vb_res:=True:C214
	For ($j;3;Count parameters:C259;2)
		If (OB Is defined:C1231($1[$i];String:C10(${$j-1})))
			$vb_res:=$vb_res & ($1[$i][String:C10(${$j-1})]=${$j})
		Else 
			$vb_res:=False:C215
		End if 
	End for 
	If ($vb_res)
		$0:=$i
		$i:=$1.length  //break from loop
	End if 
End for 

