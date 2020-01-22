//%attributes = {}
C_LONGINT:C283($1;$vl_idx;$vl_idx2)  //table, viewNum
C_LONGINT:C283($vl_left;$vl_top;$vl_right;$vl_bottom;$vl_win)
C_TEXT:C284($2)
C_OBJECT:C1216($vo_formData;$e_uloData;$vo_field;$vo_res)


ARRAY TEXT:C222(at_tableName;0)
ARRAY LONGINT:C221(al_tableNum;0)

$vo_formData:=New object:C1471
$vo_formData.view:=New object:C1471

If ($2#"")
	  //$es_views:=ds["uloData"].query("id == :1";$2)
	  //If ($es_views.length>0)
	  //$vo_formData.view:=$es_views.first().toObject()
	  //End if 
	$e_uloData:=ds:C1482["uloData"].get($2)
	$vo_formData.view:=$e_uloData.toObject()
Else 
	  //Is a new view, create default $vo_formData
	$e_uloData:=ds:C1482["uloData"].new()
	$e_uloData.detail:=New object:C1471
	$e_uloData.table:=$1
	$vo_formData.view.id:=-1
	$vo_formData.view.table:=$1
	$vo_formData.view.name:="New View"
	$vo_formData.view.handle:=Form:C1466.navItem.handle
	$vo_formData.view.type:=2
	$vo_formData.view.user:=1
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
	
End if 

$vo_formData.fields:=New collection:C1472  //Fields from defined table and its N - 1 related tables
$vo_formData.fields.push(New object:C1471("table";$1;"fields";ULO_Get_Table_Fields (Table name:C256($1);"relation";"")))

APPEND TO ARRAY:C911(at_tableName;Table name:C256($1))
APPEND TO ARRAY:C911(al_tableNum;$1)
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
	
	
	$e_uloData.user:=1
	$e_uloData.group:=1
	
	$e_uloData.detail.cols:=$vo_formData.view.detail.cols
	$e_uloData.detail.useFooter:=$vo_formData.view.detail.useFooter
	$e_uloData.detail.public:=$vo_formData.view.detail.public
	$e_uloData.detail.lockedColumns:=$vo_formData.view.detail.lockedColumns
	$e_uloData.detail.rowHeight:=$vo_formData.view.detail.rowHeight
	$e_uloData.detail.headerHeight:=$vo_formData.view.detail.headerHeight
	
	$vo_res:=$e_uloData.save()
	If ($vo_res.success)
		  //Form.navItem.view:=$e_uloData.detail
		Form:C1466.navItem.selectedView:=$e_uloData.toObject()
		ULO_LOAD_VIEW 
	Else 
		  //alert?
		ALERT:C41("Failed to save "+Char:C90(13)+JSON Stringify:C1217($vo_res;*))
	End if 
	
End if 

