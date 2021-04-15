//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 20/02/20, 15:28:52
  // ----------------------------------------------------
  // Method: ULO_EXPORT_VIEW_CSV
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

  //Declare
C_OBJECT:C1216($1;$es_records)
C_LONGINT:C283($vl_Progress)
C_LONGINT:C283($recordIndex;$vl_headerFormat;$vl_font;$vl_workbook;$vl_worksheet)
C_LONGINT:C283($cp;$fieldIndex;$vl_fia;$width;$height)
C_TIME:C306($vh_Doc)
C_TEXT:C284(vt_ExportValue;$vt_filename)
C_OBJECT:C1216($vo_col;$e_record;e_record;$vo_formula;vo_colObj)
C_COLLECTION:C1488($vc_selectedCols)
$cp:=Count parameters:C259

  //Ask the user to create and name a document
$vh_Doc:=Create document:C266("";"csv")
If (OK=1)  //If user has created a document ....
	$es_records:=$1
	$vl_Progress:=Progress New 
	$vt_filename:=Document
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting view please wait ...")
	
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting headers...")
	
	  //Get non-picture selected columns to remove need to check selected in following loops
	$vc_selectedCols:=Form:C1466.navItem.selectedView.detail.cols.query("selected == :1 && fieldType # :2";True:C214;Is picture:K8:10)
	
	  //****** ADD HEADERS *******
	$fieldIndex:=1
	For each ($vo_col;$vc_selectedCols)
		  //Tom can the header format be determined by the customisation?
		SEND PACKET:C103($vh_Doc;$vo_col.header)
		If ($fieldIndex=$vc_selectedCols.length)
			SEND PACKET:C103($vh_Doc;Char:C90(Carriage return:K15:38))
		Else 
			SEND PACKET:C103($vh_Doc;",")
		End if 
		$fieldIndex:=$fieldIndex+1
	End for each   //END field loop for header
	vo_colObj:=New object:C1471("case";"data")
	
	  //Loop through the records
	$recordIndex:=1
	For each (e_record;$es_records)
		
		  //Then loop through the columns
		$fieldIndex:=1  //Used for excel column number
		For each ($vo_col;$vc_selectedCols)
			vt_ExportValue:=""
			
			If ($vo_col.formula#"")  //To prevent errors in Execute Formula
				Case of   //Export the field/formula value according to data type ...
					: ($vo_col.fieldType=Is integer:K8:5) | ($vo_col.fieldType=Is longint:K8:6) | ($vo_col.fieldType=Is real:K8:4)
						If ($vo_col.table<0)  //Table less than 0 is a custom formula
							$vo_formula:=Formula from string:C1601($vo_col.formula)
							vt_ExportValue:=String:C10($vo_formula.call(e_record))
						Else 
							EXECUTE FORMULA:C63("vt_ExportValue:=String(e_record."+$vo_col.formula+")")
						End if 
						
					: ($vo_col.fieldType=Is alpha field:K8:1) | ($vo_col.fieldType=Is text:K8:3)
						If ($vo_col.table<0)
							$vo_formula:=Formula from string:C1601($vo_col.formula)
							vt_ExportValue:=$vo_formula.call(e_record)
						Else 
							EXECUTE FORMULA:C63("vt_ExportValue:=e_record."+$vo_col.formula)
						End if 
						vt_ExportValue:=Replace string:C233(vt_ExportValue;Char:C90(Double quote:K15:41);Char:C90(Quote:K15:44))
						
					: ($vo_col.fieldType=Is date:K8:7)
						If ($vo_col.table<0)
							$vo_formula:=Formula from string:C1601($vo_col.formula)
							vt_ExportValue:=String:C10($vo_formula.call(e_record))
						Else 
							EXECUTE FORMULA:C63("vt_ExportValue:=String(e_record."+$vo_col.formula+")")
						End if 
						
					: ($vo_col.fieldType=Is time:K8:8)
						If ($vo_col.table<0)
							$vo_formula:=Formula from string:C1601($vo_col.formula)
							vt_ExportValue:=String:C10($vo_formula.call(e_record))
						Else 
							EXECUTE FORMULA:C63("vt_ExportValue:=String(e_record."+$vo_col.formula+")")
						End if 
						
					: ($vo_col.fieldType=Is boolean:K8:9)
						If ($vo_col.table<0)
							$vo_formula:=Formula from string:C1601($vo_col.formula)
							vt_ExportValue:=String:C10($vo_formula.call(e_record))
						Else 
							EXECUTE FORMULA:C63("vt_ExportValue:=String(e_record."+$vo_col.formula+")")
						End if 
						
				End case   //END field type case
			End if 
			
			SEND PACKET:C103($vh_Doc;vt_ExportValue)
			  //Tag the column or record end
			If ($fieldIndex=$vc_selectedCols.length)
				SEND PACKET:C103($vh_Doc;Char:C90(Carriage return:K15:38))
			Else 
				SEND PACKET:C103($vh_Doc;",")
			End if 
			$fieldIndex:=$fieldIndex+1
		End for each   //END field loop
		
		Progress SET PROGRESS ($vl_Progress;-1;"Exporting: "+String:C10($recordIndex)+" of  "+String:C10($es_records.length))
		$recordIndex:=$recordIndex+1
	End for each   //END record loop
	Progress QUIT ($vl_Progress)
	CLOSE DOCUMENT:C267($vh_Doc)
	SHOW ON DISK:C922($vt_filename)
	CLEAR VARIABLE:C89(vt_ExportValue)
End if 
