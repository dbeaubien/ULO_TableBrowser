//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 16/12/19, 13:49:48
  // ----------------------------------------------------
  // Method: UTIL_Duplicate_Entity
  // Description
  // Duplicates all Fields from Source Entity into returned New Entity
  //
  // Parameters
  // $0 - Entity - Newly created record
  // $1 - Entity - Record to duplicate
  // $2 - String - Data Class name
  // ----------------------------------------------------

C_OBJECT:C1216($0;$1;$e_new;$e_source)
C_TEXT:C284($2;$vt_class;$vt_prop)

$e_source:=$1
$vt_class:=$2
$e_new:=ds:C1482[$vt_class].new()

For each ($vt_prop;ds:C1482[$vt_class])
	If (ds:C1482[$vt_class][$vt_prop].kind="storage")
		$e_new[ds:C1482[$vt_class][$vt_prop].name]:=$e_source[ds:C1482[$vt_class][$vt_prop].name]
	End if 
End for each 

$0:=$e_new

