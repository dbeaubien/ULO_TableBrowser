//%attributes = {"invisible":true}
  //PROJECT METHOD:           INT_SET_LIST_COLOURS
  //MODULE::                  INT
  //REQUIRED:                 CORE
  // DECLARE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
C_TEXT:C284($1)  //Listbox Object name
C_VARIANT:C1683($vv_listFontColour;$vv_listBGColour;$vv_listBGColourAlt)
C_LONGINT:C283($cp)

$cp:=Count parameters:C259

  //INIT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$vv_listFontColour:=Storage:C1525.appearance.listFontColour
$vv_listBGColour:=Storage:C1525.appearance.listBackgroundColour
$vv_listBGColourAlt:=Storage:C1525.appearance.listBackgroundColourAlt

  //METHOD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OBJECT SET RGB COLORS:C628(*;$1;$vv_listFontColour;$vv_listBGColour;$vv_listBGColourAlt)
