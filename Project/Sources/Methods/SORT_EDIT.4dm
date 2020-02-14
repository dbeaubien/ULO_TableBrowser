//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 14/02/20, 10:02:00
  // ----------------------------------------------------
  // Method: SORT_EDIT
  // Description
  // Displays form allowing user to edit the currently selected sort
  //
  // Parameters
  // $1 - String - Case : "New" ; "Dupe" ; "Edit"
  // ----------------------------------------------------

C_TEXT:C284($1)
C_OBJECT:C1216($e_uloData;$vo_formData;$vo_currentSort;$e_sort;\
$e_uloDataLoop;$vo_field;$vo_res;$es_uloData)
C_LONGINT:C283($vl_idx;$vl_idx2;$vl_win)

ARRAY TEXT:C222(at_tableName;0)
ARRAY LONGINT:C221(al_tableNum;0)

$vo_formData:=New object:C1471
$vo_formData.sort:=New object:C1471
$vo_formData.delete:=False:C215

Case of 
	: ($1="New")
		$vo_formData.allowDelete:=False:C215
		
		$e_uloData:=ds:C1482["uloData"].new()
		$e_uloData.detail:=New object:C1471
		$e_uloData.type:=13
		$e_uloData.handle:=Form:C1466.navItem.handle
		$e_uloData.user:=Storage:C1525.user.id
		$e_uloData.table:=Form:C1466.tableNumber
		
		$vo_formData.sort.id:=""
		$vo_formData.sort.table:=Form:C1466.tableNumber
		$vo_formData.sort.name:="New Sort"
		$vo_formData.sort.handle:=Form:C1466.navItem.handle
		$vo_formData.sort.type:=13
		$vo_formData.sort.user:=Storage:C1525.user.id
		$vo_formData.sort.group:=1  //TODO: Group?
		$vo_formData.sort.favourite:=False:C215
		$vo_formData.sort.default:=False:C215
		$vo_formData.sort.detail:=New object:C1471
		$vo_formData.sort.detail.public:=False:C215
		$vo_formData.sort.detail.sortData:=New collection:C1472
		
	: ($1="Edit")
		$vo_formData.allowDelete:=True:C214
		$vo_formData.sort:=OB Copy:C1225($vo_formData.navItem.selectedSort)
		$e_uloData:=ds:C1482["uloData"].get($vo_formData.navItem.selectedSort.id)
		
	: ($1="Dupe")
		$vo_formData.allowDelete:=False:C215
		$vo_currentSort:=OB Copy:C1225(Form:C1466.navItem.selectedSort)
		
		$e_sort:=ds:C1482["uloData"].get(Form:C1466.navItem.selectedSort.id)
		$e_uloData:=UTIL_Duplicate_Entity ($e_sort;"uloData")
		$e_uloData.id:=""  //Sets new UUID
		$e_uloData.name:=Form:C1466.navItem.selectedSort.name+" - Copy"
		$e_uloData.user:=Storage:C1525.user.id
		$e_uloData.favourite:=False:C215
		$e_uloData.default:=False:C215
		$e_uloData.detail.public:=False:C215
		
		$vo_formData.sort:=$e_uloData.toObject()
		Form:C1466.navItem.selectedSort:=$e_uloData.toObject()
		
		
End case 

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

  //Cross reference saved fields with actual,
  //Update field names 
For each ($vo_field;$vo_formData.sort.detail.sortData)
	$vl_idx:=UTIL_Col_Find_Index ($vo_formData.fields;"table";$vo_field.table)
	If ($vl_idx>=0)
		$vl_idx2:=UTIL_Col_Find_Index ($vo_formData.fields[$vl_idx].fields;"fieldNumber";$vo_field.field)
		If ($vl_idx2>=0)
			$vo_field.fieldName:=$vo_formData.fields[$vl_idx].fields[$vl_idx2].fieldName
		Else 
			  //Delete from collection?
		End if 
	End if 
End for each 

$vl_win:=UTIL_Open_Window_Centre ("ULO_SORT_EDIT")
DIALOG:C40("ULO_SORT_EDIT";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (OK=1)
	$e_uloData.name:=$vo_formData.sort.name
	$e_uloData.favourite:=$vo_formData.sort.favourite
	$e_uloData.detail:=$vo_formData.sort.detail
	
	$vo_res:=$e_uloData.save()
	If ($vo_res.success)
		If ($e_uloData.default)
			  //Ensure there's only one default for this user / table
			$es_uloData:=ds:C1482["uloData"].query("user == :1 && handle == :2 && type == 13 && default == True";$e_uloData.user;$e_uloData.handle)
			For each ($e_uloDataLoop;$es_uloData)
				If ($e_uloData.id#$e_uloDataLoop.id)
					$e_uloDataLoop.default:=False:C215
					$e_uloDataLoop.save()
				End if 
			End for each 
		End if 
		
	Else 
		ALERT:C41("Failed to save "+Char:C90(13)+JSON Stringify:C1217($vo_res;*))
	End if 
	
Else 
	Case of 
		: ($1="Edit")
			If ($vo_formData.delete)
				$e_uloData.drop()
				Form:C1466.navItem.selectedSort:=Null:C1517
				ULO_LOAD_SORT 
			End if 
			
		: ($1="Dupe")
			Form:C1466.navItem.selectedSort:=OB Copy:C1225($vo_currentSort)
			
	End case 
	
End if 






























