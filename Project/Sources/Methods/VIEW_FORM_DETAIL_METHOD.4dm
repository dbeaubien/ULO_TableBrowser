//%attributes = {}
C_OBJECT:C1216($1;$vo_formEvent)
C_TEXT:C284($vt_objectName;$vt_prop)
C_LONGINT:C283($vl_newColour;$vl_fontColour)

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
				  //TRACE
				
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
				
				OBJECT SET ENTERABLE:C238(*;"input_formula";(Form:C1466.col.table<=0))  //Non enterable if table is positive
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.col.fontColourHex)
				
				OBJECT SET RGB COLORS:C628(*;"rect_fontColour";$vl_fontColour;$vl_fontColour)
				
				
		End case 
		
	: ($vt_objectName="input_fontColourHex")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.col.fontColourHex)
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
		
		
End case 