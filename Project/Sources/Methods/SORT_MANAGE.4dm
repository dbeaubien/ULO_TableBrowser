//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 17/02/20, 09:37:00
  // ----------------------------------------------------
  // Method: SORT_MANAGE
  // Description
  // Opens form allowing user to edit all their sorts for the 
  // Current Table
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($vo_formData;$vo_field)
C_LONGINT:C283($vl_idx;$vl_win)

ARRAY TEXT:C222(at_tableName;0)
ARRAY LONGINT:C221(al_tableNum;0)

ARRAY TEXT:C222(at_sortTab;0)

APPEND TO ARRAY:C911(at_sortTab;" Your Sorts ")
APPEND TO ARRAY:C911(at_sortTab;" System Sorts ")
at_sortTab:=1

$vo_formData:=New object:C1471

$vo_formData.sortTab:="user"
$vo_formData.helpfulData:=New object:C1471
$vo_formData.helpfulData.tableNumber:=Form:C1466.tableNumber
$vo_formData.helpfulData.tableHandle:=Form:C1466.navItem.handle


$vo_formData.userSorts:=ds:C1482["uloData"].query("user == :1 && type == 13 && table == :2";Storage:C1525.user.id;Form:C1466.tableNumber)
$vo_formData.systemSorts:=ds:C1482["uloData"].query("user == 0 && type == 13 && table == :1";Form:C1466.tableNumber)
$vo_formData.displaySort:=$vo_formData.userSorts

$vo_formData.fields:=New collection:C1472  //fields from defined table and its N - 1 related tables
$vo_formData.fields.push(New object:C1471("table";Form:C1466.tableNumber;"fields";ULO_Get_Table_Fields (Table name:C256(Form:C1466.tableNumber));"relation";""))

APPEND TO ARRAY:C911(at_tableName;Table name:C256(Form:C1466.tableNumber))
APPEND TO ARRAY:C911(al_tableNum;Form:C1466.tableNumber)
at_tableName:=1

For each ($vo_field;$vo_formData.fields[0].fields)
	If ($vo_field.kind="relatedEntity")
		$vl_idx:=UTIL_Col_Find_Index (Storage:C1525.tableTitles;"name";$vo_field.relatedDataClass)
		If ($vl_idx>=0)
			$vo_formData.fields.push(New object:C1471("table";Storage:C1525.tableTitles[$vl_idx].id;"fields";ULO_Get_Table_Fields ($vo_field.relatedDataClass);"relation";$vo_field.name))
			APPEND TO ARRAY:C911(at_tableName;$vo_field.relatedDataClass)
			APPEND TO ARRAY:C911(al_tableNum;Storage:C1525.tableTitles[$vl_idx].id)
		End if 
	End if 
End for each 

START TRANSACTION:C239

$vl_win:=UTIL_Open_Window_Centre ("ULO_SORT_MANAGE")
DIALOG:C40("ULO_SORT_MANAGE";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (OK=1)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 
