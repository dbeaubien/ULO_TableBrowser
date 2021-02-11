//%attributes = {"shared":true}
C_LONGINT:C283($1;$cp;$tableNumber;$vl_window)
C_LONGINT:C283($vl_wLeft;$vl_wRight;$vl_wTop;$vl_wBottom;$vl_wType)
C_TEXT:C284($vt_wTitle)
C_OBJECT:C1216($2;$vo_uloData;$3)
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
$vo_uloData.navItems:=New collection:C1472
$vo_uloData.sidebarSource:=Storage:C1525.sidebar.copy()
$vo_uloData.navItems:=Storage:C1525.sidebar.copy()  //SIDEBAR_Flatten (Storage.sidebar.copy())
$vo_uloData.lastNavItemIndex:=1
$vo_uloData.selectedRecord:=New object:C1471  //Selected record object
$vo_uloData.selectedRecord:=1  //Currently selected record
$vo_uloData.selectionMessage:=""  //Currently selected record
$vo_uloData.selectedRecords:=ds:C1482[Table name:C256($tableNumber)].newSelection()  //Selected /highlighed records
$vo_uloData.shortcuts:=New collection:C1472
If ($cp>2)
	If (OB Is defined:C1231($3;"tableNumber"))
		$vo_uloData.uloRecords:=ds:C1482[Table name:C256($tableNumber)].query($3.idField+" in :1";$3.ids)
		$vo_uloData.relate:=True:C214
	Else 
		$vo_uloData.uloRecords:=$3
	End if 
Else 
	$vo_uloData.uloRecords:=ds:C1482[Table name:C256($tableNumber)].all()  //Current selection
End if 
If ($cp>1)
	  //Use the properties passed in object to determine the position of the window
	If (OB Is defined:C1231($2;"wLeft"))
		$vo_uloData.wLeft:=$2.wLeft
	End if 
	If (OB Is defined:C1231($2;"wTop"))
		$vo_uloData.wTop:=$2.wTop
	End if 
	If (OB Is defined:C1231($2;"wRight"))
		$vo_uloData.wRight:=$2.wRight
	End if 
	If (OB Is defined:C1231($2;"wBottom"))
		$vo_uloData.wBottom:=$2.wBottom
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

$vl_window:=Open form window:C675("ULO_Browser";$vl_wType;$vo_uloData.wLeft;$vo_uloData.wTop)
  //$vl_window:=Open window($vl_wLeft;$vl_wTop;$vl_wRight;$vl_wBottom;$vl_wType;"ULO_Browser";"ULO_CLOSE")
DIALOG:C40("ULO_Browser";$vo_uloData)
CLOSE WINDOW:C154($vl_window)