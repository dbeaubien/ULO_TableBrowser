//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 16/01/20, 12:48:02
  // ----------------------------------------------------
  // Method: VIEW_FORM_EDIT_COL_DETAIL
  // Description
  // Opens detail edit pop-up for the selected column
  // 
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($vo_formData)

$vo_formData:=New object:C1471
$vo_formData.col:=OB Copy:C1225(Form:C1466.selectedCol)

$vl_left:=(Screen width:C187/2)-(650/2)
$vl_top:=(Screen height:C188/2)-(550/2)
$vl_right:=$vl_left+650
$vl_bottom:=$vl_top+550

$vl_win:=Open window:C153($vl_left;$vl_top;$vl_right;$vl_bottom)
DIALOG:C40("ULO_VIEW_EDIT_DETAIL";$vo_formData)
CLOSE WINDOW:C154($vl_win)

