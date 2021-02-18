//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 18/02/21, 16:34:00
  // ----------------------------------------------------
  // Method: ULO_SET_HOST_METHOD
  // Description
  // Allows setting of HOST methods called by ULO
  //
  // Parameters
  // $1 - String - Property name
  // $2 - String - Host method name 
  // ----------------------------------------------------

C_TEXT:C284($1;$2)

Use (Storage:C1525.hostMethods)
	If (OB Is defined:C1231(Storage:C1525.hostMethods;$1))
		Storage:C1525.hostMethods[$1]:=$2
	End if 
End use 
