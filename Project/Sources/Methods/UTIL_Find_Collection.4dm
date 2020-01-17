//%attributes = {"preemptive":"capable"}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 27/08/19, 11:23:56
  // ----------------------------------------------------
  // Method: UTIL_Find_Collection
  // Description
  // for use with collection.findIndex()
  // Generic method that allows simple search on one property
  // Parameters
  // $1 - Object - contains value to evaluate and 'result' boolean
  // $2 - String - property to test
  // $3 - Variant - value to test
  // ----------------------------------------------------

  //C_OBJECT($1)
  //C_TEXT($2)
  //C_VARIANT($3)

  //$1.result:=($1.value[$2]=$3)

C_OBJECT:C1216($1)
C_VARIANT:C1683(${2})
C_BOOLEAN:C305($vb_result)
$vb_result:=True:C214
For ($i;3;Count parameters:C259;2)
	$vb_result:=$vb_result & ($1.value[${$i-1}]=${$i})
End for 
$1.result:=$vb_result