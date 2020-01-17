//%attributes = {}
C_TEXT:C284($1)
C_OBJECT:C1216($2)
Case of 
	: ($1="INIT")
		Form:C1466.parent:=$2
		ARRAY LONGINT:C221($al_fieldNum;0)
		ARRAY TEXT:C222($at_fieldName;0)
		ARRAY TEXT:C222($at_queryOperCode;0)
		ARRAY TEXT:C222($at_queryOperName;0)
		ARRAY TEXT:C222($at_queryConjCode;0)
		ARRAY TEXT:C222($at_queryConjName;0)
		COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryFields;$al_fieldNum;"fieldNum";$at_fieldName;"fieldName")
		COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryOperators;$at_queryOperCode;"operand";$at_queryOperName;"name")
		COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryConjunctions;$at_queryConjCode;"operand";$at_queryConjName;"name")
		
		COPY ARRAY:C226($at_fieldName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_field0000")->)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_field0000")->:=1
		COPY ARRAY:C226($at_queryOperName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator0000")->)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator0000")->:=1
		COPY ARRAY:C226($at_queryConjName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_conjunction0000")->)
		OBJECT Get pointer:C1124(Object named:K67:5;"ql_conjunction0000")->:=1
		
End case 