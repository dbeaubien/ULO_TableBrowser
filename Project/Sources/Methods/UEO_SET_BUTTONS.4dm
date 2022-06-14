//%attributes = {"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 09/01/20, 10:31:24
// ----------------------------------------------------
// Method: UEO_SET_BUTTON
// Description
// 
//
// Parameters as properties in a passed object or collection of objects
// action (text) - "Save Record"
// title (text) - "Save"
// tooltip (text) - "Saves the current record"
// icon (text) - Image pulled relative to theme or set as absolute path
// popup (boolean) - True/False sets the popup symbol on the button
// shortcutKey (text) - "S"
// shortcutModifiers (number) 
// colour (number)  - The background colour for the button
// fontColour (number) - The font colour
// method (text) - The name of the host method to be called
// position (text) - "left" or "right" (default)
// ----------------------------------------------------

C_COLLECTION:C1488(vc_buttons)
C_OBJECT:C1216($vo_button; $vo_status)
C_VARIANT:C1683($1)

Case of 
	: (Value type:C1509($1)=Is text:K8:3)
		If ($1="INIT")  //Call with clear any existing buttons otherwise this will do nothing
			vc_buttons:=New collection:C1472
		End if 
		
	: (Value type:C1509($1)=Is object:K8:27)  //Then we are adding a single object to the collection
		$vo_button:=UEO_Check_Button_Properties($1)
		If (Not:C34($vo_button.success))
			ALERT:C41($vo_button.error)
		Else 
			OB REMOVE:C1226($vo_button; "status")
			vc_buttons.push($vo_button)
		End if 
		
	: (Value type:C1509($1)=Is collection:K8:32)  //Then we are adding a single object to the collection
		For each ($vo_button; $1)
			$vo_button:=UEO_Check_Button_Properties($vo_button)
			If (Not:C34($vo_button.success))
				ALERT:C41($vo_button.error)
			Else 
				OB REMOVE:C1226($vo_button; "status")
				vc_buttons.push($vo_button)
			End if 
		End for each 
	Else 
		ALERT:C41("Unhandled type passed to: "+Current method name:C684)
End case 
