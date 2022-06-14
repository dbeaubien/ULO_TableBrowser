//%attributes = {"shared":true}
//Not sure if this should be using storage or form data
C_COLLECTION:C1488($1)
C_OBJECT:C1216($vo_button)
C_TEXT:C284($vt_button; $vt_buttonBG; $vt_format)
C_LONGINT:C283($vl_findWidth; $l; $t; $r; $b; $lx; $tx; $rx; $bx; $vl_moveBy; $vl_number)

For each ($vo_button; $1)
	Case of 
		: ($vo_button.action="SAVERECORD")
			$vt_button:="UEO_Button_SAVERECORD"
			$vt_buttonBG:="UEO_ButtonBG_SAVERECORD"
			
		: ($vo_button.action="CANCELRECORD")
			$vt_button:="UEO_Button_CANCELRECORD"
			$vt_buttonBG:="UEO_ButtonBG_CANCELRECORD"
			
		: ($vo_button.action="FIRSTRECORD")
			$vt_button:="UEO_Button_FIRSTRECORD"
			$vt_buttonBG:="UEO_ButtonBG_FIRSTRECORD"
			
		: ($vo_button.action="LASTRECORD")
			$vt_button:="UEO_Button_LASTRECORD"
			$vt_buttonBG:="UEO_ButtonBG_LASTRECORD"
			
		: ($vo_button.action="NEXTRECORD")
			$vt_button:="UEO_Button_NEXTRECORD"
			$vt_buttonBG:="UEO_ButtonBG_NEXTRECORD"
			
		: ($vo_button.action="PREVIOUSRECORD")
			$vt_button:="UEO_Button_PREVIOUSRECORD"
			$vt_buttonBG:="UEO_ButtonBG_PREVIOUSRECORD"
			
		: ($vo_button.action="PRINT")
			$vt_button:="UEO_Button_PRINT"
			$vt_buttonBG:="UEO_ButtonBG_PRINT"
			
		: ($vo_button.action="DELETE")
			$vt_button:="UEO_Button_DELETE"
			$vt_buttonBG:="UEO_ButtonBG_DELETE"
			
		: ($vo_button.action="HISTORY")
			$vt_button:="UEO_Button_HISTORY"
			$vt_buttonBG:="UEO_ButtonBG_HISTORY"
			
		Else 
			If ($vo_button.position="right")
				$vl_number:=$vo_button.numberRight
			Else 
				$vl_number:=$vo_button.numberLeft
			End if 
			$vt_button:="UEO_Button_"+$vo_button.position+"_"+String:C10($vl_number; "00")
			$vt_buttonBG:="UEO_ButtonBG_"+$vo_button.position+"_"+String:C10($vl_number; "00")
	End case 
	//Use ($vo_button)
	$vo_button.reference:=$vt_button
	//End use 
	
/*Create a copy of the button
determine if it should be placed on the right (default) or left
This might be easier with two buttons one on left and one on right.
*/
	OBJECT DUPLICATE:C1111(*; "UEO_Button_00"; $vt_button)
	$vl_moveBy:=-(($vo_button.numberRight*70)+$vl_findWidth)  //Default if placing backwards from right.
	If (OB Is defined:C1231($vo_button; "position"))
		If ($vo_button.position="left")
			//First have to calculate left start
			$vl_moveBy:=($vo_button.numberLeft*70)+$vl_findWidth  //Default if placing from left.
			OBJECT MOVE:C664(*; $vt_button; 10; 7; 55; 48; *)  //First move it to the far left
		End if 
	End if 
	OBJECT MOVE:C664(*; $vt_button; $vl_moveBy; 0)  //Move by offset specified.
	OBJECT SET VISIBLE:C603(*; $vt_button; True:C214)
	
	If (OB Is defined:C1231($vo_button; "icon"))  //Should always be defined but could be empty
		If ($vo_button.icon#"")
			$vt_format:=$vo_button.title+";"+"#images/buttons/"+Storage:C1525.prefs.theme+"/input/"+$vo_button.icon+";;4;1;1;4;0;0;0;0;;4"
		Else 
			$vt_format:=$vo_button.title+";;;4;1;1;3;0;0;0;0;;0"
		End if 
	Else 
		$vt_format:=$vo_button.title+";;;4;1;1;3;0;0;0;0;;0"
	End if 
	OBJECT SET FORMAT:C236(*; $vt_button; $vt_format)
	OBJECT SET HELP TIP:C1181(*; $vt_button; $vo_button.tooltip)
	//Else 
	//OBJECT SET TITLE(*; $vt_button; $vo_button.title)
	//End if 
	If (OB Is defined:C1231($vo_button; "colour"))
		OBJECT SET RGB COLORS:C628(*; $vt_button; $vo_button.fontColour; $vo_button.colour)
	End if 
	If (OB Is defined:C1231($vo_button; "contextMenu"))
		OBJECT SET CONTEXT MENU:C1251(*; $vt_button; $vo_button.contextMenu)
	End if 
	If (OB Is defined:C1231($vo_button; "shortcutKey")) & (OB Is defined:C1231($vo_button; "shortcutModifiers"))
		OBJECT SET SHORTCUT:C1185(*; $vt_button; $vo_button.shortcutKey; $vo_button.shortcutModifiers)
	End if 
	
End for each 

