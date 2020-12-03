//%attributes = {}
C_TEXT:C284($1)
C_OBJECT:C1216($2)
C_LONGINT:C283($i)

Case of 
	: ($1="INIT")
		Form:C1466.parent:=$2
		ARRAY TEXT:C222($at_queryOperCode;0)
		ARRAY TEXT:C222($at_queryOperName;0)
		ARRAY TEXT:C222($at_queryConjCode;0)
		ARRAY TEXT:C222($at_queryConjName;0)
		COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryOperators;$at_queryOperCode;"operand";$at_queryOperName;"name")
		COLLECTION TO ARRAY:C1562(Form:C1466.parent.queryConjunctions;$at_queryConjCode;"operand";$at_queryConjName;"name")
		
		  //Init first row of form elements according to lastQuery[0]
		If (Form:C1466.parent.lastQuery.length>0)
			COPY ARRAY:C226($at_queryConjName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_conjunction0000")->)
			COPY ARRAY:C226($at_queryOperName;OBJECT Get pointer:C1124(Object named:K67:5;"ql_operator0000")->)
			
			QE_FILL_LINE_DATA (Form:C1466.parent.lastQuery[0];"0000")
			
			  //Loop remaining elements, adding each row
			For ($i;1;Form:C1466.parent.lastQuery.length-1)
				QE_ADD_LINE ($i)
			End for 
			
		End if 
		
	: ($1="UPDATE")
		Form:C1466.parent.queryFields:=$2.queryFields
		
	: ($1="CLEAR")
		  //Hide all ql elements.
		OBJECT SET VISIBLE:C603(*;"ql_@";False:C215)
		  //Show only first row
		OBJECT SET VISIBLE:C603(*;"ql_@0000";True:C214)
		  //Fill first row data
		QE_FILL_LINE_DATA (Form:C1466.parent.lastQuery[0];"0000")
		
	: ($1="LOAD")
		Form:C1466.parent.lastQuery:=$2.lastQuery
		
		  //Hide all ql elements.
		OBJECT SET VISIBLE:C603(*;"ql_@";False:C215)
		  //Show only first row
		OBJECT SET VISIBLE:C603(*;"ql_@0000";True:C214)
		  //Fill first row data
		QE_FILL_LINE_DATA (Form:C1466.parent.lastQuery[0];"0000")
		
		  //Loop remaining elements, adding each row
		For ($i;1;Form:C1466.parent.lastQuery.length-1)
			QE_ADD_LINE ($i)
		End for 
		
End case 