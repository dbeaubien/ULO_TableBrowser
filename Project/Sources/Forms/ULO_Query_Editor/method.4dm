If (FORM Event:C1606.code=On Load:K2:1)
	
	EXECUTE METHOD IN SUBFORM:C1085("queryLines";"QE_LINES_METHOD";*;"INIT";Form:C1466)
	
End if 
