//%attributes = {}
C_LONGINT:C283($vl_verticalOffset;$vl_currentRow;$vl_lastRow)
C_TEXT:C284($vt_rowExtension)
$vl_verticalOffset:=30
$vt_rowExtension:=String:C10(Form:C1466.parent.lastQuery.length;"0000")
$vl_lastRow:=Form:C1466.parent.lastQuery.length
$vl_currentRow:=$vl_lastRow+1
ARRAY LONGINT:C221($al_fieldNum;0)
ARRAY TEXT:C222($at_fieldName;0)
ARRAY TEXT:C222($at_queryOperCode;0)
ARRAY TEXT:C222($at_queryOperName;0)
ARRAY TEXT:C222($at_queryConjCode;0)
ARRAY TEXT:C222($at_queryConjName;0)
COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryFields;$al_fieldNum;"fieldNum";$at_fieldName;"fieldName")
COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryOperators;$at_queryOperCode;"operand";$at_queryOperName;"name")
COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryConjunctions;$at_queryConjCode;"operand";$at_queryConjName;"name")

OBJECT DUPLICATE:C1111(*;"ql_lBracket0000";"ql_lBracket"+$vt_rowExtension)
OBJECT SET TITLE:C194(*;"ql_lBracket";"")
OBJECT DUPLICATE:C1111(*;"ql_field0000";"ql_field"+$vt_rowExtension)
  //OBJECT SET DATA SOURCE(*;"ql_field"+$vt_rowExtension;->at_fieldName)
COPY ARRAY:C226($at_fieldName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_field"+$vt_rowExtension)->)
OBJECT DUPLICATE:C1111(*;"ql_operator0000";"ql_operator"+$vt_rowExtension)
  //OBJECT SET DATA SOURCE(*;"ql_operator"+$vt_rowExtension;->at_queryOperName)
COPY ARRAY:C226($at_queryOperName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator"+$vt_rowExtension)->)
OBJECT DUPLICATE:C1111(*;"ql_valueText0000";"ql_valueText"+$vt_rowExtension)
OBJECT DUPLICATE:C1111(*;"ql_rBracket0000";"ql_rBracket"+$vt_rowExtension)
OBJECT SET TITLE:C194(*;"ql_rBracket";"")
OBJECT DUPLICATE:C1111(*;"ql_conjunction0000";"ql_conjunction"+$vt_rowExtension)
  //OBJECT SET DATA SOURCE(*;"ql_conjunction"+$vt_rowExtension;->at_queryConjName)
COPY ARRAY:C226($at_queryConjName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_conjunction"+$vt_rowExtension)->)
OBJECT DUPLICATE:C1111(*;"ql_deleteLine0000";"ql_deleteLine"+$vt_rowExtension)
If (OBJECT Get pointer:C1124("ql_conjunction"+String:C10($vl_lastRow-1;"0000"))->{OBJECT Get pointer:C1124("ql_conjunction"+String:C10($vl_lastRow-1;"0000"))->}="or")
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_field"+$vt_rowExtension)->:=OBJECT Get pointer:C1124(Object named:K67:5;"ql_field"+String:C10($vl_lastRow-1;"0000"))->
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator"+$vt_rowExtension)->:=OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator"+String:C10($vl_lastRow-1;"0000"))->
End if 
OBJECT MOVE:C664(*;"ql_@"+$vt_rowExtension;0;(($vl_currentRow-1)*$vl_verticalOffset))
Form:C1466.parent.lastQuery.push(New object:C1471("lBracket";False:C215;"table";Form:C1466.parent.tableNumber;\
"field";Form:C1466.parent.queryFields[0].fieldNum;"type";Form:C1466.parent.queryFields[0].fieldType;\
"oper";Form:C1466.parent.queryOperators[0].operand;\
"value";"";"rBracket";False:C215;"conjunction";Form:C1466.parent.queryConjunctions[0].operand))

