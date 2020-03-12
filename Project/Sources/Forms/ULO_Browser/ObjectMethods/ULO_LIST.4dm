
Case of 
	: (Form event code:C388=On Column Resize:K2:31)
		ULO_BROWSER_EVENT (FORM Event:C1606)
	: (Form event code:C388=On Header Click:K2:40)
		Form:C1466.navItem.selectedSort:=Null:C1517
		ULO_LOAD_SORT 
		
		
		  //TRACE
		ULO_BROWSER_EVENT (FORM Event:C1606)
		  //$0:=-1  //Disables default sort
End case 
