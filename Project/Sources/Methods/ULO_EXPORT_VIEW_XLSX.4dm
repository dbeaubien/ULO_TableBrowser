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
C_LONGINT:C283($i;$vl_Progress;$recordIndex;$vl_headerFormat;$vl_font;\
$vl_workbook;$vl_worksheet;$vl_tempFooterFont;$cp;$fieldIndex;$vl_fia;\
$width;$height;$vl_footerRow;$vl_fontSize;$vl_rowBgAltColour;$vl_rowBgColour;\
$vl_headerFormat;$vl_font;$vl_dateFormat;$vl_dateNr;$vl_PictureID;\
$vl_customHeaderFormat;$vl_fontColour;$vl_hLineColour;$vl_vLineColour;$vl_tempFont)
C_OBJECT:C1216($1;$es_records)
C_TIME:C306($vh_Doc)
C_TEXT:C284(vt_ExportValue;$vt_filename;$vt_font;$vt_formula;$vt_col)
C_REAL:C285(vr_ExportValue)
C_PICTURE:C286(vg_ExportValue)
C_DATE:C307(vd_ExportValue)
C_OBJECT:C1216($vo_col;$e_record;$vo_footer;$e_theme;$vo_theme)
C_COLLECTION:C1488($vc_footers;$vc_temp;$vc_colThemes;$vc_columnThemes)
C_BOOLEAN:C305($vb_alt;$vb_horiLines;$vb_vertLines)

ARRAY LONGINT:C221($al_picColumns;0)
ARRAY LONGINT:C221($al_colWidths;0)
$cp:=Count parameters:C259
$vc_columnThemes:=New collection:C1472

  //Ask the user to create and name a document
$vh_Doc:=Create document:C266("";"xlsx")

If (OK=1)  //If user has created a document ....
	$es_records:=$1
	$vl_Progress:=Progress New 
	CLOSE DOCUMENT:C267($vh_Doc)
	$vt_filename:=Document
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting view please wait ...")
	
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting headers...")
	
	  //****** CREATE WORKBOOK*****
	$vl_workbook:=xlBookCreateXML 
	xlBookSetRGBMode ($vl_workbook;1)
	
	  //***** CREATE FORMATS *****
	
	$vl_dateFormat:=xlBookAddFormat ($vl_workbook)
	$vl_dateNr:=xlBookAddCustomNumFormat ($vl_workbook;"dd/mm/yyyy")
	xlFormatSetNumFormat ($vl_dateFormat;$vl_dateNr)
	
	$vl_worksheet:=xlBookAddSheet ($vl_workbook;"Export View")
	
	
	  // ***** CREATE CUSTOM FORMATS **********
	
	$e_theme:=ds:C1482["uloData"].query("type == 3 && user == :1";Storage:C1525.user.id).first()
	If ($e_theme#Null:C1517)
		$vo_theme:=$e_theme.detail.theme
		xlBookSetDefaultFont ($vl_workbook;$vo_theme.rowFont;$vo_theme.rowFontSize)
		
		$vl_headerFormat:=xlBookAddFormat ($vl_workbook)
		$vl_font:=xlBookAddFont ($vl_workbook)
		xlFormatSetFont ($vl_headerFormat;$vl_font)
		
		xlFontSetName ($vl_font;$vo_theme.headerFont)
		xlFontSetSize ($vl_font;$vo_theme.headerFontSize)
		xlFontSetColor ($vl_font;$vo_theme.headerFontColour)
		xlFormatSetFillPattern ($vl_headerFormat;xlFillPattern_Solid)
		xlFormatSetPatternColors ($vl_headerFormat;$vo_theme.headerBgColour)
		xlFormatSetHAlignment ($vl_headerFormat;xlAlignH_Center)
		
		$vt_font:=$vo_theme.rowFont
		$vl_fontSize:=$vo_theme.rowFontSize
		$vl_fontColour:=$vo_theme.rowFontColour
		$vl_rowBgColour:=$vo_theme.rowColour
		$vl_rowBgAltColour:=$vo_theme.rowAltColour
		
		$vb_horiLines:=$vo_theme.showHLine
		$vb_vertLines:=$vo_theme.showVLine
		
		$vl_hLineColour:=$vo_theme.hLineColour
		$vl_vLineColour:=$vo_theme.vLineColour
		
	Else 
		xlBookSetDefaultFont ($vl_workbook;"Arial";10)
		
		$vl_headerFormat:=xlBookAddFormat ($vl_workbook)
		$vl_font:=xlBookAddFont ($vl_workbook)
		xlFormatSetFont ($vl_headerFormat;$vl_font)
		xlFontSetName ($vl_font;"Arial")
		xlFontSetBold ($vl_font;1)
		xlFormatSetHAlignment ($vl_headerFormat;xlAlignH_Center)
		
		$vt_font:="Arial"
		$vl_fontSize:=10
		$vl_fontColour:=0x0000
		
		$vb_horiLines:=True:C214
		$vb_vertLines:=True:C214
		
		$vl_hLineColour:=0x0000
		$vl_vLineColour:=0x0000
		
	End if 
	
	For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
		$vc_colThemes:=New collection:C1472(0;0;0)  //Row, Alt Row, Footer Formats
		
		$vl_tempFont:=xlBookAddFont ($vl_workbook)
		$vl_tempFooterFont:=xlBookAddFont ($vl_workbook)
		xlFontSetName ($vl_tempFont;$vt_font)
		xlFontSetSize ($vl_tempFont;$vl_fontSize)
		xlFontSetName ($vl_tempFooterFont;$vt_font)
		xlFontSetSize ($vl_tempFooterFont;$vl_fontSize)
		
		If (Storage:C1525.prefs.exportViewThemeColours)
			If ($vo_col.fontColourOverride)
				xlFontSetColor ($vl_tempFont;$vo_col.fontColour)
				xlFontSetColor ($vl_tempFooterFont;$vo_col.fontColour)
			Else 
				xlFontSetColor ($vl_tempFont;$vl_fontColour)
				xlFontSetColor ($vl_tempFooterFont;$vl_fontColour)
			End if 
			
			  //Font Decoration
			Case of 
				: ($vo_col.fontStyle=1)
					xlFontSetBold ($vl_tempFont;1)
					xlFontSetBold ($vl_tempFooterFont;1)
					
				: ($vo_col.fontStyle=2)
					xlFontSetItalic ($vl_tempFont;1)
					xlFontSetItalic ($vl_tempFooterFont;1)
					
				: ($vo_col.fontStyle=3)
					xlFontSetBold ($vl_tempFont;1)
					xlFontSetItalic ($vl_tempFont;1)
					xlFontSetBold ($vl_tempFooterFont;1)
					xlFontSetItalic ($vl_tempFooterFont;1)
					
				: ($vo_col.fontStyle=4)
					xlFontSetUnderline ($vl_tempFont;1)
					xlFontSetUnderline ($vl_tempFooterFont;1)
					
				: ($vo_col.fontStyle=5)
					xlFontSetBold ($vl_tempFont;1)
					xlFontSetUnderline ($vl_tempFont;1)
					xlFontSetBold ($vl_tempFooterFont;1)
					xlFontSetUnderline ($vl_tempFooterFont;1)
					
				: ($vo_col.fontStyle=6)
					xlFontSetItalic ($vl_tempFont;1)
					xlFontSetUnderline ($vl_tempFont;1)
					xlFontSetItalic ($vl_tempFooterFont;1)
					xlFontSetUnderline ($vl_tempFooterFont;1)
					
				: ($vo_col.fontStyle=7)
					xlFontSetBold ($vl_tempFont;1)
					xlFontSetItalic ($vl_tempFont;1)
					xlFontSetUnderline ($vl_tempFont;1)
					xlFontSetBold ($vl_tempFooterFont;1)
					xlFontSetItalic ($vl_tempFooterFont;1)
					xlFontSetUnderline ($vl_tempFooterFont;1)
					
			End case 
		End if 
		
		xlFontSetBold ($vl_tempFooterFont;1)  //Ensure footer is always bold
		
		$vc_colThemes[0]:=xlBookAddFormat ($vl_workbook)
		$vc_colThemes[1]:=xlBookAddFormat ($vl_workbook)  //Alt row colour
		$vc_colThemes[2]:=xlBookAddFormat ($vl_workbook)  //Footer
		
		xlFormatSetFont ($vc_colThemes[0];$vl_tempFont)
		xlFormatSetFont ($vc_colThemes[1];$vl_tempFont)
		xlFormatSetFont ($vc_colThemes[2];$vl_tempFooterFont)
		
		If (Storage:C1525.prefs.exportViewThemeColours)
			Case of 
				: ($vb_horiLines) & ($vb_vertLines)
					xlFormatSetBorderStyle ($vc_colThemes[0];xlBorderStyle_Thin)
					xlFormatSetBorderStyle ($vc_colThemes[1];xlBorderStyle_Thin)
					xlFormatSetBorderStyle ($vc_colThemes[2];xlBorderStyle_Thin)
					
					xlFormatSetBorderColors ($vc_colThemes[0];$vl_hLineColour;$vl_hLineColour;$vl_vLineColour;$vl_vLineColour)
					xlFormatSetBorderColors ($vc_colThemes[1];$vl_hLineColour;$vl_hLineColour;$vl_vLineColour;$vl_vLineColour)
					xlFormatSetBorderColors ($vc_colThemes[2];$vl_hLineColour;$vl_hLineColour;$vl_vLineColour;$vl_vLineColour)
					
				: ($vb_horiLines)
					xlFormatSetBorderStyles ($vc_colThemes[0];xlBorderStyle_Thin;xlBorderStyle_Thin;0;0)
					xlFormatSetBorderStyles ($vc_colThemes[1];xlBorderStyle_Thin;xlBorderStyle_Thin;0;0)
					xlFormatSetBorderStyles ($vc_colThemes[2];xlBorderStyle_Thin;xlBorderStyle_Thin;0;0)
					
					xlFormatSetBorderColor ($vc_colThemes[0];$vl_hLineColour)
					xlFormatSetBorderColor ($vc_colThemes[1];$vl_hLineColour)
					xlFormatSetBorderColor ($vc_colThemes[2];$vl_hLineColour)
					
				: ($vb_vertLines)
					xlFormatSetBorderStyles ($vc_colThemes[0];0;0;xlBorderStyle_Thin;xlBorderStyle_Thin)
					xlFormatSetBorderStyles ($vc_colThemes[1];0;0;xlBorderStyle_Thin;xlBorderStyle_Thin)
					xlFormatSetBorderStyles ($vc_colThemes[2];0;0;xlBorderStyle_Thin;xlBorderStyle_Thin)
					
					xlFormatSetBorderColor ($vc_colThemes[0];$vl_vLineColour)
					xlFormatSetBorderColor ($vc_colThemes[1];$vl_vLineColour)
					xlFormatSetBorderColor ($vc_colThemes[2];$vl_vLineColour)
					
			End case 
			
			xlFormatSetFillPattern ($vc_colThemes[0];xlFillPattern_Solid)
			xlFormatSetPatternColors ($vc_colThemes[0];$vl_rowBgColour)
			
			xlFormatSetFillPattern ($vc_colThemes[1];xlFillPattern_Solid)
			xlFormatSetPatternColors ($vc_colThemes[1];$vl_rowBgAltColour)
			
			xlFormatSetFillPattern ($vc_colThemes[2];xlFillPattern_Solid)
			xlFormatSetPatternColors ($vc_colThemes[2];$vl_rowBgColour)
		End if 
		
		Case of 
			: ($vo_col.alignment="Left")
				xlFormatSetHAlignment ($vc_colThemes[0];xlAlignH_Left)
				xlFormatSetHAlignment ($vc_colThemes[1];xlAlignH_Left)
				xlFormatSetHAlignment ($vc_colThemes[2];xlAlignH_Left)
				
			: ($vo_col.alignment="Right")
				xlFormatSetHAlignment ($vc_colThemes[0];xlAlignH_Right)
				xlFormatSetHAlignment ($vc_colThemes[1];xlAlignH_Right)
				xlFormatSetHAlignment ($vc_colThemes[2];xlAlignH_Right)
				
			: ($vo_col.alignment="Center")
				xlFormatSetHAlignment ($vc_colThemes[0];xlAlignH_Center)
				xlFormatSetHAlignment ($vc_colThemes[1];xlAlignH_Center)
				xlFormatSetHAlignment ($vc_colThemes[2];xlAlignH_Center)
				
		End case 
		
		Case of 
			: ($vo_col.fieldType=Is integer:K8:5) | ($vo_col.fieldType=Is longint:K8:6) | ($vo_col.fieldType=Is real:K8:4)
				xlFormatSetNumFormat ($vc_colThemes[0];xlNumFormat_General)
				xlFormatSetNumFormat ($vc_colThemes[1];xlNumFormat_General)
				xlFormatSetNumFormat ($vc_colThemes[2];xlNumFormat_General)
				
			: ($vo_col.fieldType=Is date:K8:7)
				xlFormatSetNumFormat ($vc_colThemes[0];$vl_dateNr)
				xlFormatSetNumFormat ($vc_colThemes[1];$vl_dateNr)
				xlFormatSetNumFormat ($vc_colThemes[2];$vl_dateNr)
				
		End case 
		
		$vc_columnThemes.push($vc_colThemes)
	End for each 
	
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
	For each ($e_record;$es_records)
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
						xlSheetSetCellNumber ($vl_worksheet;$recordIndex+1;$fieldIndex;vr_ExportValue;$vc_columnThemes[$fieldIndex-1][Num:C11($vb_alt)])
						
					: ($vo_col.fieldType=Is alpha field:K8:1) | ($vo_col.fieldType=Is text:K8:3)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vt_ExportValue:=Replace string:C233($e_record[$vo_col.formula];Char:C90(Double quote:K15:41);Char:C90(Quote:K15:44))
						End if 
						xlSheetSetCellText ($vl_worksheet;$recordIndex+1;$fieldIndex;vt_ExportValue;$vc_columnThemes[$fieldIndex-1][Num:C11($vb_alt)])
						
					: ($vo_col.fieldType=Is date:K8:7)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vd_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vd_ExportValue:=$e_record[$vo_col.formula]
						End if 
						xlSheetSetCellDateTime ($vl_worksheet;$recordIndex+1;$fieldIndex;vd_ExportValue;0;0;$vc_columnThemes[$fieldIndex-1][Num:C11($vb_alt)])
						
					: (($vo_col.fieldType=Is time:K8:8) | ($vo_col.fieldType=Is boolean:K8:9))
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:=string("+$e_record[$vo_col.formula]+")")
						Else 
							vt_ExportValue:=String:C10($e_record[$vo_col.formula])
						End if 
						xlSheetSetCellText ($vl_worksheet;$recordIndex+1;$fieldIndex;vt_ExportValue;$vc_columnThemes[$fieldIndex-1][Num:C11($vb_alt)])
						
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
		
		Progress SET PROGRESS ($vl_Progress;-1;"Exporting: "+String:C10($recordIndex)+" of  "+String:C10($es_records.length))
		  //Progress_State ("Update";"Exporting: "+String($recordIndex)+" of  "+String($vl_RIS))
		$recordIndex:=$recordIndex+1
		$vb_alt:=Not:C34($vb_alt)
	End for each   //END record loop
	
	
	  // ********* FOOTERS ********
	$vl_footerRow:=$recordIndex+1
	$vc_footers:=New collection:C1472
	$vc_footers.push(New object:C1471("name";"total";"used";False:C215;"adjust";0))
	$vc_footers.push(New object:C1471("name";"max";"used";False:C215;"adjust";0))
	$vc_footers.push(New object:C1471("name";"min";"used";False:C215;"adjust";0))
	$vc_footers.push(New object:C1471("name";"average";"used";False:C215;"adjust";0))
	
	For each ($vo_footer;$vc_footers)
		$vc_temp:=Form:C1466.navItem.selectedView.detail.cols.query($vo_footer.name+" == :1";True:C214)
		If ($vc_temp.length>0)
			$vo_footer.used:=True:C214
			$vo_footer.adjust:=$vc_footers.query("used == :1";True:C214).length-1
		End if 
	End for each 
	$fieldIndex:=1
	For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
		For each ($vo_footer;$vc_footers)
			If ($vo_col[$vo_footer.name])
				Case of 
					: ($vo_footer.name="total")
						$vt_formula:="=SUM("
					: ($vo_footer.name="max")
						$vt_formula:="=MAX("
					: ($vo_footer.name="min")
						$vt_formula:="=MIN("
					: ($vo_footer.name="average")
						$vt_formula:="=AVERAGE("
				End case 
				$vt_col:=UTIL_Num_To_Excel_Cell ($fieldIndex)
				$vt_formula:=$vt_formula+$vt_col+"2:"+$vt_col+String:C10($recordIndex)+")"
				xlSheetSetCellFormula ($vl_worksheet;($vl_footerRow+$vo_footer.adjust);$fieldIndex;$vt_formula;$vc_columnThemes[$fieldIndex-1][2])
			Else 
				xlSheetSetCellFormat ($vl_worksheet;($vl_footerRow+$vo_footer.adjust);$fieldIndex;$vc_columnThemes[$fieldIndex-1][2])
			End if 
		End for each 
		
		$fieldIndex:=$fieldIndex+1
	End for each 
	
	
	
	
	
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
