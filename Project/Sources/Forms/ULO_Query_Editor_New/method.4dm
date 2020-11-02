C_LONGINT:C283($vl_fia)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(at_tableName;0)
		ARRAY LONGINT:C221(al_tableNum;0)
		
		COLLECTION TO ARRAY:C1562(Form:C1466.linkedTables;at_tableName;"tableName";al_tableNum;"tableNum")
		
		COPY ARRAY:C226(at_tableName;OBJECT Get pointer:C1124(Object named:K67:5;"tableList")->)
		
		$vl_fia:=Find in array:C230(al_tableNum;Form:C1466.tableNumber)
		If ($vl_fia>0)
			OBJECT Get pointer:C1124(Object named:K67:5;"tableList")->:=$vl_fia
		End if 
		
		EXECUTE METHOD IN SUBFORM:C1085("queryLines";"QE_LINES_METHOD";*;"INIT";Form:C1466)
		
End case 
