//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 17/02/20, 13:20:28
  // ----------------------------------------------------
  // Method: ULO_HEADER_CLICK
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


C_LONGINT:C283($vl_col;$vl_row;$vl_pos;$vl_table;$vl_field;$vl_idx)
C_TEXT:C284($vt_temp;$vt_header)
C_OBJECT:C1216(vo_sortObj)

ARRAY TEXT:C222($at_colName;0)
ARRAY TEXT:C222($at_headerName;0)
ARRAY POINTER:C280($ap_style;0)
ARRAY POINTER:C280($ap_colVar;0)
ARRAY POINTER:C280($ap_headerVar;0)
ARRAY BOOLEAN:C223($ab_colVisible;0)

LISTBOX GET CELL POSITION:C971(*;"ULO_LIST";$vl_col;$vl_row)

LISTBOX GET ARRAYS:C832(*;"ULO_LIST";$at_colName;$at_headerName;$ap_colVar;$ap_headerVar;\
$ab_colVisible;$ap_style)

  //TRACE

$vt_header:=$at_headerName{$vl_col}

$vt_temp:=Replace string:C233($vt_header;"head_";"")
$vt_temp:=Replace string:C233($vt_temp;"h_";"")
$vl_pos:=Position:C15("_";$vt_temp)
If ($vl_pos>0)
	$vl_table:=Num:C11(Substring:C12($vt_temp;1;$vl_pos-1))
	$vl_field:=Num:C11(Substring:C12($vt_temp;$vl_pos+1))
	
	If ($vl_table<0)
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItem.selectedView.detail.cols;"field";$vl_field;"table";$vl_table)
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView.detail.cols[$vl_idx];"method"))
			If (Form:C1466.customSort.field=$vl_field)
				Form:C1466.customSort.dir:=Choose:C955((Form:C1466.customSort.dir=2);1;2)
			Else 
				Form:C1466.customSort.field:=$vl_field
				Form:C1466.customSort.dir:=1
			End if 
			
			vo_sortObj:=New object:C1471("case";"sort")
			
			EXECUTE FORMULA:C63(Form:C1466.navItem.selectedView.detail.cols[$vl_idx].method+"(vo_sortObj)")
			  //EXECUTE METHOD(Form.navItem.selectedView.detail.cols[$vl_idx].sortFormula)
			$ap_headerVar{$vl_col}->:=Form:C1466.customSort.dir
		End if 
	Else 
		Form:C1466.customSort:=New object:C1471("field";0;"dir";0)
	End if 
	
	
	
	  //If ($vl_field>0)  //negatives are custom fields
	  //$vc_fields:=ULO_Get_Table_Fields (Table name($vl_table))
	  //$vl_fieldIdx:=UTIL_Col_Find_Index ($vc_fields;"fieldNumber";$vl_field)
	  //If ($vl_fieldIdx>=0)
	  //If (Form.navItem.selectedSort=Null)
	  //Form.navItem.selectedSort:=New object
	  //Form.navItem.selectedSort.detail:=New object
	  //Form.navItem.selectedSort.id:=""
	  //Form.navItem.selectedSort.type:=13
	  //Form.navItem.selectedSort.handle:=Form.navItem.handle
	  //Form.navItem.selectedSort.user:=Storage.user.id
	  //Form.navItem.selectedSort.table:=Form.tableNumber
	  //Form.navItem.selectedSort.name:="New Sort #"+String(ds["uloData"]\
												.query("type == 13 && user == :1 && table == :2";Storage.user.id;Form.tableNumber).length+1)
	  //Form.navItem.selectedSort.group:=1  //TODO: Group?
	  //Form.navItem.selectedSort.detail.public:=False
	  //Form.navItem.selectedSort.detail.sortData:=New collection
	  //End if 
	
	  //$vl_sortIdx:=UTIL_Col_Find_Index (Form.navItem.selectedSort.detail.sortData;"field";$vl_field;"table";$vl_table)
	  //If ($vl_sortIdx>=0)
	  //If (Form.navItem.selectedSort.detail.sortData[$vl_sortIdx].sortDir="ASC")
	  //Form.navItem.selectedSort.detail.sortData[$vl_sortIdx].sortDir:="DES"
	  //Else 
	  //Form.navItem.selectedSort.detail.sortData.remove($vl_sortIdx)
	  //End if 
	
	
	  //Else 
	  //$vo_sort:=New object
	  //$vo_sort.table:=$vl_table
	  //$vo_sort.field:=$vl_field
	  //$vo_sort.fieldName:=$vc_fields[$vl_fieldIdx].fieldName
	  //$vo_sort.formula:=""
	  //$vo_sort.relation:=""
	
	  //If (OB Is defined($vc_fields[$vl_fieldIdx];"relation"))
	  //$vo_sort.relation:=$vc_fields[$vl_fieldIdx].relation
	  //If ($vo_sort.relation#"")
	  //$vo_sort.formula:=$vo_sort.relation+"."+$vc_fields[$vl_fieldIdx].fieldName
	  //End if 
	  //End if 
	
	  //If ($vo_sort.formula="")
	  //$vo_sort.formula:=$vc_fields[$vl_fieldIdx].fieldName
	  //End if 
	
	  //$vo_sort.sortDir:="ASC"
	
	  //Form.navItem.selectedSort.detail.sortData.push(OB Copy($vo_sort))
	
	  //End if 
	  //ULO_LOAD_SORT 
	  //End if   // fieldIdx check
	  //End if   // (not a) formula check
End if 
