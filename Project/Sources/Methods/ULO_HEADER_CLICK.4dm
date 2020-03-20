//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 17/02/20, 13:20:28
  // ----------------------------------------------------
  // Method: ULO_Header_Click
  // Description
  // 
  //
  // Parameters
  // $0 - Longint - Value returned by Event to determine if 4D
  //                should attempt a regular sort
  // ----------------------------------------------------


C_LONGINT:C283($0;$vl_col;$vl_row;$vl_pos;$vl_table;$vl_field;$vl_idx)
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
$0:=0

$vt_header:=$at_headerName{$vl_col}

$vt_temp:=Replace string:C233($vt_header;"head_";"")
$vt_temp:=Replace string:C233($vt_temp;"h_";"")
$vl_pos:=Position:C15("_";$vt_temp)
If ($vl_pos>0)
	$vl_table:=Num:C11(Substring:C12($vt_temp;1;$vl_pos-1))
	$vl_field:=Num:C11(Substring:C12($vt_temp;$vl_pos+1))
	
	If ($vl_table<0)
		$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItem.selectedView.detail.cols;"field";$vl_field;"table";$vl_table)
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView.detail.cols[$vl_idx];"sortFormula"))
			
			If (Form:C1466.customSort.field=$vl_field)
				Form:C1466.customSort.dir:=Choose:C955((Form:C1466.customSort.dir=2);1;2)
			Else 
				Form:C1466.customSort.field:=$vl_field
				Form:C1466.customSort.dir:=1
			End if 
			
			vo_sortObj:=New object:C1471("case";"sort")
			
			EXECUTE FORMULA:C63(Form:C1466.navItem.selectedView.detail.cols[$vl_idx].sortFormula)
			$ap_headerVar{$vl_col}->:=Form:C1466.customSort.dir
			$0:=-1
		End if 
	Else 
		Form:C1466.customSort:=New object:C1471("field";0;"dir";0)
	End if 
	
End if 
