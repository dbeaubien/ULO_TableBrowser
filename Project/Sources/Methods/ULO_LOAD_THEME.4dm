//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 23/01/20, 10:20:41
  // ----------------------------------------------------
  // Method: ULO_LOAD_THEME
  // Description
  // Querys for theme related to current user, else creates
  // default theme and stores in Form
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($es_uloData;$e_uloData;$vo_theme)

  //Set default vars
$vo_theme:=New object:C1471
$vo_theme.id:=""
$vo_theme.hLineColour:=0x0000
$vo_theme.hLineColourHex:="000000"
$vo_theme.vLineColour:=0x0000
$vo_theme.vLineColourHex:="000000"
$vo_theme.showHLine:=True:C214
$vo_theme.showVLine:=True:C214

$vo_theme.rowFontColour:=0x0000
$vo_theme.rowFontColourHex:="000000"
$vo_theme.rowColour:=0x00FFFFFF
$vo_theme.rowColourHex:="FFFFFF"
$vo_theme.rowAltColour:=0x00AAAAAA
$vo_theme.rowAltColourHex:="AAAAAA"
$vo_theme.rowFontSize:=10
$vo_theme.rowFont:="Segoe UI"

$vo_theme.headerBgColour:=0x00FFFFFF
$vo_theme.headerBgColourHex:="FFFFFF"
$vo_theme.headerFontColour:=0x0000
$vo_theme.headerFontColourHex:="000000"
$vo_theme.headerFontSize:=11
$vo_theme.headerFont:="Segoe UI"

$es_uloData:=ds:C1482["uloData"].query("user == :1 & type == 3";Storage:C1525.user.id)
If ($es_uloData.length=0)
	$es_uloData:=ds:C1482["uloData"].query("user == :1 & type == 3";0)
End if 
If ($es_uloData.length>0)
	$e_uloData:=$es_uloData.first()
	
	$vo_theme.id:=$e_uloData.id
	If (OB Is defined:C1231($e_uloData.detail.theme;"hLineColour"))
		$vo_theme.hLineColour:=$e_uloData.detail.theme.hLineColour
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"vLineColour"))
		$vo_theme.vLineColour:=$e_uloData.detail.theme.vLineColour
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"showHLine"))
		$vo_theme.showHLine:=$e_uloData.detail.theme.showHLine
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"showVLine"))
		$vo_theme.showVLine:=$e_uloData.detail.theme.showVLine
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowColour"))
		$vo_theme.rowColour:=$e_uloData.detail.theme.rowColour
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowAltColour"))
		$vo_theme.rowAltColour:=$e_uloData.detail.theme.rowAltColour
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowFont"))
		$vo_theme.rowFont:=$e_uloData.detail.theme.rowFont
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowFontSize"))
		$vo_theme.rowFontSize:=$e_uloData.detail.theme.rowFontSize
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"headerFontSize"))
		$vo_theme.headerFontSize:=$e_uloData.detail.theme.headerFontSize
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"headerBgColour"))
		$vo_theme.headerBgColour:=$e_uloData.detail.theme.headerBgColour
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"headerFontColour"))
		$vo_theme.headerFontColour:=$e_uloData.detail.theme.headerFontColour
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"headerFont"))
		$vo_theme.headerFont:=$e_uloData.detail.theme.headerFont
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowFontColour"))
		$vo_theme.rowFontColour:=$e_uloData.detail.theme.rowFontColour
	End if 
	
	If (OB Is defined:C1231($e_uloData.detail.theme;"hLineColourHex"))
		$vo_theme.hLineColourHex:=$e_uloData.detail.theme.hLineColourHex
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"vLineColourHex"))
		$vo_theme.vLineColourHex:=$e_uloData.detail.theme.vLineColourHex
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowColourHex"))
		$vo_theme.rowColourHex:=$e_uloData.detail.theme.rowColourHex
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowAltColourHex"))
		$vo_theme.rowAltColourHex:=$e_uloData.detail.theme.rowAltColourHex
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"headerBgColourHex"))
		$vo_theme.headerBgColourHex:=$e_uloData.detail.theme.headerBgColourHex
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"headerFontColourHex"))
		$vo_theme.headerFontColourHex:=$e_uloData.detail.theme.headerFontColourHex
	End if 
	If (OB Is defined:C1231($e_uloData.detail.theme;"rowFontColourHex"))
		$vo_theme.rowFontColourHex:=$e_uloData.detail.theme.rowFontColourHex
	End if 
	
End if 

Form:C1466.theme:=OB Copy:C1225($vo_theme)








