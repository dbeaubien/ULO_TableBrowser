//%attributes = {"shared":true}
C_LONGINT:C283($1;$cp;$tableNumber;$vl_window)
C_LONGINT:C283($vl_wLeft;$vl_wRight;$vl_wTop;$vl_wBottom;$vl_wType)
C_TEXT:C284($vt_wTitle)
C_OBJECT:C1216($2;$vo_uloData)
$cp:=Count parameters:C259
If ($cp>0)
	$tableNumber:=$1
Else 
	$tableNumber:=Storage:C1525.tableTitles[0].id
End if 

  //Set window defaults
$vl_wLeft:=10
$vl_wTop:=150
$vl_wRight:=810
$vl_wBottom:=650
$vl_wType:=Plain window:K34:13
$vt_wTitle:="Browser"

$vo_uloData:=New object:C1471
$vo_uloData.tableNumber:=$tableNumber
$vo_uloData.navItem:=New object:C1471
$vo_uloData.selectedNavItem:=1
$vo_uloData.navItems:=New collection:C1472
$vo_uloData.navItems:=Storage:C1525.sidebar.copy()  //SIDEBAR_Flatten (Storage.sidebar.copy())
$vo_uloData.lastNavItemIndex:=1
$vo_uloData.record:=New object:C1471  //Selected record object
$vo_uloData.selectedRecord:=1  //Currently selected record
$vo_uloData.records:=ds:C1482[Table name:C256($tableNumber)].newSelection()  //Selected /highlighed records
$vo_uloData.uloList:=ds:C1482[Table name:C256($tableNumber)].all()  //Current selection
If ($cp>1)
	  //Use the properties passed in object to determine the position of the window
	If (OB Is defined:C1231($2;"wLeft"))
		$vl_wLeft:=$2.wLeft
	End if 
	If (OB Is defined:C1231($2;"wTop"))
		$vl_wTop:=$2.wTop
	End if 
	If (OB Is defined:C1231($2;"wRight"))
		$vl_wRight:=$2.wRight
	End if 
	If (OB Is defined:C1231($2;"wBottom"))
		$vl_wBottom:=$2.wBottom
	End if 
	If (OB Is defined:C1231($2;"wType"))
		$vl_wType:=$2.wType
	End if 
	If (OB Is defined:C1231($2;"wTitle"))
		$vt_wTitle:=$2.wTitle
	End if 
	If (OB Is defined:C1231($2;"sidebarStart"))
		$vo_uloData.sidebarStart:=$2.sidebarStart
	End if 
	
End if 

$vo_uloData.buttons:=New collection:C1472
If (Storage:C1525.buttons.length>0)
	$vo_uloData.buttons:=Storage:C1525.buttons
Else 
	  //Temp code to set up form buttons
	$vo_uloData.buttons.push(New object:C1471("number";0;"title";"New";\
		"method";"HOST_ULO_BUTTON_METHOD";\
		"shortcutKey";"N";"shortcutModifiers";Command key mask:K16:1))
	
	$vo_uloData.buttons.push(New object:C1471("number";1;"title";"Query";\
		"method";"HOST_ULO_BUTTON_METHOD";\
		"shortcutKey";"S";"shortcutModifiers";Command key mask:K16:1;\
		"colour";-(White:K11:1+(256*0))))
	
	$vo_uloData.buttons.push(New object:C1471("number";2;"title";"Sub";\
		"method";"HOST_ULO_BUTTON_METHOD";\
		"shortcutKey";"R";"shortcutModifiers";Command key mask:K16:1))
	
	$vo_uloData.buttons.push(New object:C1471("number";3;"title";"Show All";\
		"method";"HOST_ULO_BUTTON_METHOD";\
		"shortcutKey";"A";"shortcutModifiers";Command key mask:K16:1;\
		"colour";-(Red:K11:4+(256*Black:K11:16))))
	
End if 

$vl_window:=Open window:C153($vl_wLeft;$vl_wTop;$vl_wRight;$vl_wBottom;$vl_wType;$vt_wTitle)
DIALOG:C40("ULO_Browser";$vo_uloData)
CLOSE WINDOW:C154($vl_window)