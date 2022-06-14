//%attributes = {"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 09/01/20, 10:31:24
// ----------------------------------------------------
// Method: ULO_SET_BUTTONS
// Description
// 
//
// Parameters
// action (text) - "New Record"
// title (text) - "New"
// tooltip (text) - "Add a new record"
// icon (text) - Image pulled relative to theme
// popup Symbol (boolean) True/False
// popup (boolean) - True/False sets the popup symbol on the button
// shortcutKey (text) - "S"
// shortcutModifiers (number) 
// colour (number)  - The background colour for the button
// fontColour (number) - The font colour
// method (text) - The name of the host method to be called
// type (text) - "standard" (default) or the user can specify their own type for the button
// ----------------------------------------------------

C_COLLECTION:C1488($vc_buttons; $vc_buttonsShared)
C_OBJECT:C1216($vo_button; $vo_status)
C_VARIANT:C1683($1)
$vc_buttons:=New collection:C1472
Case of 
	: (Value type:C1509($1)=Is text:K8:3)
		If ($1="INIT")  //Call with clear any existing buttons otherwise this will do nothing
			Use (Storage:C1525)
				Storage:C1525.buttons:=New shared collection:C1527
			End use 
		End if 
	: (Value type:C1509($1)=Is object:K8:27)  //Then we are adding a single object to the collection
		$vc_buttons:=Storage:C1525.buttons.copy()
		$vo_button:=ULO_Check_Button_Properties($1)
		If (Not:C34($vo_button.success))
			ALERT:C41($vo_button.error)
		Else 
			OB REMOVE:C1226($vo_button; "status")
			$vc_buttons.push($vo_button)
		End if 
		$vc_buttonsShared:=$vc_buttons.copy(ck shared:K85:29)
		Use (Storage:C1525)
			Storage:C1525.buttons:=$vc_buttonsShared
		End use 
	: (Value type:C1509($1)=Is collection:K8:32)  //Then we are adding a single object to the collection
		$vc_buttons:=Storage:C1525.buttons.copy()
		For each ($vo_button; $1)
			$vo_button:=ULO_Check_Button_Properties($vo_button)
			If (Not:C34($vo_button.success))
				ALERT:C41($vo_button.error)
			Else 
				OB REMOVE:C1226($vo_button; "status")
				$vc_buttons.push($vo_button)
			End if 
			$vc_buttonsShared:=$vc_buttons.copy(ck shared:K85:29)
			Use (Storage:C1525)
				Storage:C1525.buttons:=$vc_buttonsShared
			End use 
		End for each 
	Else 
		ALERT:C41("Unhandled type passed to: "+Current method name:C684)
End case 
