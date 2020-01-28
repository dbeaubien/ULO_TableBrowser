//%attributes = {}
C_OBJECT:C1216($1;$vo_formEvent)
C_TEXT:C284($vt_objectName;$vt_prop)
C_LONGINT:C283($vl_newColour;$vl_fontColour)
C_BOOLEAN:C305($vb_formula)

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
				ARRAY TEXT:C222(at_dataType;0)
				ARRAY LONGINT:C221(al_dataType;0)
				
				APPEND TO ARRAY:C911(at_dataType;"Alpha")
				APPEND TO ARRAY:C911(at_dataType;"Text")
				APPEND TO ARRAY:C911(at_dataType;"Integer")
				APPEND TO ARRAY:C911(at_dataType;"Real")
				APPEND TO ARRAY:C911(at_dataType;"Date")
				APPEND TO ARRAY:C911(at_dataType;"Boolean")
				APPEND TO ARRAY:C911(at_dataType;"Picture")
				APPEND TO ARRAY:C911(at_dataType;"Time")
				APPEND TO ARRAY:C911(at_dataType;"Object")
				APPEND TO ARRAY:C911(at_dataType;"Blob")
				
				APPEND TO ARRAY:C911(al_dataType;Is alpha field:K8:1)
				APPEND TO ARRAY:C911(al_dataType;Is text:K8:3)
				APPEND TO ARRAY:C911(al_dataType;Is longint:K8:6)
				APPEND TO ARRAY:C911(al_dataType;Is real:K8:4)
				APPEND TO ARRAY:C911(al_dataType;Is date:K8:7)
				APPEND TO ARRAY:C911(al_dataType;Is boolean:K8:9)
				APPEND TO ARRAY:C911(al_dataType;Is picture:K8:10)
				APPEND TO ARRAY:C911(al_dataType;Is time:K8:8)
				APPEND TO ARRAY:C911(al_dataType;Is object:K8:27)
				APPEND TO ARRAY:C911(al_dataType;Is BLOB:K8:12)
				
				SORT ARRAY:C229(at_dataType;al_dataType;>)
				
				at_dataType:=Find in array:C230(al_dataType;Form:C1466.col.fieldType)
				$vb_formula:=(Form:C1466.col.table<=0)  //Column is a custom formula is table is < 1
				
				Form:C1466.total:=Num:C11(Form:C1466.col.total)
				Form:C1466.average:=Num:C11(Form:C1466.col.average)
				Form:C1466.min:=Num:C11(Form:C1466.col.min)
				Form:C1466.max:=Num:C11(Form:C1466.col.max)
				
				Form:C1466.bold:=0
				Form:C1466.italic:=0
				Form:C1466.underline:=0
				  //Font style checkboxes
				Case of 
					: (Form:C1466.col.fontStyle=0)
						
					: (Form:C1466.col.fontStyle=1)
						Form:C1466.bold:=1
						
					: (Form:C1466.col.fontStyle=2)
						Form:C1466.italic:=1
						
					: (Form:C1466.col.fontStyle=3)
						Form:C1466.bold:=1
						Form:C1466.italic:=1
						
					: (Form:C1466.col.fontStyle=4)
						Form:C1466.underline:=1
						
					: (Form:C1466.col.fontStyle=5)
						Form:C1466.bold:=1
						Form:C1466.underline:=1
						
					: (Form:C1466.col.fontStyle=6)
						Form:C1466.italic:=1
						Form:C1466.underline:=1
						
					: (Form:C1466.col.fontStyle=7)
						Form:C1466.bold:=1
						Form:C1466.italic:=1
						Form:C1466.underline:=1
						
				End case 
				
				Case of 
					: (Form:C1466.col.alignment="Left")
						Form:C1466.alignLeft:=1
					: (Form:C1466.col.alignment="Right")
						Form:C1466.alignRight:=1
					: (Form:C1466.col.alignment="Center")
						Form:C1466.alignCenter:=1
				End case 
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.col.fontColourHex)
				
				OBJECT SET ENTERABLE:C238(*;"input_formula";$vb_formula)
				OBJECT SET ENABLED:C1123(*;"dropdown_datatype";$vb_formula)
				OBJECT SET RGB COLORS:C628(*;"rect_fontColour";$vl_fontColour;$vl_fontColour)
				OBJECT SET ENABLED:C1123(*;"cb_agg_@";False:C215)
				
				Case of 
					: (Form:C1466.col.table=-1)  //All disabled when custom formula
					: (Form:C1466.col.fieldType=Is integer:K8:5) | (Form:C1466.col.fieldType=Is real:K8:4) | (Form:C1466.col.fieldType=Is longint:K8:6)
						OBJECT SET ENABLED:C1123(*;"cb_agg_@";True:C214)
						
					: (Form:C1466.col.fieldType=Is date:K8:7) | (Form:C1466.col.fieldType=Is time:K8:8)
						OBJECT SET ENABLED:C1123(*;"cb_agg_max";True:C214)
						OBJECT SET ENABLED:C1123(*;"cb_agg_min";True:C214)
						
					: (Form:C1466.col.fieldType=Is boolean:K8:9)
						OBJECT SET ENABLED:C1123(*;"cb_agg_total";True:C214)
				End case 
				
				
				
		End case 
		
	: ($vt_objectName="input_fontColourHex")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.col.fontColourHex)
				Form:C1466.col.fontColour:=$vl_fontColour
				OBJECT SET RGB COLORS:C628(*;"rect_fontColour";$vl_fontColour;$vl_fontColour)
		End case 
		
		
	: ($vt_objectName="bt_fontColourPick")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.col.fontColourHex)
				$vl_newColour:=Select RGB color:C956($vl_fontColour)
				Form:C1466.col.fontColourHex:=UTIL_Get_Hex ($vl_newColour)
				Form:C1466.col.fontColour:=$vl_newColour
				OBJECT SET RGB COLORS:C628(*;"rect_fontColour";$vl_newColour;$vl_newColour)
		End case 
		
	: ($vt_objectName="rb_@")  //Alignment radio buttons
		
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				Case of 
					: ($vt_objectName="rb_left")
						Form:C1466.col.alignment:="Left"
					: ($vt_objectName="rb_center")
						Form:C1466.col.alignment:="Center"
					: ($vt_objectName="rb_right")
						Form:C1466.col.alignment:="Right"
				End case 
				
				
		End case 
		
		
		
	: ($vt_objectName="cb_agg_@")  //Aggergate checkboxes
		
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$vt_prop:=Replace string:C233($vt_objectName;"cb_agg_";"")
				Form:C1466.col[$vt_prop]:=(Form:C1466[$vt_prop]=1)
				
		End case 
		
	: ($vt_objectName="dropdown_datatype")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15) | ($vo_formEvent.code=On Clicked:K2:4)
				Form:C1466.col.fieldType:=al_dataType{at_dataType}
				
				  //Update aggregate check boxes according to selected type.
				  //Clear selected aggregates where it no longer applies
				
				OBJECT SET ENABLED:C1123(*;"cb_agg_@";False:C215)
				Case of 
					: (Form:C1466.col.table=-1)
					: (Form:C1466.col.fieldType=Is integer:K8:5) | (Form:C1466.col.fieldType=Is real:K8:4)
						OBJECT SET ENABLED:C1123(*;"cb_agg_@";True:C214)
						
					: (Form:C1466.col.fieldType=Is date:K8:7) | (Form:C1466.col.fieldType=Is time:K8:8)
						OBJECT SET ENABLED:C1123(*;"cb_agg_max";True:C214)
						OBJECT SET ENABLED:C1123(*;"cb_agg_min";True:C214)
						Form:C1466.col.total:=False:C215
						Form:C1466.col.average:=False:C215
						
					: (Form:C1466.col.fieldType=Is boolean:K8:9)
						OBJECT SET ENABLED:C1123(*;"cb_agg_total";True:C214)
						Form:C1466.col.min:=False:C215
						Form:C1466.col.max:=False:C215
						Form:C1466.col.average:=False:C215
						
					Else 
						Form:C1466.col.min:=False:C215
						Form:C1466.col.max:=False:C215
						Form:C1466.col.average:=False:C215
						Form:C1466.col.total:=False:C215
				End case 
				Form:C1466.total:=Num:C11(Form:C1466.col.total)
				Form:C1466.average:=Num:C11(Form:C1466.col.average)
				Form:C1466.min:=Num:C11(Form:C1466.col.min)
				Form:C1466.max:=Num:C11(Form:C1466.col.max)
				
		End case 
		
End case 