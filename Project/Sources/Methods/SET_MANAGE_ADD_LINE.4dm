//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 21/02/20, 12:50:52
  // ----------------------------------------------------
  // Method: SET_MANAGE_ADD_LINE
  // Description
  // Adds new line to Subform
  //
  // Parameters
  // ----------------------------------------------------
C_LONGINT:C283($vl_vertAdjust;$vl_l;$vl_t;$vl_r;$vl_b;$vl_idx;$vl_targetY)
C_TEXT:C284($vt_dest;$vt_object;$vt_source)
C_COLLECTION:C1488($vc_objects;$vc_tracker)

$vl_vertAdjust:=44
$vt_source:="000"
$vc_objects:=New collection:C1472("txt_result_";"box_text_";"dropdown_operation_";"dropdown_set_";"bt_delete_")

$vc_tracker:=Form:C1466.objectTracker.query("inUse == False")
Form:C1466.actualLineCount:=Form:C1466.actualLineCount+1

If ($vc_tracker.length>0)
	$vt_dest:=$vc_tracker[0].id
	
	$vl_idx:=UTIL_Col_Find_Index (Form:C1466.objectTracker;"id";$vt_dest)
	If ($vl_idx>=0)
		Form:C1466.objectTracker[$vl_idx].inUse:=True:C214
	End if 
	
	$vl_targetY:=((Form:C1466.actualLineCount-1)*$vl_vertAdjust)+20
	OBJECT GET COORDINATES:C663(*;"dropdown_set_"+$vt_dest;$vl_l;$vl_t;$vl_r;$vl_b)
	
	OBJECT MOVE:C664(*;"@_"+$vt_dest;0;($vl_targetY-$vl_t))
	
	OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_set_"+$vt_dest)->:=0
	OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_operation_"+$vt_dest)->:=0
	OBJECT SET VISIBLE:C603(*;"@_"+$vt_dest;True:C214)
	
Else 
	Form:C1466.lineCount:=Form:C1466.lineCount+1  //Separate counter that is never deducted to ensure objects always have unique name
	$vt_dest:=String:C10(Form:C1466.lineCount;"000")
	
	For each ($vt_object;$vc_objects)
		OBJECT DUPLICATE:C1111(*;$vt_object+$vt_source;$vt_object+$vt_dest)
	End for each 
	OBJECT MOVE:C664(*;"@_"+$vt_dest;0;(Form:C1466.actualLineCount-1)*$vl_vertAdjust)
	OBJECT SET VISIBLE:C603(*;"@_"+$vt_dest;True:C214)
	
	ARRAY TEXT:C222($at_setName;0)
	ARRAY TEXT:C222($at_operation;0)
	
	COLLECTION TO ARRAY:C1562(Form:C1466.userSets;$at_setName;"name")
	
	COPY ARRAY:C226($at_setName;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_set_"+$vt_dest)->)
	
	COLLECTION TO ARRAY:C1562(Form:C1466.operations;$at_operation)
	
	COPY ARRAY:C226($at_operation;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_operation_"+$vt_dest)->)
	
	Form:C1466.objectTracker.push(New object:C1471("id";$vt_dest;"inUse";True:C214))
	
End if 

Form:C1466.manipLines.push(New object:C1471("id";$vt_dest;"set";"";"operation";""))
