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

C_OBJECT:C1216($vo_formData;$e_uloData)
C_LONGINT:C283($vl_left;$vl_top;$vl_right;$vl_bottom;$vl_win;$vl_w;$vl_h)

$vo_formData:=New object:C1471

$vo_formData.themes:=ds:C1482["uloData"].query("type == 3 && user == :1";Storage:C1525.user.id)
$vo_formData.systemDefault:=ds:C1482["uloData"].query("type == 3 && user == :1";0).first()
If (Storage:C1525.user.id=1) & ($vo_formData.systemDefault#Null:C1517)  //If designer, get system theme
	$vo_formData.themes.add($vo_formData.systemDefault)
End if 

START TRANSACTION:C239

$vl_win:=UTIL_Open_Window_Centre ("ULO_EDIT_THEME")
DIALOG:C40("ULO_EDIT_THEME";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (OK=1)
	If ($vo_formData.workingTheme#Null:C1517)
		$vo_formData.workingTheme.save()
	End if 
	VALIDATE TRANSACTION:C240
	If ($vo_formData.workingTheme#Null:C1517)  //Load last editted theme if any
		ULO_LOAD_THEME ($vo_formData.workingTheme.id)
	Else 
		ULO_LOAD_THEME 
	End if 
	ULO_LOAD_VIEW 
Else 
	CANCEL TRANSACTION:C241
End if 
