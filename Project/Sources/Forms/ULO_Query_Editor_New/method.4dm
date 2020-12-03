C_LONGINT:C283($vl_fia)
C_TEXT:C284(vt_loadMenu)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.tableName:=""
		
		ULO_SET_BACKGROUND 
		
		ARRAY TEXT:C222($at_tableName;0)
		ARRAY LONGINT:C221($al_tableNum;0)
		
		COLLECTION TO ARRAY:C1562(Form:C1466.linkedTables;$at_tableName;"tableName";$al_tableNum;"tableNum")
		
		COPY ARRAY:C226($at_tableName;OBJECT Get pointer:C1124(Object named:K67:5;"tableList")->)
		
		$vl_fia:=Find in array:C230($al_tableNum;Form:C1466.tableNumber)
		If ($vl_fia>0)
			OBJECT Get pointer:C1124(Object named:K67:5;"tableList")->:=$vl_fia
			Form:C1466.tableName:=$at_tableName{$vl_fia}
		End if 
		
		EXECUTE METHOD IN SUBFORM:C1085("queryLines";"QE_LINES_METHOD";*;"INIT";Form:C1466)
		
		vt_loadMenu:=QE_BUILD_LOAD_MENU (Form:C1466.tableNumber)
		
		Form:C1466.selectedQuery:=New object:C1471
		
	: (Form event code:C388=On Unload:K2:2)
		RELEASE MENU:C978(vt_loadMenu)
		
End case 
