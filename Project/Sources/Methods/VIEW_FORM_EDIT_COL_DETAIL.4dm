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
C_LONGINT:C283($vl_left;$vl_top;$vl_right;$vl_bottom;$vl_win)
C_TEXT:C284($vt_prop)

$vo_formData:=New object:C1471
$vo_formData.col:=OB Copy:C1225(Form:C1466.selectedCol)

$vl_left:=(Screen width:C187/2)-(405/2)
$vl_top:=(Screen height:C188/2)-(475/2)
$vl_right:=$vl_left+405
$vl_bottom:=$vl_top+475

$vl_win:=Open window:C153($vl_left;$vl_top;$vl_right;$vl_bottom)
DIALOG:C40("ULO_VIEW_EDIT_DETAIL";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (OK=1)
	$vo_formData.col.fontStyle:=0
	If ($vo_formData.bold=1)
		$vo_formData.col.fontStyle:=1
	End if 
	If ($vo_formData.italic=1)
		$vo_formData.col.fontStyle:=$vo_formData.col.fontStyle+2
	End if 
	If ($vo_formData.underline=1)
		$vo_formData.col.fontStyle:=$vo_formData.col.fontStyle+4
	End if 
	
	$vl_idx:=Form:C1466.view.detail.cols.findIndex("UTIL_Find_Collection";"table";Form:C1466.selectedCol.table;"field";Form:C1466.selectedCol.field)
	If ($vl_idx>=0)
		For each ($vt_prop;$vo_formData.col)
			Form:C1466.selectedCol[$vt_prop]:=$vo_formData.col[$vt_prop]
			Form:C1466.view.detail.cols[$vl_idx][$vt_prop]:=$vo_formData.col[$vt_prop]
		End for each 
	End if 
End if 
