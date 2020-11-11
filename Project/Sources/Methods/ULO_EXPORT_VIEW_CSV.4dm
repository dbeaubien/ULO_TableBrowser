//%attributes = {}

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
C_OBJECT:C1216($1;$es_records)
C_LONGINT:C283($vl_Progress)
C_LONGINT:C283($recordIndex;$vl_headerFormat;$vl_font;$vl_workbook;$vl_worksheet)
C_LONGINT:C283($cp;$fieldIndex;$vl_fia;$width;$height)
C_TIME:C306($vh_Doc)
C_TEXT:C284(vt_ExportValue;$vt_filename)
C_OBJECT:C1216($vo_col;$e_record)
$cp:=Count parameters:C259

  //Ask the user to create and name a document
$vh_Doc:=Create document:C266("";"csv")

If (OK=1)  //If user has created a document ....
	$es_records:=$1
	$vl_Progress:=Progress New 
	$vt_filename:=Document
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting view please wait ...")
	
	Progress SET PROGRESS ($vl_Progress;-1;"Exporting headers...")
	
	  //****** ADD HEADERS *******
	$fieldIndex:=1
	For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
		If ($vo_col.selected) & ($vo_col.fieldType#Is picture:K8:10)
			  //Tom can the header format be determined by the customisation?
			SEND PACKET:C103($vh_Doc;$vo_col.header)
			If ($fieldIndex=Form:C1466.navItem.selectedView.detail.cols.length)
				SEND PACKET:C103($vh_Doc;Char:C90(Carriage return:K15:38))
			Else 
				SEND PACKET:C103($vh_Doc;",")
			End if 
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
				
				Case of   //Export the field/formula value according to data type ...
					: ($vo_col.fieldType=Is integer:K8:5) | ($vo_col.fieldType=Is longint:K8:6) | ($vo_col.fieldType=Is real:K8:4)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:=string("+$e_record[$vo_col.formula]+")")
						Else 
							vt_ExportValue:=String:C10($e_record[$vo_col.formula])
						End if 
						
					: ($vo_col.fieldType=Is alpha field:K8:1) | ($vo_col.fieldType=Is text:K8:3)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:="+$e_record[$vo_col.formula])
						Else 
							vt_ExportValue:=Replace string:C233($e_record[$vo_col.formula];Char:C90(Double quote:K15:41);Char:C90(Quote:K15:44))
						End if 
						
					: ($vo_col.fieldType=Is date:K8:7)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:=string("+$e_record[$vo_col.formula]+")")
						Else 
							vt_ExportValue:=String:C10($e_record[$vo_col.formula])
						End if 
						
					: ($vo_col.fieldType=Is time:K8:8)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:=string("+$e_record[$vo_col.formula]+")")
						Else 
							vt_ExportValue:=String:C10($e_record[$vo_col.formula])
						End if 
						
					: ($vo_col.fieldType=Is boolean:K8:9)
						If ($vo_col.field<0)
							EXECUTE FORMULA:C63("vt_ExportValue:=string("+$e_record[$vo_col.formula]+")")
						Else 
							vt_ExportValue:=String:C10($e_record[$vo_col.formula])
						End if 
						
				End case   //END field type case
				$fieldIndex:=$fieldIndex+1
				
				SEND PACKET:C103($vh_Doc;vt_ExportValue)
				  //Tag the column or record end
				If ($fieldIndex=Form:C1466.navItem.selectedView.detail.cols.length)
					SEND PACKET:C103($vh_Doc;Char:C90(Carriage return:K15:38))
				Else 
					SEND PACKET:C103($vh_Doc;",")
				End if 
				
			End if   //END selected check
		End for each   //END field loop
		
		Progress SET PROGRESS ($vl_Progress;-1;"Exporting: "+String:C10($recordIndex)+" of  "+String:C10($es_records.length))
		$recordIndex:=$recordIndex+1
	End for each   //END record loop
	Progress QUIT ($vl_Progress)
	CLOSE DOCUMENT:C267($vh_Doc)
	SHOW ON DISK:C922($vt_filename)
	CLEAR VARIABLE:C89(vt_ExportValue)
End if 
