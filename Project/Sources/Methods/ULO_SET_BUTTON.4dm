//%attributes = {"shared":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 09/01/20, 10:31:24
  // ----------------------------------------------------
  // Method: ULO_SET_BUTTON
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
  // ----------------------------------------------------

C_COLLECTION:C1488($vc_buttons)
C_TEXT:C284($1;$2;$3;$4;$6;$10)
C_BOOLEAN:C305($5)
C_LONGINT:C283($7;$8;$9;$cp)
$cp:=Count parameters:C259
If ($cp>10) | ($cp=0)
	  //return an error for incorrect number of parameters
Else 
	$vc_buttons:=New shared collection:C1527
	If ($1="INIT")
	Else 
		$vc_buttons:=Storage:C1525.buttons
		$vo_button:=New shared object:C1526
		Use ($vo_button)
			$vo_button.number:=$vc_buttons.length
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
			Else 
				$vo_button.icon:=BUTTON_Defaults ("ICON";$1)
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
				$vo_button.colour:=BUTTON_Defaults ("COLOUR")
			End if 
			If ($cp>8)
				$vo_button.fontColour:=$9
			Else 
				$vo_button.colour:=BUTTON_Defaults ("FONTCOLOUR")
			End if 
			If ($cp>9)
				$vo_button.method:=$10
			Else 
				$vo_button.method:=BUTTON_Defaults ("METHOD")
			End if 
		End use 
		Use ($vc_buttons)
			$vc_buttons.push($vo_button)
		End use 
		
	End if 
	Use (Storage:C1525)
		Storage:C1525.buttons:=$vc_buttons
	End use 
End if 