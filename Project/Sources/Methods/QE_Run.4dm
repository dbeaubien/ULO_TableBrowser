//%attributes = {"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 06/01/20, 16:28:46
  // ----------------------------------------------------
  // Method: QE_Run
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($0;$vo_queryLine;$vo_params)
C_COLLECTION:C1488($2;$vc_convertValues;$vc_values)
C_TEXT:C284($vt_queryString;$vt_conjunction;$vt_field;$vt_value)
C_LONGINT:C283($1;$vl_queryIndex;$vl_type;$3;$vl_queryType)
$vo_params:=New object:C1471
$vo_params.parameters:=New collection:C1472
$vl_queryType:=$3
For each ($vo_queryLine;$2)
	$vl_queryIndex:=$vl_queryIndex+1
	$vt_conjunction:=" "
	If (OB Is defined:C1231($vo_queryLine;"conjunction"))
		If ($vo_queryLine.conjunction#"") & ($vo_queryLine.conjunction#"-")
			$vt_conjunction:=" "+$vo_queryLine.conjunction+" "
		End if 
	End if 
	
	$vt_field:=$vo_queryLine.fieldName
	If (OB Is defined:C1231($vo_queryLine;"relation"))
		If ($vo_queryLine.relation#"")
			$vt_field:=$vo_queryLine.relation+"."+$vt_field
		End if 
	End if 
	If (OB Is defined:C1231($vo_queryLine;"attribute"))
		If ($vo_queryLine.attribute#"")
			$vt_field:=$vt_field+"."+$vo_queryLine.attribute
		End if 
	End if 
	
	If ($vo_queryLine.lBracket)
		$vt_queryString:=$vt_queryString+"("
	End if 
	If ($vo_queryLine.oper="not in")
		$vt_queryString:=$vt_queryString+"not("+$vt_field+" in :"+String:C10($vl_queryIndex)+")"
	Else 
		$vt_queryString:=$vt_queryString+$vt_field+" "+$vo_queryLine.oper+" :"+String:C10($vl_queryIndex)
	End if 
	If ($vo_queryLine.rBracket)
		$vt_queryString:=$vt_queryString+")"
	End if 
	$vt_queryString:=$vt_queryString+$vt_conjunction
	
	$vl_type:=$vo_queryLine.type
	
	
	Case of 
		: ($vo_queryLine.oper="in") | ($vo_queryLine.oper="not in")
			$vc_values:=CSV_PARSE_RECORD_COL ($vo_queryLine.value;Character code:C91(";"))
			$vc_convertValues:=New collection:C1472
			  //Convert values
			Case of 
				: ($vl_type=Is longint:K8:6) | ($vl_type=Is real:K8:4) | ($vl_type=Is integer:K8:5)
					For each ($vt_value;$vc_values)
						$vc_convertValues.push(Num:C11($vt_value))
					End for each 
				: ($vl_type=Is date:K8:7)
					For each ($vt_value;$vc_values)
						$vc_convertValues.push(Date:C102($vt_value))
					End for each 
				: ($vl_type=Is boolean:K8:9)
					For each ($vt_value;$vc_values)
						$vc_convertValues.push(($vt_value="True"))
					End for each 
				Else 
					$vc_convertValues:=$vc_values
			End case 
			$vo_params.parameters.push($vc_convertValues)
			
		: ($vo_queryLine.oper="==")
			Case of 
				: ($vl_type=Is text:K8:3) | ($vl_type=Is alpha field:K8:1) | ($vl_type=Is object:K8:27)
					$vo_params.parameters.push("@"+$vo_queryLine.value+"@")
				: ($vl_type=Is longint:K8:6) | ($vl_type=Is real:K8:4) | ($vl_type=Is integer:K8:5)
					$vo_params.parameters.push(Num:C11($vo_queryLine.value))
				: ($vl_type=Is date:K8:7)
					$vo_params.parameters.push(Date:C102($vo_queryLine.value))
				: ($vl_type=Is boolean:K8:9)
					$vo_params.parameters.push(($vo_queryLine.value="True"))
			End case 
			
		Else 
			Case of 
				: ($vl_type=Is text:K8:3) | ($vl_type=Is alpha field:K8:1) | ($vl_type=Is object:K8:27)
					$vo_params.parameters.push($vo_queryLine.value)
				: ($vl_type=Is longint:K8:6) | ($vl_type=Is real:K8:4) | ($vl_type=Is integer:K8:5)
					$vo_params.parameters.push(Num:C11($vo_queryLine.value))
				: ($vl_type=Is date:K8:7)
					$vo_params.parameters.push(Date:C102($vo_queryLine.value))
				: ($vl_type=Is boolean:K8:9)
					$vo_params.parameters.push(($vo_queryLine.value="True"))
			End case 
	End case 
	
End for each 
If ($vl_queryType=1)  //Query in selection
	$0:=Form:C1466.uloRecords.query($vt_queryString;$vo_params)
Else 
	$0:=ds:C1482[Table name:C256($1)].query($vt_queryString;$vo_params)
End if 