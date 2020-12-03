C_OBJECT:C1216($vo_res)

If (Form event code:C388=On Clicked:K2:4)
	
	If (OB Is defined:C1231(Form:C1466.selectedQuery;"user"))
		If (Storage:C1525.user.id=Form:C1466.selectedQuery.user)
			CONFIRM:C162("Are you sure you wish to delete the Query "+Form:C1466.selectedQuery.name+"? There is NO undo!")
			If (OK=1)
				$vo_res:=Form:C1466.selectedQuery.drop()
				If ($vo_res.success)
					Form:C1466.selectedQuery:=New object:C1471
					vt_loadMenu:=QE_BUILD_LOAD_MENU (Form:C1466.tableNumber)
					ALERT:C41("Query Deleted!")
				Else 
					ALERT:C41("Error deleting Query: "+$vo_res.statusText)
				End if 
			End if 
		Else 
			ALERT:C41("Selected Query was not created by you!")
		End if 
	Else 
		ALERT:C41("No Query selected!")
	End if 
End if 