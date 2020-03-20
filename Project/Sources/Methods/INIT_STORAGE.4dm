//%attributes = {}
Use (Storage:C1525)
	Storage:C1525.defaultViews:=New shared collection:C1527
	Storage:C1525.buttons:=New shared collection:C1527
	Storage:C1525.prefs:=New shared object:C1526
	Storage:C1525.shortcuts:=New shared collection:C1527
	Storage:C1525.hostShortcuts:=New shared collection:C1527
	
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
		Storage:C1525.hostMethods.filter:="ULO_FILTER"
		Storage:C1525.hostMethods.find:="ULO_FIND"
		Storage:C1525.hostMethods.sidebarLoad:="ULO_SIDEBAR_LOAD"
		Storage:C1525.hostMethods.rowContext:="ULO_ROW_CONTEXT"
		Storage:C1525.hostMethods.rowDoubleClick:="ULO_MODIFY"
	End use 
	
	Storage:C1525.sidebar:=New shared collection:C1527
	
End use 