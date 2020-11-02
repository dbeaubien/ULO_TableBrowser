//%attributes = {}


  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 02/11/20, 11:52:23
  // ----------------------------------------------------
  // Method: QE_FILL_LINE_DATA
  // Description
  // Fills QE Line form elements with given obj data
  //
  // Parameters
  // $1 - Object - Query Line data
  // $2 - String - Row Extension
  // ----------------------------------------------------

C_OBJECT:C1216($1;$vo_queryData)
C_TEXT:C284($2;$vt_rowExtension)
C_LONGINT:C283($vl_fia;$vl_fieldType)

ARRAY TEXT:C222($at_queryOperCode;0)
ARRAY TEXT:C222($at_queryOperName;0)
ARRAY TEXT:C222($at_queryConjCode;0)
ARRAY TEXT:C222($at_queryConjName;0)

$vo_queryData:=$1
$vt_rowExtension:=$2

COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryOperators;$at_queryOperCode;"operand";$at_queryOperName;"name")
COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryConjunctions;$at_queryConjCode;"operand";$at_queryConjName;"name")

OBJECT Get pointer:C1124(Object named:K67:5;"ql_field"+$vt_rowExtension)->:=$vo_queryData.fieldName
If (OB Is defined:C1231($vo_queryData;"attribute"))
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_attribute"+$vt_rowExtension)->:=$vo_queryData.attribute
Else 
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_attribute"+$vt_rowExtension)->:=""
End if 

$vl_fia:=Find in array:C230($at_queryConjCode;$vo_queryData.conjunction)
If ($vl_fia>0)
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_conjunction"+$vt_rowExtension)->:=$vl_fia
End if 

$vl_fia:=Find in array:C230($at_queryOperCode;$vo_queryData.oper)
If ($vl_fia>0)
	OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator"+$vt_rowExtension)->:=$vl_fia
End if 

If ($vo_queryData.rBracket)
	OBJECT SET TITLE:C194(*;"ql_rBracket"+$vt_rowExtension;")")
End if 

If ($vo_queryData.lBracket)
	OBJECT SET TITLE:C194(*;"ql_lBracket"+$vt_rowExtension;"(")
End if 

OBJECT SET VISIBLE:C603(*;"ql_value@"+$vt_rowExtension;False:C215)
OBJECT SET VISIBLE:C603(*;"ql_attribute@"+$vt_rowExtension;False:C215)
$vl_fieldType:=$vo_queryData.type
Case of 
	: ($vl_fieldType=Is text:K8:3) | ($vl_fieldType=Is alpha field:K8:1)
		OBJECT SET VISIBLE:C603(*;"ql_valueText"+$vt_rowExtension;True:C214)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueText"+$vt_rowExtension)->:=String:C10($vo_queryData.value)
	: ($vl_fieldType=Is longint:K8:6) | ($vl_fieldType=Is real:K8:4)
		OBJECT SET VISIBLE:C603(*;"ql_valueNum"+$vt_rowExtension;True:C214)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueNum"+$vt_rowExtension)->:=Num:C11($vo_queryData.value)
	: ($vl_fieldType=Is date:K8:7)
		OBJECT SET VISIBLE:C603(*;"ql_valueDate"+$vt_rowExtension;True:C214)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueDate"+$vt_rowExtension)->:=Date:C102($vo_queryData.value)
	: ($vl_fieldType=Is object:K8:27)
		OBJECT SET VISIBLE:C603(*;"ql_valueText"+$vt_rowExtension;True:C214)
		OBJECT SET VISIBLE:C603(*;"ql_attribute"+$vt_rowExtension;True:C214)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueText"+$vt_rowExtension)->:=String:C10($vo_queryData.value)
	Else 
		OBJECT SET VISIBLE:C603(*;"ql_valueText"+$vt_rowExtension;True:C214)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_valueText"+$vt_rowExtension)->:=String:C10($vo_queryData.value)
End case 
