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
C_LONGINT:C283($i;vl_fontColour;$vl_newColour)

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
				ULO_SET_LIST_COLOURS ("lb_theme")
				ULO_SET_BACKGROUND 
				THEME_MANAGE_SET_ENABLED 
		End case 
		
	: ($vt_objectName="bt_preview")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				ULO_APPLY_THEME ("lb_preview";Form:C1466.workingTheme.detail.theme;True:C214)
				
		End case 
		
	: ($vt_objectName="bt_colour@")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$vt_prop:=Replace string:C233($vt_objectName;"bt_colour_";"")
				$vl_newColour:=Select RGB color:C956(Form:C1466.workingTheme.detail.theme[$vt_prop])
				If ($vl_newColour#-1)
					Form:C1466.workingTheme.detail.theme[$vt_prop]:=$vl_newColour
					Form:C1466.workingTheme.detail.theme[$vt_prop+"Hex"]:=UTIL_Get_Hex ($vl_newColour)
					OBJECT SET RGB COLORS:C628(*;"rect_"+$vt_prop;$vl_newColour;$vl_newColour)
				End if 
		End case 
		
	: ($vt_objectName="input_colour_@")
		Case of 
			: ($vo_formEvent.code=On Data Change:K2:15)
				$vt_prop:=Replace string:C233($vt_objectName;"input_colour_";"")
				EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme[$vt_prop+"Hex"])
				Form:C1466.workingTheme.detail.theme[$vt_prop]:=vl_fontColour
				OBJECT SET RGB COLORS:C628(*;"rect_"+$vt_prop;vl_fontColour;vl_fontColour)
				
		End case 
		
	: ($vt_objectName="lb_theme")
		
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				If (Form:C1466.workingTheme#Null:C1517)
					Form:C1466.workingTheme.save()
				End if 
				
				If (Form:C1466.selectedTheme#Null:C1517)
					Form:C1466.workingTheme:=Form:C1466.selectedTheme
					Form:C1466.workingThemeIndex:=Form:C1466.selectedThemeIndex
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.hLineColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_hLineColour";vl_fontColour;vl_fontColour)
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.vLineColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_vLineColour";vl_fontColour;vl_fontColour)
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.headerFontColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_headerFontColour";vl_fontColour;vl_fontColour)
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.headerBgColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_headerBgColour";vl_fontColour;vl_fontColour)
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.rowColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_rowColour";vl_fontColour;vl_fontColour)
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.rowAltColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_rowAltColour";vl_fontColour;vl_fontColour)
					
					EXECUTE FORMULA:C63("vl_fontColour:=0x00"+Form:C1466.workingTheme.detail.theme.rowFontColourHex)
					OBJECT SET RGB COLORS:C628(*;"rect_rowFontColour";vl_fontColour;vl_fontColour)
					
					ULO_APPLY_THEME ("lb_preview";Form:C1466.workingTheme.detail.theme;True:C214)
				Else 
					Form:C1466.workingTheme:=Null:C1517
					Form:C1466.workingThemeIndex:=0
				End if 
				THEME_MANAGE_SET_ENABLED 
				
			: ($vo_formEvent.code=On Data Change:K2:15)
				For each ($e_uloData;Form:C1466.themes)
					If ($e_uloData.user=Storage:C1525.user.id)
						If ($e_uloData.id#Form:C1466.selectedTheme.id)
							$e_uloData.default:=False:C215
							$e_uloData.save()
						End if 
					End if 
				End for each 
				
		End case 
		
	: ($vt_objectName="bt_deleteTheme")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				CONFIRM:C162("Are you sure you wish to delete the Theme "+Form:C1466.workingTheme.name+"?")
				If (OK=1)
					Form:C1466.workingTheme.drop()
					Form:C1466.workingTheme:=Null:C1517
					
					Form:C1466.themes:=ds:C1482["uloData"].query("type == 3 && user == :1";Storage:C1525.user.id)
					If (Storage:C1525.user.id=1) & (Form:C1466.systemDefault#Null:C1517)  //If designer, get system theme
						Form:C1466.themes.add(Form:C1466.systemDefault)
					End if 
					LISTBOX SELECT ROW:C912(*;"lb_theme";0;lk remove from selection:K53:3)
					THEME_MANAGE_SET_ENABLED 
				End if 
				
		End case 
		
	: ($vt_objectName="bt_addTheme")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$e_uloData:=ds:C1482["uloData"].new()
				$e_uloData.user:=Storage:C1525.user.id
				$e_uloData.name:="New Theme"
				$e_uloData.type:=3
				$e_uloData.detail:=New object:C1471
				If (Form:C1466.systemDefault#Null:C1517)
					$e_uloData.detail.theme:=OB Copy:C1225(Form:C1466.systemDefault.detail.theme)
				Else 
					$e_uloData.detail.theme:=New object:C1471
					$e_uloData.detail.theme.hLineColour:=0x0000
					$e_uloData.detail.theme.hLineColourHex:="000000"
					$e_uloData.detail.theme.vLineColour:=0x0000
					$e_uloData.detail.theme.vLineColourHex:="000000"
					$e_uloData.detail.theme.showHLine:=True:C214
					$e_uloData.detail.theme.showVLine:=True:C214
					
					$e_uloData.detail.theme.rowFontColour:=0x0000
					$e_uloData.detail.theme.rowFontColourHex:="000000"
					$e_uloData.detail.theme.rowColour:=0x00FFFFFF
					$e_uloData.detail.theme.rowColourHex:="FFFFFF"
					$e_uloData.detail.theme.rowAltColour:=0x00AAAAAA
					$e_uloData.detail.theme.rowAltColourHex:="AAAAAA"
					$e_uloData.detail.theme.rowFontSize:=10
					$e_uloData.detail.theme.rowFont:="Segoe UI"
					
					$e_uloData.detail.theme.headerBgColour:=0x00FFFFFF
					$e_uloData.detail.theme.headerBgColourHex:="FFFFFF"
					$e_uloData.detail.theme.headerFontColour:=0x0000
					$e_uloData.detail.theme.headerFontColourHex:="000000"
					$e_uloData.detail.theme.headerFontSize:=11
					$e_uloData.detail.theme.headerFont:="Segoe UI"
				End if 
				$e_uloData.save()
				Form:C1466.themes.add($e_uloData)
				Form:C1466.themes:=Form:C1466.themes
		End case 
		
End case 
