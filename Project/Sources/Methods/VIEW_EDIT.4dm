//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 22/01/20, 19:33:38
  // ----------------------------------------------------
  // Method: VIEW_EDIT
  // Description
  //
  // Parameters
  // $1 - String - Case : "New" ; "Dupe" ; "Edit"
  // ----------------------------------------------------

C_LONGINT:C283($vl_idx;$vl_idx2)  //table, viewNum
C_LONGINT:C283($vl_left;$vl_top;$vl_right;$vl_bottom;$vl_win)
C_TEXT:C284($1)
C_OBJECT:C1216($vo_formData;$e_uloData;$vo_field;$vo_res;$vo_currentView)

ARRAY TEXT:C222(at_tableName;0)
ARRAY LONGINT:C221(al_tableNum;0)

$vo_formData:=New object:C1471
$vo_formData.view:=New object:C1471
$vo_formData.delete:=False:C215


Case of 
	: ($1="New")
		$vo_formData.allowDelete:=False:C215
		  //Is a new view, create default $vo_formData
		$e_uloData:=ds:C1482["uloData"].new()
		$e_uloData.detail:=New object:C1471
		$e_uloData.table:=Form:C1466.tableNumber
		$vo_formData.view.id:=""
		$vo_formData.view.table:=Form:C1466.tableNumber
		$vo_formData.view.name:="New View"
		$vo_formData.view.handle:=Form:C1466.navItem.handle
		$vo_formData.view.type:=2
		$vo_formData.view.user:=Storage:C1525.user.id
		$vo_formData.view.group:=1
		$vo_formData.view.favourite:=False:C215
		$vo_formData.view.default:=False:C215
		$vo_formData.view.detail:=New object:C1471
		$vo_formData.view.detail.cols:=New collection:C1472
		$vo_formData.view.detail.public:=False:C215
		$vo_formData.view.detail.useFooter:=False:C215
		$vo_formData.view.detail.lockedColumns:=0
		$vo_formData.view.detail.rowHeight:=1
		$vo_formData.view.detail.headerHeight:=1
		
	: ($1="Dupe")
		$vo_formData.allowDelete:=False:C215
		TRACE:C157
		$vo_currentView:=OB Copy:C1225(Form:C1466.navItem.selectedView)
		
		If (Form:C1466.navItem.selectedView.id#"")
			$e_view:=ds:C1482["uloData"].get(Form:C1466.navItem.selectedView.id)
			$e_uloData:=UTIL_Duplicate_Entity ($e_view;"uloData")
			$e_uloData.id:=""  //Sets new UUID
			$e_uloData.name:=Form:C1466.navItem.selectedView.name+" - Copy"
			$e_uloData.user:=Storage:C1525.user.id
			$e_uloData.favourite:=False:C215
			$e_uloData.default:=False:C215
			$e_uloData.detail.public:=False:C215
			
		Else 
			  //Is a new view, create default $vo_formData
			$e_uloData:=ds:C1482["uloData"].new()
			$e_uloData.table:=Form:C1466.tableNumber
			$e_uloData.name:=Choose:C955($e_uloData.name="";"New View";$e_uloData.name+" - Copy")
			$e_uloData.handle:=Form:C1466.navItem.selectedView.handle
			$e_uloData.type:=2
			$e_uloData.user:=Storage:C1525.user.id
			$e_uloData.group:=1
			$e_uloData.favourite:=False:C215
			$e_uloData.default:=False:C215
			$e_uloData.detail:=OB Copy:C1225(Form:C1466.navItem.selectedView.detail)
			$e_uloData.detail.public:=False:C215
			
		End if 
		
		$vo_formData.view:=$e_uloData.toObject()
		Form:C1466.navItem.selectedView:=$e_uloData.toObject()
		
	: ($1="Edit")
		$vo_formData.view:=OB Copy:C1225(Form:C1466.navItem.selectedView)
		
End case 

$vo_formData.fields:=New collection:C1472  //Fields from defined table and its N - 1 related tables
$vo_formData.fields.push(New object:C1471("table";Form:C1466.tableNumber;"fields";ULO_Get_Table_Fields (Table name:C256(Form:C1466.tableNumber);"relation";"")))

APPEND TO ARRAY:C911(at_tableName;Table name:C256(Form:C1466.tableNumber))
APPEND TO ARRAY:C911(al_tableNum;Form:C1466.tableNumber)
at_tableName:=1

For each ($vo_field;$vo_formData.fields[0].fields)
	If ($vo_field.kind="relatedEntity")
		$vl_idx:=Storage:C1525.tableTitles.findIndex("UTIL_Find_Collection";"name";$vo_field.relatedDataClass)
		If ($vl_idx>=0)
			$vo_formData.fields.push(New object:C1471("table";Storage:C1525.tableTitles[$vl_idx].id;"fields";ULO_Get_Table_Fields ($vo_field.relatedDataClass);"relation";$vo_field.name))
			APPEND TO ARRAY:C911(at_tableName;$vo_field.relatedDataClass)
			APPEND TO ARRAY:C911(al_tableNum;Storage:C1525.tableTitles[$vl_idx].id)
		End if 
	End if 
End for each 

  //Cross reference saved fields with actual,
  //Update field names 
For each ($vo_field;$vo_formData.view.detail.cols)
	$vl_idx:=$vo_formData.fields.findIndex("UTIL_Find_Collection";"table";$vo_field.table)
	If ($vl_idx>=0)
		$vl_idx2:=$vo_formData.fields[$vl_idx].fields.findIndex("UTIL_Find_Collection";"fieldNumber";$vo_field.field)
		If ($vl_idx2>=0)
			$vo_field.fieldName:=$vo_formData.fields[$vl_idx].fields[$vl_idx2].fieldName
		Else 
			  //Delete from collection?
		End if 
	End if 
End for each 

$vl_left:=(Screen width:C187/2)-(650/2)
$vl_top:=(Screen height:C188/2)-(550/2)
$vl_right:=$vl_left+650
$vl_bottom:=$vl_top+550

$vl_win:=Open window:C153($vl_left;$vl_top;$vl_right;$vl_bottom)
DIALOG:C40("ULO_VIEW_EDIT";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (OK=1)
	$e_uloData.name:=$vo_formData.view.name
	$e_uloData.handle:=$vo_formData.view.handle
	$e_uloData.type:=2
	$e_uloData.favourite:=$vo_formData.view.favourite
	$e_uloData.group:=1
	$e_uloData.detail:=$vo_formData.view.detail
	
	$vo_res:=$e_uloData.save()
	If ($vo_res.success)
		Form:C1466.navItem.selectedView:=$e_uloData.toObject()
		ULO_LOAD_VIEW 
	Else 
		ALERT:C41("Failed to save "+Char:C90(13)+JSON Stringify:C1217($vo_res;*))
	End if 
Else 
	Case of 
		: ($1="Edit")
			If ($vo_formData.delete)
				$e_uloData.drop()
				Form:C1466.navItem.selectedView:=Null:C1517
				ULO_LOAD_VIEW 
			End if 
			
		: ($1="Dupe")
			Form:C1466.navItem.selectedView:=OB Copy:C1225($vo_currentView)
			
	End case 
	
End if 
