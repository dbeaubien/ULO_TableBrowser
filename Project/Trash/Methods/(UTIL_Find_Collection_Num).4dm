//%attributes = {"invisible":true,"preemptive":"capable"}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 27/08/19, 11:23:56
  // ----------------------------------------------------
  // Method: UTIL_Find_Collection_String
  // Description
  // for use with collection.findIndex()
  // Generic method that allows simple search on one property
  // Parameters
  // $1 - Object - contains value to evaluate and 'result' boolean
  // $2 - String - property to test
  // $3 - String - value to test
  // ----------------------------------------------------

C_OBJECT:C1216($1)
C_TEXT:C284($2;$3)

$1.result:=($1.value[$2]=$3)