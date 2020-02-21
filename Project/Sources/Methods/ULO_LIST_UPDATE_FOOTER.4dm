//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 21/01/20, 09:51:12
  // ----------------------------------------------------
  // Method: ULO_LIST_UPDATE_FOOTER
  // Description
  // Recalcs footers for all current columns
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($CR;$vt_footer)
C_LONGINT:C283($i;$idx;$vl_items;$vl_maxItems)
C_COLLECTION:C1488($vc_cols)
C_REAL:C285($vr_result)

ARRAY TEXT:C222($at_colName;0)
ARRAY TEXT:C222($at_footerName;0)
ARRAY TEXT:C222($at_headerName;0)

ARRAY POINTER:C280($ap_style;0)
ARRAY POINTER:C280($ap_colVar;0)
ARRAY POINTER:C280($ap_footerVar;0)
ARRAY POINTER:C280($ap_headerVar;0)

ARRAY BOOLEAN:C223($ab_colVisible;0)

If (Form:C1466.navItem.selectedView.detail.useFooter)
	$CR:=Char:C90(Carriage return:K15:38)
	$vc_cols:=Form:C1466.navItem.selectedView.detail.cols
	
	LISTBOX GET ARRAYS:C832(*;"ULO_LIST";$at_colName;$at_headerName;$ap_colVar;$ap_headerVar;$ab_colVisible;$ap_style;$at_footerName;$ap_footerVar)
	
	For ($i;1;Size of array:C274($at_colName))
		$idx:=$i-1  //Collection index
		If ($vc_cols[$idx].selected)
			$vt_footer:=""
			$vl_items:=0
			
			$vl_items:=Choose:C955($vc_cols[$idx].average;$vl_items+1;$vl_items)
			$vl_items:=Choose:C955($vc_cols[$idx].total;$vl_items+1;$vl_items)
			$vl_items:=Choose:C955($vc_cols[$idx].max;$vl_items+1;$vl_items)
			$vl_items:=Choose:C955($vc_cols[$idx].min;$vl_items+1;$vl_items)
			
			If ($vc_cols[$idx].total)
				If (Form:C1466.uloRecords.length>0)
					$vr_result:=Form:C1466.uloRecords.sum($vc_cols[$idx].fieldName)
				Else 
					$vr_result:=0
				End if 
				$vt_footer:=Choose:C955(($vl_items>1);"Sum: ";"")+String:C10($vr_result)
			End if 
			
			If ($vc_cols[$idx].max)
				$vt_footer:=Choose:C955($vt_footer#"";$vt_footer+$CR;"")
				If (Form:C1466.uloRecords.length>0)
					$vr_result:=Form:C1466.uloRecords.max($vc_cols[$idx].fieldName)
				Else 
					$vr_result:=0
				End if 
				$vt_footer:=$vt_footer+Choose:C955(($vl_items>1);"Max: ";"")+String:C10($vr_result)
			End if 
			
			If ($vc_cols[$idx].min)
				$vt_footer:=Choose:C955($vt_footer#"";$vt_footer+$CR;"")
				If (Form:C1466.uloRecords.length>0)
					$vr_result:=Form:C1466.uloRecords.min($vc_cols[$idx].fieldName)
				Else 
					$vr_result:=0
				End if 
				$vt_footer:=$vt_footer+Choose:C955(($vl_items>1);"Min: ";"")+String:C10($vr_result)
			End if 
			
			If ($vc_cols[$idx].average)
				$vt_footer:=Choose:C955($vt_footer#"";$vt_footer+$CR;"")
				If (Form:C1466.uloRecords.length>0)
					$vr_result:=Form:C1466.uloRecords.average($vc_cols[$idx].fieldName)
				Else 
					$vr_result:=0
				End if 
				$vt_footer:=$vt_footer+Choose:C955(($vl_items>1);"Avg: ";"")+String:C10($vr_result)
			End if 
			
			$ap_footerVar{$i}->:=$vt_footer
			
			If ($vl_maxItems<$vl_items)
				$vl_maxItems:=$vl_items
			End if 
		End if 
	End for 
	
	LISTBOX SET FOOTERS HEIGHT:C1145(*;"ULO_LIST";$vl_maxItems;lk lines:K53:23)
Else 
	LISTBOX SET FOOTERS HEIGHT:C1145(*;"ULO_LIST";0;lk lines:K53:23)
End if 