//%attributes = {"invisible":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 30/10/19, 10:53:33
  // ----------------------------------------------------
  // Method: UTIL_Recursive_Find_Col_Number
  // Description
  // Searches collection for a given value and returns whole object
  // for first pass
  // Searches the collection recursivly using $4
  // Parameters
  // $0 - Object     - First element to pass test
  // $1 - Collection - collection to search
  // $2 - Text       - Attribute to test
  // $3 - Number     - Value to test
  // $4 - Text       - Attribute name of children for recursive search
  // ----------------------------------------------------

C_OBJECT:C1216($0)
C_COLLECTION:C1488($1)
C_TEXT:C284($2;$4)
C_REAL:C285($3)
C_OBJECT:C1216($vo_response;$vo_element)

$vl_index:=$1.findIndex("UTIL_Find_Collection_Number";$2;$3)
If ($vl_index=-1)
	For each ($vo_element;$1)
		If (OB Is defined:C1231($vo_element;$4))
			$vo_response:=UTIL_Recursive_Find_Col_Number ($vo_element[$4];$2;$3;$4)
			If ($vo_response#Null:C1517)
				$0:=$vo_response
			End if 
		End if 
	End for each 
Else 
	$0:=$1[$vl_index]
End if 


