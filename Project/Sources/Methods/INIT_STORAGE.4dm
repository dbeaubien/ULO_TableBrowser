//%attributes = {}
Use (Storage:C1525)
	Storage:C1525.defaultViews:=New shared collection:C1527
	Storage:C1525.buttons:=New shared collection:C1527
	Storage:C1525.prefs:=New shared object:C1526
	Use (Storage:C1525.prefs)
		Storage:C1525.prefs.theme:="ios"
		Storage:C1525.prefs.maxSetsInMenu:=10
		
	End use 
	
	Storage:C1525.appearance:=New shared object:C1526
	Use (Storage:C1525.appearance)
		Storage:C1525.appearance.formBGColour:=0x00E5F2F7
		Storage:C1525.appearance.listFontColour:=0x0000
		Storage:C1525.appearance.listBackgroundColour:=0x00FFFFFF
		Storage:C1525.appearance.listBackgroundColourAlt:=0x00F3F6FA
	End use 
	
	Storage:C1525.user:=New shared object:C1526
	Storage:C1525.hostMethods:=New shared object:C1526
	Use (Storage:C1525.hostMethods)
		Storage:C1525.hostMethods.filter:="HOST_ULO_FILTER"
		Storage:C1525.hostMethods.find:="HOST_ULO_FIND"
	End use 
	
End use 