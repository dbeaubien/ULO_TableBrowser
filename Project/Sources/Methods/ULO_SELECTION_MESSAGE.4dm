//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 12/02/20, 13:50:04
  // ----------------------------------------------------
  // Method: ULO_SELECTION_MESSAGE
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($vl_selected;$vl_ris)
C_TEXT:C284($vt_selected)
$vl_selected:=Form:C1466.selectedRecords.length
$vl_ris:=Form:C1466.uloRecords.length
If ($vl_selected>0)
	$vt_selected:=String:C10($vl_selected)+" record"+Choose:C955($vl_selected#1;"s";"")+" selected of "
End if 
Form:C1466.selectionMessage:=$vt_selected+String:C10($vl_ris)+" record"+Choose:C955($vl_ris#1;"s";"")+" in selection"
