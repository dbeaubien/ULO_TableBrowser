//%attributes = {}

  //  // ----------------------------------------------------
  //  // User name (OS): Tom
  //  // Date and time: 17/02/20, 13:20:28
  //  // ----------------------------------------------------
  //  // Method: ULO_HEADER_CLICK
  //  // Description
  //  // 
  //  //
  //  // Parameters
  //  // ----------------------------------------------------


  //C_LONGINT($vl_col;$vl_row;$vl_pos;$vl_table;$vl_field)
  //C_TEXT($vt_temp;$vt_header)

  //ARRAY TEXT($at_colName;0)
  //ARRAY TEXT($at_headerName;0)
  //ARRAY POINTER($ap_style;0)
  //ARRAY POINTER($ap_colVar;0)
  //ARRAY POINTER($ap_headerVar;0)
  //ARRAY BOOLEAN($ab_colVisible;0)

  //LISTBOX GET CELL POSITION(*;"ULO_LIST";$vl_col;$vl_row)

  //LISTBOX GET ARRAYS(*;"ULO_LIST";$at_colName;$at_headerName;$ap_colVar;$ap_headerVar;\
$ab_colVisible;$ap_style)

  //  //TRACE

  //$vt_header:=$at_headerName{$vl_col}

  //$vt_temp:=Replace string($vt_header;"head_";"")
  //$vt_temp:=Replace string($vt_temp;"h_";"")
  //$vl_pos:=Position("_";$vt_temp)
  //If ($vl_pos>0)
  //$vl_table:=Num(Substring($vt_temp;1;$vl_pos-1))
  //$vl_field:=Num(Substring($vt_temp;$vl_pos+1))

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
  //End if 
