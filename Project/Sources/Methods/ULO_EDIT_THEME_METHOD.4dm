//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 23/01/20, 12:51:51
  // ----------------------------------------------------
  // Method: ULO_EDIT_THEME_METHOD
  // Description
  // Form method for `ULO_EDIT_THEME`
  //
  // Parameters
  // $1 - Object - Form Event obj
  // ----------------------------------------------------


C_OBJECT:C1216($1;$vo_formEvent;$vo_data)
C_COLLECTION:C1488($vc_text)
C_TEXT:C284($vt_objectName;$vt_prop)
C_LONGINT:C283($i;$vl_fontColour;$vl_newColour)

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
				  //Generate example data for preview List box
				Form:C1466.data:=New collection:C1472
				$vc_text:=New collection:C1472("Apple";"Banana";"Pear";"Orange";"Peach";"Watermelon";"Mango";"Kiwi";"Strawberry")
				For ($i;1;70)
					$vo_data:=New object:C1471
					$vo_data.number:=(Random:C100%(10000-1+1))+1
					$vo_data.text:=$vc_text[(Random:C100%(($vc_text.length-2)+1))+1]
					$vo_data.date:=Date:C102(String:C10((Random:C100%(28-1+1))+1)+"/"+String:C10((Random:C100%(12-1+1))+1)+"/"+String:C10((Random:C100%(10000-1+1))))
					Form:C1466.data.push(OB Copy:C1225($vo_data))
				End for 
				ULO_APPLY_THEME ("lb_preview";Form:C1466.theme;True:C214)
				ULO_SET_BACKGROUND 
				
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.hLineColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_hLineColour";$vl_fontColour;$vl_fontColour)
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.vLineColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_vLineColour";$vl_fontColour;$vl_fontColour)
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.headerFontColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_headerFontColour";$vl_fontColour;$vl_fontColour)
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.headerBgColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_headerBgColour";$vl_fontColour;$vl_fontColour)
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.rowColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_rowColour";$vl_fontColour;$vl_fontColour)
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.rowAltColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_rowAltColour";$vl_fontColour;$vl_fontColour)
				
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme.rowFontColourHex)
				OBJECT SET RGB COLORS:C628(*;"rect_rowFontColour";$vl_fontColour;$vl_fontColour)
				
		End case 
		
	: ($vt_objectName="bt_preview")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				ULO_APPLY_THEME ("lb_preview";Form:C1466.theme;True:C214)
				
		End case 
		
	: ($vt_objectName="bt_colour@")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$vt_prop:=Replace string:C233($vt_objectName;"bt_colour_";"")
				$vl_newColour:=Select RGB color:C956(Form:C1466.theme[$vt_prop])
				Form:C1466.theme[$vt_prop]:=$vl_newColour
				Form:C1466.theme[$vt_prop+"Hex"]:=UTIL_Get_Hex ($vl_newColour)
				OBJECT SET RGB COLORS:C628(*;"rect_"+$vt_prop;$vl_newColour;$vl_newColour)
		End case 
		
	: ($vt_objectName="input_colour_@")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				$vt_prop:=Replace string:C233($vt_objectName;"input_colour_";"")
				EXECUTE FORMULA:C63("$vl_fontColour:=0x00"+Form:C1466.theme[$vt_prop+"Hex"])
				Form:C1466.theme[$vt_prop]:=$vl_fontColour
				OBJECT SET RGB COLORS:C628(*;"rect_"+$vt_prop;$vl_fontColour;$vl_fontColour)
				
		End case 
		
End case 