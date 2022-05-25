Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		ULO_SET_BACKGROUND 
		
		Form:C1466.displayed:=True:C214
		Form:C1466.message:="Export "+String:C10(Form:C1466.ris)+" record"+("s"*Num:C11(Form:C1466.ris#1))+" in selection..."
		OBJECT SET ENABLED:C1123(*;"ExportExcel";($vo_formData.excelInstalled))
		
	: (FORM Event:C1606.code=On Clicked:K2:4)
		
		Case of 
			: (Form:C1466.displayed)
				Form:C1466.message:="Export "+String:C10(Form:C1466.ris)+" record"+("s"*Num:C11(Form:C1466.ris#1))+" in selection..."
				
			: (Form:C1466.highlighted)
				Form:C1466.message:="Export "+String:C10(Form:C1466.selectedRecords)+" highlighted record"+("s"*Num:C11(Form:C1466.selectedRecords#1))+" ..."
				
			Else 
				Form:C1466.message:=""
				
		End case 
		
		
End case 
