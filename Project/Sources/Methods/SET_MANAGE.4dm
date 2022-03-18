//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 20/02/20, 15:56:43
  // ----------------------------------------------------
  // Method: SET_MANAGE
  // Description
  // Opens Set manipulation interface
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($es_userSets;$vo_formData)
C_LONGINT:C283($vl_win)

$vo_formData:=New object:C1471
$vo_formData.errorMessage:=""
$vo_formData.tableNumber:=Form:C1466.tableNumber
$vo_formData.handle:=Form:C1466.navItem.handle
$vo_formData.subform:=New object:C1471
$vo_formData.subform.manipLines:=New collection:C1472
$vo_formData.subform.lineCount:=0
$vo_formData.subform.actualLineCount:=0
$vo_formData.subform.objectTracker:=New collection:C1472


$es_userSets:=ds:C1482["uloData"].query("table == :1 && user == :2 && type == 1";Form:C1466.tableNumber;Storage:C1525.user.id)

$vo_formData.userSets:=$es_userSets.toCollection("id, table, name, detail")
$vo_formData.subform.userSets:=$vo_formData.userSets

$vo_formData.operations:=New collection:C1472
$vo_formData.operations.push("Union";"Difference";"Intersection")
$vo_formData.subform.operations:=$vo_formData.operations

$vl_win:=UTIL_Open_Window_Centre ("ULO_SET_MANAGE";Sheet form window:K39:12;"Manage Sets")
DIALOG:C40("ULO_SET_MANAGE";$vo_formData)
CLOSE WINDOW:C154($vl_win)
