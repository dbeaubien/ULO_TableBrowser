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


C_LONGINT:C283($vl_col;$vl_row;$vl_pos;$vl_table;$vl_field)
C_TEXT:C284($vt_temp;$vt_header)

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
	
	If ($vl_field>0)  //negatives are custom fields
		$vc_fields:=ULO_Get_Table_Fields (Table name:C256($vl_table))
		$vl_fieldIdx:=UTIL_Col_Find_Index ($vc_fields;"fieldNumber";$vl_field)
		If ($vl_fieldIdx>=0)
			If (Form:C1466.navItem.selectedSort=Null:C1517)
				Form:C1466.navItem.selectedSort:=New object:C1471
				Form:C1466.navItem.selectedSort.detail:=New object:C1471
				Form:C1466.navItem.selectedSort.id:=""
				Form:C1466.navItem.selectedSort.type:=13
				Form:C1466.navItem.selectedSort.handle:=Form:C1466.navItem.handle
				Form:C1466.navItem.selectedSort.user:=Storage:C1525.user.id
				Form:C1466.navItem.selectedSort.table:=Form:C1466.tableNumber
				Form:C1466.navItem.selectedSort.name:="New Sort #"+String:C10(ds:C1482["uloData"]\
					.query("type == 13 && user == :1 && table == :2";Storage:C1525.user.id;Form:C1466.tableNumber).length+1)
				Form:C1466.navItem.selectedSort.group:=1  //TODO: Group?
				Form:C1466.navItem.selectedSort.detail.public:=False:C215
				Form:C1466.navItem.selectedSort.detail.sortData:=New collection:C1472
			End if 
			
			$vl_sortIdx:=UTIL_Col_Find_Index (Form:C1466.navItem.selectedSort.detail.sortData;"field";$vl_field;"table";$vl_table)
			If ($vl_sortIdx>=0)
				If (Form:C1466.navItem.selectedSort.detail.sortData[$vl_sortIdx].sortDir="ASC")
					Form:C1466.navItem.selectedSort.detail.sortData[$vl_sortIdx].sortDir:="DES"
				Else 
					Form:C1466.navItem.selectedSort.detail.sortData.remove($vl_sortIdx)
				End if 
				
				
			Else 
				$vo_sort:=New object:C1471
				$vo_sort.table:=$vl_table
				$vo_sort.field:=$vl_field
				$vo_sort.fieldName:=$vc_fields[$vl_fieldIdx].fieldName
				$vo_sort.formula:=""
				$vo_sort.relation:=""
				
				If (OB Is defined:C1231($vc_fields[$vl_fieldIdx];"relation"))
					$vo_sort.relation:=$vc_fields[$vl_fieldIdx].relation
					If ($vo_sort.relation#"")
						$vo_sort.formula:=$vo_sort.relation+"."+$vc_fields[$vl_fieldIdx].fieldName
					End if 
				End if 
				
				If ($vo_sort.formula="")
					$vo_sort.formula:=$vc_fields[$vl_fieldIdx].fieldName
				End if 
				
				$vo_sort.sortDir:="ASC"
				
				Form:C1466.navItem.selectedSort.detail.sortData.push(OB Copy:C1225($vo_sort))
				
			End if 
			ULO_LOAD_SORT 
		End if   // fieldIdx check
	End if   // (not a) formula check
End if 
