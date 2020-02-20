//%attributes = {}
  //PROJECT METHOD:           HOST_BRW_EXPORT_VIEW
  //MODULE::                  
  //REQUIRED:                 HOST_BRW
  //COMPILER:                 COMPILER
  //CREATED:                  23/01/14, 14:50:52 / Mehdi Shariatzadeh
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //DESCRIPTION:
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //CHANGES:
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //© Halare and Telekinetix 2008 - 2014
  //For example and details see Comments in the 4D Explorer
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  //Declare
C_LONGINT:C283($1;$cp)
C_LONGINT:C283($vl_win;$vl_W;$vl_H;$vl_TableNum;$vl_sel;$vl_ris)
C_POINTER:C301(vp_HOST_BRW_Table)
C_LONGINT:C283(b_exportCSV;b_exportExcel;vl_DisplayedItems;vl_HighlightedItems)
C_OBJECT:C1216($vo_formData)
$cp:=Count parameters:C259
$vl_ris:=Form:C1466.uloList.length
$vl_sel:=Form:C1466.records.length
$vo_formData:=New object:C1471
$vo_formData.ris:=$vl_ris
$vo_formData.selectedRecords:=$vl_sel
$vo_formData.displayed:=True:C214
$vo_formData.highlighted:=False:C215
$vo_formData.message:=""
  //Open the selection window
  //FORM GET PROPERTIES("ULO_EXPORT_VIEW";$vl_W;$vl_H)
$vl_win:=Open form window:C675("ULO_EXPORT_VIEW";Modal form dialog box:K39:7)
DIALOG:C40("ULO_EXPORT_VIEW";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (b_exportExcel=1) | (b_exportCSV=1)  //If a report was chosen
	
	  //Reduce the selection if we need to
	If ($vo_formData.highlighted)
		USE SET:C118("UserSet")
	End if 
	
	Case of 
		: (b_exportExcel=1)
			ULO_EXPORT_VIEW_XLSX ($vl_TableNum)
			
		: (b_exportCSV=1)
			ULO_EXPORT_VIEW_CSV ($vl_TableNum)
			
	End case 
	
End if 

