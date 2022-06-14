//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 02/06/22, 07:52:53
// ----------------------------------------------------
// Method: UEO_Check_Button_Properties
// Description
// Checks for missing or empty properties and sets them to default values.
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0; $1; $vo_button)
$vo_button:=$1
$0:=New object:C1471
If (Not:C34(OB Is defined:C1231($vo_button; "action")))
	$0.success:=False:C215
	$0.error:="No action specified in button object!"
Else 
	$vo_button.number:=Storage:C1525.buttons.length
	If (Not:C34(OB Is defined:C1231($vo_button; "title")))
		$vo_button.title:=$vo_button.action
	End if 
	If (Not:C34(OB Is defined:C1231($vo_button; "tooltip")))
		$vo_button.tooltip:=$vo_button.title
	End if 
	//$vo_button.icon - Not mandatory if not defined check defaults for action
	If (OB Is defined:C1231($vo_button; "icon"))
		If ($vo_button.icon="")
			$vo_button.icon:=BUTTON_Defaults("ICON"; $vo_button.action)
		End if 
	End if 
	If (Not:C34(OB Is defined:C1231($vo_button; "popup")))
		$vo_button.popup:=False:C215  // - Not mandatory
	End if 
	If (Not:C34(OB Is defined:C1231($vo_button; "shortcutKey")))
		$vo_button.shortcutKey:=""  // - Not mandatory
	End if 
	If (Not:C34(OB Is defined:C1231($vo_button; "shortcutModifiers")))
		$vo_button.shortcutModifiers:=0  // - Not mandatory
	End if 
	//$vo_button.colour - Not mandatory but check default
	If (Not:C34(OB Is defined:C1231($vo_button; "colour")))
		$vo_button.colour:=0
		If ($vo_button.colour=0)
			$vo_button.colour:=BUTTON_Defaults("COLOUR")
		End if 
	End if 
	//$vo_button.fontColour - Not mandatory but check default
	If (Not:C34(OB Is defined:C1231($vo_button; "fontColour")))
		$vo_button.fontColour:=0
		If ($vo_button.fontColour=0)
			$vo_button.fontColour:=BUTTON_Defaults("FONTCOLOUR")
		End if 
	End if 
	//$vo_button.method - Not mandatory but check default
	If (OB Is defined:C1231($vo_button; "method"))
		If ($vo_button.method="")
			$vo_button.method:=BUTTON_Defaults("METHOD")
		End if 
	End if 
	//$vo_button.position - Not mandatory but set default
	If (Not:C34(OB Is defined:C1231($vo_button; "type")))
		$vo_button.type:="standard"
	End if 
	$0:=OB Copy:C1225($vo_button)
	$0.success:=True:C214
End if 

