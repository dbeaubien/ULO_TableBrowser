//%attributes = {}


  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 23/01/20, 11:10:28
  // ----------------------------------------------------
  // Method: ULO_APPLY_THEME
  // Description
  // Applied theme from Form.theme to ULO_LIST
  //
  // Parameters
  // $1 - String - ListBox Name
  // $2 - Object - Theme Data
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_lbName)
C_OBJECT:C1216($2;$vo_theme)

C_LONGINT:C283($vl_fontColour)

ARRAY TEXT:C222($at_colName;0)
ARRAY TEXT:C222($at_footerName;0)
ARRAY TEXT:C222($at_headerName;0)

ARRAY POINTER:C280($ap_style;0)
ARRAY POINTER:C280($ap_colVar;0)
ARRAY POINTER:C280($ap_footerVar;0)
ARRAY POINTER:C280($ap_headerVar;0)

ARRAY BOOLEAN:C223($ab_colVisible;0)

$vt_lbName:=$1
$vo_theme:=OB Copy:C1225($2)

LISTBOX SET GRID COLOR:C842(*;$vt_lbName;$vo_theme.hLineColour;True:C214;False:C215)
LISTBOX SET GRID COLOR:C842(*;$vt_lbName;$vo_theme.vLineColour;False:C215;True:C214)
LISTBOX SET GRID:C841(*;$vt_lbName;$vo_theme.showHLine;$vo_theme.showVLine)

  //Need to apply most theme settings to individual column / header / footer objects
LISTBOX GET ARRAYS:C832(*;$vt_lbName;$at_colName;$at_headerName;$ap_colVar;$ap_headerVar;\
$ab_colVisible;$ap_style;$at_footerName;$ap_footerVar)
For ($i;1;Size of array:C274($at_colName))
	  //Column
	OBJECT SET FONT:C164(*;$at_colName{$i};$vo_theme.rowFont)
	OBJECT SET FONT SIZE:C165(*;$at_colName{$i};$vo_theme.rowFontSize)
	OBJECT GET RGB COLORS:C1074(*;$at_colName{$i};$vl_fontColour)
	OBJECT SET RGB COLORS:C628(*;$at_colName{$i};$vl_fontColour;$vo_theme.rowColour;$vo_theme.rowAltColour)
	
	  //Header
	OBJECT SET FONT:C164(*;$at_headerName{$i};$vo_theme.headerFont)
	OBJECT SET FONT SIZE:C165(*;$at_headerName{$i};$vo_theme.headerFontSize)
	OBJECT SET RGB COLORS:C628(*;$at_headerName{$i};$vo_theme.headerFontColour;$vo_theme.headerBgColour)
	
	  //Footer
	If ($at_footerName{$i}#"")
		OBJECT SET FONT:C164(*;$at_footerName{$i};$vo_theme.rowFont)
		OBJECT SET FONT SIZE:C165(*;$at_footerName{$i};$vo_theme.rowFontSize)
		OBJECT GET RGB COLORS:C1074(*;$at_footerName{$i};$vl_fontColour)
		OBJECT SET RGB COLORS:C628(*;$at_footerName{$i};$vl_fontColour;$vo_theme.rowColour;$vo_theme.rowAltColour)
	End if 
End for 