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
C_OBJECT:C1216($vo_formData;$es_records)
$cp:=Count parameters:C259
$vl_ris:=Form:C1466.uloRecords.length
$vl_sel:=Form:C1466.selectedRecords.length
$vo_formData:=New object:C1471
$vo_formData.ris:=$vl_ris
$vo_formData.selectedRecords:=$vl_sel
$vo_formData.displayed:=True:C214
$vo_formData.highlighted:=False:C215
$vo_formData.message:=""
ARRAY LONGINT:C221($al_pluginId;0)
ARRAY TEXT:C222($at_pluginName;0)
PLUGIN LIST:C847($al_pluginId;$at_pluginName)
$vo_formData.excelInstalled:=(Find in array:C230($at_pluginName;"XL Plugin")>0)
  //Open the selection window
  //FORM GET PROPERTIES("ULO_EXPORT_VIEW";$vl_W;$vl_H)
$vl_win:=Open form window:C675("ULO_EXPORT_VIEW";Modal form dialog box:K39:7)
DIALOG:C40("ULO_EXPORT_VIEW";$vo_formData)
CLOSE WINDOW:C154($vl_win)

If (b_exportExcel=1) | (b_exportCSV=1)  //If a report was chosen
	
	  //Reduce the selection if we need to
	If ($vo_formData.highlighted)
		$es_records:=Form:C1466.selectedRecords
	Else 
		$es_records:=Form:C1466.uloRecords
	End if 
	
	Case of 
		: (b_exportExcel=1)
			ULO_EXPORT_VIEW_XLSX ($es_records)
			
		: (b_exportCSV=1)
			ULO_EXPORT_VIEW_CSV ($es_records)
			
	End case 
	
End if 

