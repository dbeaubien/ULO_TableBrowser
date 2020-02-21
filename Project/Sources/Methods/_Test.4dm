//%attributes = {}

C_COLLECTION:C1488($vc_option)
C_TEXT:C284($vt_menu;$vt_selected)

$vt_menu:=Create menu:C408
$vc_option:=New collection:C1472

$vc_option.push(New object:C1471("label";"i.level Reports";"function";"S_Print";"shortcut";"P";"modifier";Control key mask:K16:9))
$vc_option.push(New object:C1471("label";"Item 2";"function";"item-2";"shortcut";"P";"modifier";Control key mask:K16:9))  // <-- Parents are not checked for shortcuts
$vc_option.push(New object:C1471("label";"Child 1";"function";"child-11";"parent";"item-2";"shortcut";"P";"modifier";Control key mask:K16:9))
$vc_option.push(New object:C1471("label";"Child 2";"function";"child-12";"parent";"item-2"))
$vc_option.push(New object:C1471("label";"Child 3";"function";"child-13";"parent";"item-2"))
$vc_option.push(New object:C1471("label";"Child 4";"function";"child-14";"parent";"item-2"))
$vc_option.push(New object:C1471("label";"Item 3";"function";"item-3"))
$vc_option.push(New object:C1471("label";"Child 1";"function";"child-21";"parent";"item-3"))
$vc_option.push(New object:C1471("label";"Child 2";"function";"child-22";"parent";"item-3"))

$vt_menu:=UTIL_Parse_Host_Menu_Options ($vt_menu;$vc_option)

$vt_selected:=Dynamic pop up menu:C1006($vt_menu)
