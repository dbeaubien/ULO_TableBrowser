//%attributes = {"invisible":true}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 20/02/20, 15:28:52
  // ----------------------------------------------------
  // Method: ULO_EXPORT_VIEW_XLSX
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

  //Declare
C_LONGINT:C283($1;$i;$vl_Progress)
C_LONGINT:C283($recordIndex;$vl_headerFormat;$vl_font;$vl_workbook;$vl_worksheet)
C_LONGINT:C283($cp;$fieldIndex;$vl_fia;$width;$height)
C_LONGINT:C283($vl_headerFormat;$vl_font;$vl_dateFormat;$vl_dateNr;$vl_PictureID)
C_TIME:C306($vh_Doc)
C_TEXT:C284(vt_ExportValue;$vt_filename)
C_REAL:C285(vr_ExportValue)
C_PICTURE:C286(vg_ExportValue)
C_DATE:C307(vd_ExportValue)
C_OBJECT:C1216($vo_col;$e_record)

ARRAY LONGINT:C221($al_picColumns;0)
ARRAY LONGINT:C221($al_colWidths;0)
$cp:=Count parameters:C259

  //Ask the user to create and name a document
$vh_Doc:=Create document:C266("";"XLSX")

If (OK=1)  //If user has created a document ....
	$vl_Progress:=Progress New 
	CLOSE DOCUMENT:C267($vh_Doc)
	$vt_filename:=Document
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting view please wait ...")
	
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting headers...")
	
	  //****** CREATE WORKBOOK*****
	$vl_workbook:=xlBookCreateXML 
	xlBookSetDefaultFont ($vl_workbook;"Arial";10)
	xlBookSetRGBMode ($vl_workbook;1)
	
	  //***** CREATE FORMATS *****
	$vl_headerFormat:=xlBookAddFormat ($vl_workbook)
	$vl_font:=xlBookAddFont ($vl_workbook)
	xlFormatSetFont ($vl_headerFormat;$vl_font)
	xlFontSetName ($vl_font;"Arial")
	xlFontSetBold ($vl_font;1)
	
	$vl_dateFormat:=xlBookAddFormat ($vl_workbook)
	$vl_dateNr:=xlBookAddCustomNumFormat ($vl_workbook;"dd/mm/yyyy")
	xlFormatSetNumFormat ($vl_dateFormat;$vl_dateNr)
	
	$vl_worksheet:=xlBookAddSheet ($vl_workbook;"Export View")
	
	
	  //****** ADD HEADERS *******
	$fieldIndex:=1
	For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
		If ($vo_col.selected)
			  //Tom can the header format be determined by the customisation?
			xlSheetSetCellText ($vl_worksheet;1;$fieldIndex;$vo_col.header;$vl_headerFormat)
			xlSheetSetColumnWidth ($vl_worksheet;$fieldIndex;($vo_col.width/6))
			$fieldIndex:=$fieldIndex+1
		End if 
	End for each   //END field loop for header
	
	  //Loop through the records
	$recordIndex:=1
	For each ($e_record;Form:C1466.uloRecords)
		
		  //Then loop through the columns
		$fieldIndex:=1  //Used for excel column number
		For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
			If ($vo_col.selected)
				vt_ExportValue:=""
				vr_ExportValue:=0
				CLEAR VARIABLE:C89(vg_ExportValue)
				
				Case of   //Export the field/formula value according to data type ...
					: ($vo_col.fieldType=Is integer:K8:5) | ($vo_col.fieldType=Is longint:K8:6) | ($vo_col.fieldType=Is real:K8:4)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vr_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vr_ExportValue:=$e_record[$vo_col.formula]
						End if 
						xlSheetSetCellNumber ($vl_worksheet;$recordIndex+1;$fieldIndex;vr_ExportValue)
						
					: ($vo_col.fieldType=Is alpha field:K8:1) | ($vo_col.fieldType=Is text:K8:3)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vt_ExportValue:=Replace string:C233($e_record[$vo_col.formula];Char:C90(Double quote:K15:41);Char:C90(Quote:K15:44))
						End if 
						xlSheetSetCellText ($vl_worksheet;$recordIndex+1;$fieldIndex;vt_ExportValue)
						
					: ($vo_col.fieldType=Is date:K8:7)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vd_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vd_ExportValue:=$e_record[$vo_col.formula]
						End if 
						xlSheetSetCellDateTime ($vl_worksheet;$recordIndex+1;$fieldIndex;vd_ExportValue;0;0;$vl_dateFormat)
						
					: ($vo_col.fieldType=Is time:K8:8)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:=string("+$e_record[$vo_col.formula]+")")
						Else 
							vt_ExportValue:=String:C10($e_record[$vo_col.formula])
						End if 
						xlSheetSetCellText ($vl_worksheet;$recordIndex+1;$fieldIndex;vt_ExportValue)
						
					: ($vo_col.fieldType=Is picture:K8:10)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vg_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vg_ExportValue:=$e_record[$vo_col.formula]
						End if 
						If (Picture size:C356(vg_ExportValue)>0)
							CONVERT PICTURE:C1002(vg_ExportValue;".jpg")
							PICTURE PROPERTIES:C457(vg_ExportValue;$width;$height)
							$vl_fia:=Find in array:C230($al_picColumns;$fieldIndex)
							If ($vl_fia=-1)
								APPEND TO ARRAY:C911($al_picColumns;$fieldIndex)
								APPEND TO ARRAY:C911($al_colWidths;$width)
							Else 
								If ($width>$vo_col.width)
									$vo_col.width:=$width
								End if 
							End if 
							xlSheetSetRowHeight ($vl_worksheet;$recordIndex+1;$height)
							$vl_PictureID:=xlBookAddPicture ($vl_workbook;vg_ExportValue)
							xlSheetSetPicture ($vl_worksheet;$recordIndex+1;$fieldIndex;$vl_PictureID;($width-2);($height-2))
						End if 
				End case   //END field type case
				$fieldIndex:=$fieldIndex+1
			End if   //END selected check
		End for each   //END field loop
		
		Progress SET PROGRESS ($vl_Progress;-1;"Exporting: "+String:C10($recordIndex)+" of  "+String:C10(Form:C1466.uloRecords.length))
		  //Progress_State ("Update";"Exporting: "+String($recordIndex)+" of  "+String($vl_RIS))
		$recordIndex:=$recordIndex+1
	End for each   //END record loop
	For ($i;1;Size of array:C274($al_colWidths))
		xlSheetSetColumnWidth ($vl_worksheet;$al_picColumns{$i};($al_colWidths{$i}/7.3))
	End for 
	Progress QUIT ($vl_Progress)
	  //Progress_State ("Update";"End")
	xlBookSaveFile ($vl_workbook;$vt_filename)
	xlBookRelease ($vl_workbook)
	SHOW ON DISK:C922($vt_filename)
	CLEAR VARIABLE:C89(vt_ExportValue)
	CLEAR VARIABLE:C89(vr_ExportValue)
	CLEAR VARIABLE:C89(vg_ExportValue)
	
End if 
