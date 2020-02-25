//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 21/02/20, 11:14:45
  // ----------------------------------------------------
  // Method: SET_MANAGE_FORM_METHOD
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($1;$vo_formEvent;$vo_data;$vo_field;$vo_col)
C_COLLECTION:C1488($vc_cols)
C_TEXT:C284($vt_objectName)
C_LONGINT:C283($vl_dropPos;$vl_startPos;$vl_idx;$vl_row;$vl_col)

$vo_formEvent:=$1
If (OB Is defined:C1231($vo_formEvent;"objectName"))
	$vt_objectName:=$vo_formEvent.objectName
Else 
	$vt_objectName:="form"
End if 


Case of 
	: ($vt_objectName="form")
		Case of 
			: ($vo_formEvent.code=On Load:K2:1)
				Form:C1466.newSetName:=""
				
				ULO_SET_BACKGROUND 
				
				ARRAY TEXT:C222($at_setName;0)
				ARRAY TEXT:C222($at_setName2;0)
				ARRAY TEXT:C222($at_operation;0)
				
				ARRAY TEXT:C222(at_setId;0)
				
				COLLECTION TO ARRAY:C1562(Form:C1466.userSets;$at_setName;"name";at_setId;"id")
				
				COPY ARRAY:C226($at_setName;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_setOrig1")->)
				COPY ARRAY:C226($at_setName;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_setOrig2")->)
				
				COLLECTION TO ARRAY:C1562(Form:C1466.operations;$at_operation)
				
				COPY ARRAY:C226($at_operation;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_operationOrig")->)
				
		End case 
		
		
		
	: ($vt_objectName="bt_runOperation")
		SET_MANAGE_RUN 
		
	: ($vt_objectName="bt_addLine")
		EXECUTE METHOD IN SUBFORM:C1085("sbfm_manipLines";"SET_MANAGE_ADD_LINE")
		
End case 