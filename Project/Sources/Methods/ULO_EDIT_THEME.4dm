//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 22/01/20, 20:31:24
  // ----------------------------------------------------
  // Method: ULO_EDIT_THEME
  // Description
  // Opens dialog for editing Theme settings
  // If user Accepts, new theme is applied to ULO_LIST
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($vo_formData)
C_LONGINT:C283($vl_left;$vl_top;$vl_right;$vl_bottom;$vl_win)

$vo_formData:=New object:C1471
$vo_formData.theme:=Form:C1466.theme

$vl_left:=(Screen width:C187/2)-(650/2)
$vl_top:=(Screen height:C188/2)-(550/2)
$vl_right:=$vl_left+650
$vl_bottom:=$vl_top+550

$vl_win:=Open window:C153($vl_left;$vl_top;$vl_right;$vl_bottom)
DIALOG:C40("ULO_EDIT_THEME";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (OK=1)
	If ($vo_formData.theme.id#"")
		$e_uloData:=ds:C1482["uloData"].get($vo_formData.theme.id)
		$e_uloData.detail.theme:=OB Copy:C1225($vo_formData.theme)
		OB REMOVE:C1226($e_uloData.detail.theme;"id")
		$e_uloData.save()
	Else 
		$e_uloData:=ds:C1482["uloData"].new()
		$e_uloData.user:=Storage:C1525.user.id
		$e_uloData.type:=3
		$e_uloData.detail:=New object:C1471
		$e_uloData.detail.theme:=OB Copy:C1225($vo_formData.theme)
		$e_uloData.save()
	End if 
	
	Form:C1466.theme:=OB Copy:C1225($vo_formData.theme)
	  //ULO_APPLY_THEME ("ULO_LIST";Form.theme)
	ULO_LOAD_VIEW 
End if 
