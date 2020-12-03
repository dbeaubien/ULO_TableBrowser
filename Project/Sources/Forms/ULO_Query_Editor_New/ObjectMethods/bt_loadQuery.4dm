C_TEXT:C284($vt_selected)

If (Form event code:C388=On Clicked:K2:4)
	
	$vt_selected:=Dynamic pop up menu:C1006(vt_loadMenu)
	
	If ($vt_selected#"") & ($vt_selected#"n/a")
		
		Form:C1466.selectedQuery:=ds:C1482["uloData"].get($vt_selected)
		If (Form:C1466.selectedQuery#Null:C1517)
			Form:C1466.lastQuery:=Form:C1466.selectedQuery.detail.query
			EXECUTE METHOD IN SUBFORM:C1085("queryLines";"QE_LINES_METHOD";*;"LOAD";Form:C1466)
		End if 
	End if 
End if 
