//%attributes = {}
C_OBJECT:C1216($1)
C_LONGINT:C283($vl_event)
C_TEXT:C284($vt_objectName)
C_VARIANT:C1683($vv_value)
$vl_event:=$1.code
$vt_objectName:=$1.objectName
Case of 
	: ($vl_event=On Data Change:K2:15)
		If (OBJECT Get pointer:C1124(Object named:K67:5;$vt_objectName)->#"")
			$vt_queryString:="name = :1 | id = :1"
			Form:C1466.uloList:=ds:C1482["test"].query($vt_queryString;$vv_value)
			
		End if 
		
End case 