//%attributes = {}
  //Method: CSV_PARSE_RECORD_COL
  //Written by: J. Douglas Cryer
  //Date: 25/01/2005
  //Parses a CSV record into an collection.

  // Modified by: Tom (16/02/2021)
  // Reworked to return string collection

C_COLLECTION:C1488($0)
C_TEXT:C284($1;$vt_CurFld;$vt_InText)
C_LONGINT:C283($2)
C_LONGINT:C283($vl_Count;$vl_Len;$i;$vl_SOA;$vl_End;$vl_Start)
C_TEXT:C284($vs_FldSep)
If (Count parameters:C259=2)
	$vs_FldSep:=Char:C90($2)
Else 
	$vs_FldSep:=Char:C90(44)  //default to comma
End if 
$vt_InText:=$1
$0:=New collection:C1472
If ($vt_InText#"")
	Repeat 
		$vl_Start:=1
		
		If ($vt_InText[[$vl_Start]]=Char:C90(34))  //If it is a quote then look for next quote/comma.
			$vl_End:=Position:C15(Char:C90(34)+$vs_FldSep;$vt_InText)
			If ($vl_End=0)
				$vl_End:=Length:C16($vt_InText)
			End if 
			$vl_Len:=$vl_End-($vl_Start+1)
			$vl_End:=$vl_End+2
			$vl_Start:=$vl_Start+1
		Else   //It is not a quote so look for the next seperator.
			$vl_End:=Position:C15($vs_FldSep;$vt_InText)
			If ($vl_End=0)
				$vl_End:=Length:C16($vt_InText)+1
			End if 
			$vl_Len:=$vl_End-$vl_Start
			$vl_End:=$vl_End+1
		End if 
		$0.push(Replace string:C233(Substring:C12($vt_InText;$vl_Start;$vl_Len);Char:C90(34);""))
		$vt_InText:=Substring:C12($vt_InText;$vl_End)
	Until ($vt_InText="")
End if 