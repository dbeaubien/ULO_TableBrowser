//%attributes = {}

C_LONGINT:C283($1;$vl_queryIndex)
C_LONGINT:C283($vl_verticalOffset;$vl_currentRow;$vl_lastRow)
C_POINTER:C301($vp_nilPointer;$vp_testPointer)
C_TEXT:C284($vt_rowExtension)
C_OBJECT:C1216($vo_qObj)

ARRAY LONGINT:C221($al_fieldNum;0)
ARRAY TEXT:C222($at_fieldName;0)
ARRAY TEXT:C222($at_queryOperCode;0)
ARRAY TEXT:C222($at_queryOperName;0)
ARRAY TEXT:C222($at_queryConjCode;0)
ARRAY TEXT:C222($at_queryConjName;0)

$vl_verticalOffset:=30

If (Count parameters:C259>0)
	$vl_queryIndex:=$1
	$vt_rowExtension:=String:C10($vl_queryIndex;"0000")
	$vl_lastRow:=$vl_queryIndex-1
	$vl_currentRow:=$vl_queryIndex+1
Else 
	$vt_rowExtension:=String:C10(Form:C1466.parent.lastQuery.length;"0000")
	$vl_lastRow:=Form:C1466.parent.lastQuery.length
	$vl_currentRow:=$vl_lastRow+1
End if 

COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryFields;$al_fieldNum;"fieldNum";$at_fieldName;"fieldName")
COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryOperators;$at_queryOperCode;"operand";$at_queryOperName;"name")
COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryConjunctions;$at_queryConjCode;"operand";$at_queryConjName;"name")

  //Check if this row extension has already been created
$vp_testPointer:=OBJECT Get pointer:C1124(Object named:K67:5;"ql_field"+$vt_rowExtension)
If ($vp_testPointer=$vp_nilPointer)
	OBJECT DUPLICATE:C1111(*;"ql_lBracket0000";"ql_lBracket"+$vt_rowExtension)
	OBJECT SET TITLE:C194(*;"ql_lBracket"+$vt_rowExtension;"")
	OBJECT DUPLICATE:C1111(*;"ql_field0000";"ql_field"+$vt_rowExtension)
	OBJECT DUPLICATE:C1111(*;"ql_attribute0000";"ql_attribute"+$vt_rowExtension)
	
	OBJECT DUPLICATE:C1111(*;"ql_operator0000";"ql_operator"+$vt_rowExtension)
	COPY ARRAY:C226($at_queryOperName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator"+$vt_rowExtension)->)
	OBJECT DUPLICATE:C1111(*;"ql_valueText0000";"ql_valueText"+$vt_rowExtension)
	OBJECT DUPLICATE:C1111(*;"ql_valueDate0000";"ql_valueDate"+$vt_rowExtension)
	OBJECT DUPLICATE:C1111(*;"ql_valueNum0000";"ql_valueNum"+$vt_rowExtension)
	
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueText"+$vt_rowExtension)->:=""
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueDate"+$vt_rowExtension)->:=!00-00-00!
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueNum"+$vt_rowExtension)->:=0
	
	OBJECT DUPLICATE:C1111(*;"ql_rBracket0000";"ql_rBracket"+$vt_rowExtension)
	OBJECT SET TITLE:C194(*;"ql_rBracket"+$vt_rowExtension;"")
	OBJECT DUPLICATE:C1111(*;"ql_conjunction0000";"ql_conjunction"+$vt_rowExtension)
	COPY ARRAY:C226($at_queryConjName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_conjunction"+$vt_rowExtension)->)
	
	OBJECT DUPLICATE:C1111(*;"ql_deleteLine0000";"ql_deleteLine"+$vt_rowExtension)
	OBJECT MOVE:C664(*;"ql_@"+$vt_rowExtension;0;(($vl_currentRow-1)*$vl_verticalOffset))
	
Else 
	  //Set all row elements to visible, 'QE_FILL_LINE_DATA' will hide the value fields not needed
	OBJECT SET VISIBLE:C603(*;"ql_@"+$vt_rowExtension;True:C214)
End if 

If ($vl_queryIndex=0)
	If (OBJECT Get pointer:C1124("ql_conjunction"+String:C10($vl_lastRow-1;"0000"))->{OBJECT Get pointer:C1124("ql_conjunction"+String:C10($vl_lastRow-1;"0000"))->}="or")
		$vo_qObj:=OB Copy:C1225(Form:C1466.parent.lastQuery[$vl_lastRow-1])
		$vo_qObj.conjunction:=""
		$vo_qObj.value:=""
		$vo_qObj.lBracket:=False:C215
		$vo_qObj.rBracket:=False:C215
		Form:C1466.parent.lastQuery.push(OB Copy:C1225($vo_qObj))
	Else 
		Form:C1466.parent.lastQuery.push(New object:C1471("lBracket";False:C215;"table";Form:C1466.parent.queryFields[0].tableNum;\
			"field";Form:C1466.parent.queryFields[0].fieldNum;"type";Form:C1466.parent.queryFields[0].fieldType;\
			"oper";Form:C1466.parent.queryOperators[0].operand;"value";"";\
			"rBracket";False:C215;"conjunction";"";"fieldName";Form:C1466.parent.queryFields[0].fieldName))
	End if 
	$vl_queryIndex:=Form:C1466.parent.lastQuery.length-1
End if 

QE_FILL_LINE_DATA (Form:C1466.parent.lastQuery[$vl_queryIndex];$vt_rowExtension)

