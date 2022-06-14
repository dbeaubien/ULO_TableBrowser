//%attributes = {"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 09/01/20, 10:31:24
// ----------------------------------------------------
// Method: UEO_SET_BUTTON
// Description
// 
//
// Parameters
// $1 = Button Action (text) "New Record"
// $2 = Button Text (text) "New"
// $3 = Button Tooltip (text) "Add a new record"
// $4 = Button icon (text) - Image pulled relative to theme
// $5 = Popup Symbol (boolean) True/False
// $6 = Shortcut Character (text) "N"
// $7 = Shortcut Modifiers (number) 
// $8 = Button Colour (number) 
// $9 = Font Colour (number) 
// $10 = Custom Method (text) 
// $11 = Button Type
// ----------------------------------------------------

C_COLLECTION:C1488(vc_buttons)
C_OBJECT:C1216($vo_button)
C_TEXT:C284($1; $2; $3; $4; $6; $10; $11)
C_BOOLEAN:C305($5)
C_LONGINT:C283($7; $8; $9; $cp)

$cp:=Count parameters:C259
If ($cp>11) | ($cp=0)
	//return an error for incorrect number of parameters
Else 
	If ($1="INIT")  //Call with clear any existing buttons from storage
		vc_buttons:=New collection:C1472
	Else 
		vc_buttons:=vc_buttons  //Storage.inputButtons
		$vo_button:=New object:C1471
		//Use ($vo_button)
		//$vo_button.number:=vc_buttons.length
		$vo_button.action:=$1
		If ($cp>1)
			$vo_button.title:=$2
		Else 
			$vo_button.title:=$1
		End if 
		If ($cp>2)
			$vo_button.tooltip:=$3
		Else 
			$vo_button.tooltip:=$1
		End if 
		If ($cp>3)
			$vo_button.icon:=$4
		End if 
		If ($vo_button.icon="")
			$vo_button.icon:=BUTTON_Defaults("ICON"; $1)
		End if 
		If ($cp>4)
			$vo_button.popup:=$5
		End if 
		If ($cp>5)
			$vo_button.shortcutKey:=$6
		End if 
		If ($cp>6)
			$vo_button.shortcutModifiers:=$7
		End if 
		If ($cp>7)
			$vo_button.colour:=$8
		Else 
			$vo_button.colour:=BUTTON_Defaults("COLOUR")
		End if 
		If ($cp>8)
			$vo_button.fontColour:=$9
		Else 
			$vo_button.colour:=BUTTON_Defaults("FONTCOLOUR")
		End if 
		If ($cp>9)
			$vo_button.method:=$10
		Else 
			$vo_button.method:=BUTTON_Defaults("METHOD")
		End if 
		If ($cp>10)
			$vo_button.position:=$11
		Else 
			$vo_button.position:="right"
		End if 
		If ($vo_button.position="right")
			$vo_button.numberRight:=vc_buttons.query("position == :1"; "right").length
		Else 
			$vo_button.numberLeft:=vc_buttons.query("position == :1"; "left").length
		End if 
		//End use 
		
		//Use (vc_buttons)
		vc_buttons.push($vo_button)
		//End use 
		
	End if 
	//Use (Storage)
	//Storage.inputButtons:=vc_buttons
	//End use 
End if 