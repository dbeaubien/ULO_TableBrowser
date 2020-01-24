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
C_COLLECTION:C1488($2)
C_TEXT:C284($vt_queryString;$vt_conjunction)
C_LONGINT:C283($1;$vl_queryIndex;$vl_type)
$vo_params:=New object:C1471
$vo_params.parameters:=New collection:C1472
For each ($vo_queryLine;$2)
	$vl_queryIndex:=$vl_queryIndex+1
	$vt_conjunction:=" "
	If (OB Is defined:C1231($vo_queryLine;"conjunction"))
		If ($vo_queryLine.conjunction#"") & ($vo_queryLine.conjunction#"-")
			$vt_conjunction:=" "+$vo_queryLine.conjunction+" "
		End if 
	End if 
	$vt_queryString:=$vt_queryString+Field name:C257($1;$vo_queryLine.field)+" "+$vo_queryLine.oper+" :"+String:C10($vl_queryIndex)+$vt_conjunction
	$vl_type:=$vo_queryLine.type
	Case of 
		: ($vl_type=Is text:K8:3) | ($vl_type=Is alpha field:K8:1)
			$vo_params.parameters.push($vo_queryLine.value)
		: ($vl_type=Is longint:K8:6) | ($vl_type=Is real:K8:4) | ($vl_type=Is integer:K8:5)
			$vo_params.parameters.push(Num:C11($vo_queryLine.value))
		: ($vl_type=Is date:K8:7)
			$vo_params.parameters.push(Date:C102($vo_queryLine.value))
		: ($vl_type=Is boolean:K8:9)
			$vo_params.parameters.push(($vo_queryLine.value="True"))
	End case 
	
End for each 
$0:=ds:C1482[Table name:C256($1)].query($vt_queryString;$vo_params)
