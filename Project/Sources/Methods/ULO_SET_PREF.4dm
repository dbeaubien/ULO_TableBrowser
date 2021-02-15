//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 11/02/21, 15:38:52
  // ----------------------------------------------------
  // Method: ULO_SET_PREF
  // Description
  // 
  //
  // Parameters
  // $1 - String  - Option Property to set
  // $2 - Variant - Option value
  // ----------------------------------------------------

C_VARIANT:C1683(${1})


Case of 
	: ($1="relateIgnoreTables")
		Use (Storage:C1525.prefs.relateIgnoreTables)
			Storage:C1525.prefs.relateIgnoreTables.push($2)
		End use 
		
	Else 
		Use (Storage:C1525.prefs)
			Storage:C1525.prefs[$1]:=$2
		End use 
		
End case 
