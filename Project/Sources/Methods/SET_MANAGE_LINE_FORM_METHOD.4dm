//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 21/02/20, 12:18:54
  // ----------------------------------------------------
  // Method: SET_MANAGE_LINE_FORM_METHOD
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($1;$vo_formEvent;$vo_data;$vo_field;$vo_col;$vo_object)
C_COLLECTION:C1488($vc_cols)
C_TEXT:C284($vt_objectName;$vt_suffix)
C_LONGINT:C283($vl_dropPos;$vl_startPos;$vl_idx;$vl_row;$vl_col;$vl_vertAdjust;\
$i;$vl_targetY)
C_BOOLEAN:C305($vb_lastLine)

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
				
				ARRAY TEXT:C222($at_setName;0)
				ARRAY TEXT:C222($at_operation;0)
				
				COLLECTION TO ARRAY:C1562(Form:C1466.userSets;$at_setName;"name")
				
				COPY ARRAY:C226($at_setName;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_set_000")->)
				
				COLLECTION TO ARRAY:C1562(Form:C1466.operations;$at_operation)
				
				COPY ARRAY:C226($at_operation;OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_operation_000")->)
				
				
		End case 
		
	: ($vt_objectName="dropdown_set@")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				$vt_suffix:=Replace string:C233($vt_objectName;"dropdown_set_";"")
				
				$vl_idx:=UTIL_Col_Find_Index (Form:C1466.manipLines;"id";$vt_suffix)
				If ($vl_idx>=0)
					Form:C1466.manipLines[$vl_idx].set:=at_setId{OBJECT Get pointer:C1124(Object named:K67:5;$vt_objectName)->}
				End if 
		End case 
		
		
	: ($vt_objectName="dropdown_operation@")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				$vt_suffix:=Replace string:C233($vt_objectName;"dropdown_operation_";"")
				
				$vl_idx:=UTIL_Col_Find_Index (Form:C1466.manipLines;"id";$vt_suffix)
				If ($vl_idx>=0)
					Form:C1466.manipLines[$vl_idx].operation:=OBJECT Get pointer:C1124(Object named:K67:5;$vt_objectName)->{OBJECT Get pointer:C1124(Object named:K67:5;$vt_objectName)->}
				End if 
		End case 
		
	: ($vt_objectName="bt_delete@")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$vl_vertAdjust:=44
				
				$vt_suffix:=Replace string:C233($vt_objectName;"bt_delete_";"")
				  //hide objects, remove from collection, move objects below up a level :O
				Form:C1466.actualLineCount:=Form:C1466.actualLineCount-1
				$vl_idx:=UTIL_Col_Find_Index (Form:C1466.manipLines;"id";$vt_suffix)
				$vb_lastLine:=($vl_idx=(Form:C1466.manipLines.length-1))
				If ($vl_idx>=0)
					Form:C1466.manipLines.remove($vl_idx;1)
				End if 
				
				$vl_idx:=UTIL_Col_Find_Index (Form:C1466.objectTracker;"id";$vt_suffix)
				If ($vl_idx>=0)
					Form:C1466.objectTracker[$vl_idx].inUse:=False:C215
				End if 
				
				OBJECT SET VISIBLE:C603(*;"@_"+$vt_suffix;False:C215)
				
				If (Not:C34($vb_lastLine))
					$i:=0
					For each ($vo_object;Form:C1466.objectTracker)
						If ($vo_object.inUse)
							OBJECT GET COORDINATES:C663(*;"dropdown_set_"+$vo_object.id;$vl_l;$vl_t;$vl_r;$vl_b)
							$vl_targetY:=($i*$vl_vertAdjust)+20
							
							OBJECT MOVE:C664(*;"@_"+$vo_object.id;0;($vl_targetY-$vl_t))
							$i:=$i+1
						End if 
					End for each 
					
					
				End if 
				
		End case 
		
		
		
End case 