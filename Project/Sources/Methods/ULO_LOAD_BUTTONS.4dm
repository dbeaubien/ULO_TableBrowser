//%attributes = {}
  //Not sure if this should be using storage or form data
C_COLLECTION:C1488($1)
C_OBJECT:C1216($vo_button)
C_TEXT:C284($vt_button;$vt_buttonBG;$vt_format)
C_LONGINT:C283($vl_findWidth)

For each ($vo_button;$1)
	Case of 
		: ($vo_button.action="FIND")
			$vl_findWidth:=201-70
			OBJECT MOVE:C664(*;"ULO_DEFAULT_FIND";($vo_button.number*70);14;($vo_button.number*70)+201;43;*)
			
		Else 
			Case of 
				: ($vo_button.action="NEWRECORD")
					$vt_button:="ULO_Button_NEWRECORD"
					$vt_buttonBG:="ULO_ButtonBG_NEWRECORD"
					
				: ($vo_button.action="VIEWS")
					$vt_button:="ULO_Button_VIEW"
					$vt_buttonBG:="ULO_ButtonBG_VIEW"
					
				: ($vo_button.action="PRINT")
					$vt_button:="ULO_Button_PRINT"
					$vt_buttonBG:="ULO_ButtonBG_PRINT"
					
				: ($vo_button.action="SHOWALL")
					$vt_button:="ULO_Button_SHOWALL"
					$vt_buttonBG:="ULO_ButtonBG_SHOWALL"
					
				: ($vo_button.action="SHOWSUBSET")
					$vt_button:="ULO_Button_SHOWSUBSET"
					$vt_buttonBG:="ULO_ButtonBG_SHOWSUBSET"
					
				: ($vo_button.action="OMITSUBSET")
					$vt_button:="ULO_Button_OMITSUBSET"
					$vt_buttonBG:="ULO_ButtonBG_OMITSUBSET"
					
				: ($vo_button.action="SEARCH")
					$vt_button:="ULO_Button_SEARCH"
					$vt_buttonBG:="ULO_ButtonBG_SEARCH"
					
				: ($vo_button.action="SORT")
					$vt_button:="ULO_Button_SORT"
					$vt_buttonBG:="ULO_ButtonBG_SORT"
					
				: ($vo_button.action="ACTIONS")
					$vt_button:="ULO_Button_ACTIONS"
					$vt_buttonBG:="ULO_ButtonBG_ACTIONS"
					
				: ($vo_button.action="ADVANCED")
					$vt_button:="ULO_Button_ADVANCED"
					$vt_buttonBG:="ULO_ButtonBG_ADVANCED"
					
				: ($vo_button.action="RELATE")
					$vt_button:="ULO_Button_RELATE"
					$vt_buttonBG:="ULO_ButtonBG_RELATE"
					
				: ($vo_button.action="SET")
					$vt_button:="ULO_Button_SETS"
					$vt_buttonBG:="ULO_ButtonBG_SETS"
					
				Else 
					$vt_button:="ULO_Button_"+String:C10($vo_button.number;"00")
					$vt_buttonBG:="ULO_ButtonBG_"+String:C10($vo_button.number;"00")
			End case 
			Use ($vo_button)
				$vo_button.reference:=$vt_button
			End use 
			  //If ($vo_button.number>0)
			  //OBJECT DUPLICATE(*;"ULO_ButtonBG_00";$vt_buttonBG)  //Duplicate the backgroud first
			OBJECT DUPLICATE:C1111(*;"ULO_Button_00";$vt_button)
			  //OBJECT MOVE(*;$vt_buttonBG;($vo_button.number*70);0)
			OBJECT MOVE:C664(*;$vt_button;($vo_button.number*70)+$vl_findWidth;0)
			  //End if 
			OBJECT SET VISIBLE:C603(*;$vt_button;True:C214)
			  //OBJECT SET VISIBLE(*;$vt_buttonBG;True)
			
			  //Format: title;picture;background;titlePos(4=bottom);titleVisible(1=display);\
																				iconVisible(1=display);style(3=toolbarButton);horMargin;vertMargin;iconOffset;popupMenu;hyperlink;numStates
			
			If (OB Is defined:C1231($vo_button;"icon"))
				$vt_format:=$vo_button.title+";"+"#images/buttons/"+Storage:C1525.prefs.theme+"/"+$vo_button.icon+";;4;1;1;4;0;0;0;0;;4"
			Else 
				$vt_format:=$vo_button.title+";;;4;1;1;3;0;0;0;0;;0"
			End if 
			OBJECT SET FORMAT:C236(*;$vt_button;$vt_format)
			OBJECT SET HELP TIP:C1181(*;$vt_button;$vo_button.tooltip)
			  //Else 
			  //OBJECT SET TITLE(*;$vt_button;$vo_button.title)
			  //End if 
			If (OB Is defined:C1231($vo_button;"colour"))
				OBJECT SET RGB COLORS:C628(*;$vt_button;$vo_button.fontColour;$vo_button.colour)
			End if 
			If (OB Is defined:C1231($vo_button;"contextMenu"))
				OBJECT SET CONTEXT MENU:C1251(*;$vt_button;$vo_button.contextMenu)
			End if 
			If (OB Is defined:C1231($vo_button;"shortcutKey")) & (OB Is defined:C1231($vo_button;"shortcutModifiers"))
				OBJECT SET SHORTCUT:C1185(*;$vt_button;$vo_button.shortcutKey;$vo_button.shortcutModifiers)
			End if 
			
			
	End case 
End for each 

