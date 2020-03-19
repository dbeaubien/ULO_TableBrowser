//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 19/03/20, 14:19:18
  // ----------------------------------------------------
  // Method: ULO_Get_Type_Lookup
  // Description
  // Builds returns collection of Type Name / Numbers
  // Used by PREF_ULO for search lookups
  // Parameters
  // $0 - Collection - name / number pairs
  // ----------------------------------------------------

C_COLLECTION:C1488($0)

$0:=New collection:C1472

$0.push(New object:C1471("name";"";"number";0))
$0.push(New object:C1471("name";"Set";"number";1))
$0.push(New object:C1471("name";"View";"number";2))
$0.push(New object:C1471("name";"Theme";"number";3))
$0.push(New object:C1471("name";"Tab";"number";4))
$0.push(New object:C1471("name";"Query";"number";5))
$0.push(New object:C1471("name";"Sort";"number";13))
