//%attributes = {}
  //Sets the bracket in the query editor lines collection 
  //and returns the bracket text if successful.
  //$1 = Object Name (either lBracketNUM or rBracketNUM)
C_TEXT:C284($0;$1;$2)
C_LONGINT:C283($vl_lineIndex)

$vl_lineIndex:=Num:C11(Substring:C12($1;9))
If ($2="left")
	If (Not:C34(Form:C1466.parent.lastQuery[$vl_lineIndex].lBracket))  //Set the left bracket
		Form:C1466.parent.lastQuery[$vl_lineIndex].lBracket:=True:C214
		$0:="("
	Else 
		Form:C1466.parent.lastQuery[$vl_lineIndex].lBracket:=False:C215
		  //Should also remove the matching close bracket if set?
		
		
		$0:=""
	End if 
	
Else   //Process right bracket
	If (Not:C34(Form:C1466.parent.lastQuery[$vl_lineIndex].rBracket))  //Set the left bracket
		  //Cannot set right bracket on row zero
		If ($vl_lineIndex=0)
			$0:=""
		Else 
			  //Should also check that we have an opening bracket
			  //or we do not display close bracket butons till we have an open?
			Form:C1466.parent.lastQuery[$vl_lineIndex].rBracket:=True:C214
			$0:=")"
		End if 
	Else 
		Form:C1466.parent.lastQuery[$vl_lineIndex].rBracket:=False:C215
		$0:=""
	End if 
	
End if 
