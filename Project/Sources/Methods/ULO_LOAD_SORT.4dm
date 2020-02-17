//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 14/02/20, 10:30:16
  // ----------------------------------------------------
  // Method: ULO_LOAD_SORT
  // Description
  // Applies Form.navItem.selectedSort to the current selection
  //
  // Parameters
  // ----------------------------------------------------

C_COLLECTION:C1488($vc_sort)
C_OBJECT:C1216($vo_item;$vo_sort)
C_LONGINT:C283($vl_idx;$vl_field;$vl_pos;$vl_table;$i)
C_TEXT:C284($vt_temp)
ARRAY TEXT:C222($at_colName;0)
ARRAY TEXT:C222($at_footerName;0)
ARRAY TEXT:C222($at_headerName;0)

ARRAY POINTER:C280($ap_style;0)
ARRAY POINTER:C280($ap_colVar;0)
ARRAY POINTER:C280($ap_footerVar;0)
ARRAY POINTER:C280($ap_headerVar;0)

ARRAY BOOLEAN:C223($ab_colVisible;0)

If (Form:C1466.navItem.selectedSort#Null:C1517)
	$vc_sort:=New collection:C1472
	
	For each ($vo_item;Form:C1466.navItem.selectedSort.detail.sortData)
		$vo_sort:=New object:C1471
		$vo_sort.propertyPath:=$vo_item.formula
		$vo_sort.descending:=($vo_item.sortDir="DES")
		$vc_sort.push(OB Copy:C1225($vo_sort))
	End for each 
	
	  //Apply sort icon to listbox headers
	
	LISTBOX GET ARRAYS:C832(*;"ULO_LIST";$at_colName;$at_headerName;$ap_colVar;$ap_headerVar;\
		$ab_colVisible;$ap_style;$at_footerName;$ap_footerVar)
	
	For ($i;1;Size of array:C274($at_colName))
		$vt_temp:=Replace string:C233($at_headerName{$i};"head_";"")
		$vt_temp:=Replace string:C233($vt_temp;"h_";"")
		$vl_pos:=Position:C15("_";$vt_temp)
		If ($vl_pos>0)
			$vl_table:=Num:C11(Substring:C12($vt_temp;1;$vl_pos-1))
			$vl_field:=Num:C11(Substring:C12($vt_temp;$vl_pos+1))
			
			$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItem.selectedSort.detail.sortData;"table";$vl_table;"field";$vl_field)
			If ($vl_idx>=0)
				$ap_headerVar{$i}->:=Choose:C955(Form:C1466.navItem.selectedSort.detail.sortData[$vl_idx].sortDir="ASC";1;2)
			End if 
		End if 
	End for 
	
	Form:C1466.uloList:=Form:C1466.uloList.orderBy($vc_sort)
Else 
	If (Form:C1466.uloList.isOrdered())
		Form:C1466.uloList:=Form:C1466.uloList.or(Form:C1466.uloList)
	End if 
End if 