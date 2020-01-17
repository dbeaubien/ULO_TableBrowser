//%attributes = {"shared":true}
C_OBJECT:C1216($1;$vo_sub;$es;$es_return)
C_TEXT:C284($vt_eventObject)
C_LONGINT:C283($vl_event;$cp;$row;$vl_table)
C_POINTER:C301($vp_nil)
$vl_event:=$1.code
If (OB Is defined:C1231($1;"objectName"))
	$vt_eventObject:=$1.objectName
Else 
	$vt_eventObject:="form"
End if 

Case of 
	: ($vt_eventObject="form")
		Case of 
			: ($vl_event=On Load:K2:1)
				ULO_LOAD_BUTTONS (Form:C1466.buttons)
				$index:=Form:C1466.navItems.findIndex("UTIL_Find_Collection";"handle";Form:C1466.sidebarStart)
				If ($index=-1)
					$index:=1
				End if 
				LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$index+1;lk replace selection:K53:1)
				ULO_LOAD_VIEW 
				
		End case 
		
		
	: ($vt_eventObject="ULO_Navbar")
		Case of 
			: ($vl_event=On Double Clicked:K2:5)
				
				  //NEEDS RE_WRITING
				If (Form:C1466.navItem.sub#Null:C1517)
					If (Form:C1466.navItem.sub.length>0)
						If (Form:C1466.navItem.collapsed)  //Then expand based on type
							For each ($vo_sub;Form:C1466.navItem.sub)
								Form:C1466.navItems.insert(Form:C1466.selectedNavItem;$vo_sub)
							End for each 
							Form:C1466.navItem.collapsed:=False:C215
						Else   //Then collapse
							If (UTIL_Recursive_Find_Col (Form:C1466.navItem.sub;"index";Form:C1466.lastNavItemIndex;"sub")=Null:C1517)
								For each ($vo_sub;Form:C1466.navItem.sub)
									Form:C1466.navItems.remove(Form:C1466.selectedNavItem)
								End for each 
								Form:C1466.navItem.collapsed:=True:C214
							End if 
						End if 
						Form:C1466.navItems:=Form:C1466.navItems
					End if   //END Check that the navItem has sub elements
				End if   //END Check Form.navItem.sub not null
				If (Form:C1466.navItem.type="header")
					LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
				End if 
				
			: ($vl_event=On Clicked:K2:4) | ($vl_event=On Selection Change:K2:29)
				If (Form:C1466.navItem.type="header")
					LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
					
				Else 
					ULO_LOAD_VIEW 
					  //$vo_uloData.lastNavItemIndex
				End if 
		End case 
		
	: ($vt_eventObject="ULO_LIST")
		Case of 
			: ($vl_event=On Clicked:K2:4) & (Right click:C712)
				If (OB Is defined:C1231(Form:C1466.navItem;"rowContext"))
					$vt_method:=Form:C1466.navItem.rowContext
					If (Form:C1466.record#Null:C1517)
						EXECUTE METHOD:C1007($vt_method;*;"context test: "+JSON Stringify:C1217(Form:C1466.record.toObject()))
					End if 
				End if 
				
			: ($vl_event=On Double Clicked:K2:5)
				If (OB Is defined:C1231(Form:C1466.navItem;"rowDoubleClick"))
					$vt_method:=Form:C1466.navItem.rowDoubleClick
					If (Form:C1466.record#Null:C1517)
						EXECUTE METHOD:C1007($vt_method;*;"Double click test: "+JSON Stringify:C1217(Form:C1466.record.toObject()))
					End if 
				End if 
				
		End case 
	: ($vt_eventObject="SearchPop@")
		
	: ($vt_eventObject="ULO_DEFAULT_FIND")
		ULO_DEFAULT_FIND ($1)
		
	: ($vt_eventObject="ULO_Button_VIEW") | ($vt_eventObject="ULO_ButtonBG_VIEW")
		
		BUTTON_VIEW_POP   //ALERT("VIEW Button Clicked!")
		
	: ($vt_eventObject="ULO_Button_PRINT") | ($vt_eventObject="ULO_ButtonBG_PRINT")
		BUTTON_PRINT_POP   //ALERT("PRINT Button Clicked!")
		
	: ($vt_eventObject="ULO_Button_SHOWALL")
		  //Need to make callback to host for filter
		$vl_table:=Form:C1466.tableNumber
		$es:=ds:C1482[Table name:C256(Form:C1466.tableNumber)].all()
		EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es_return;$vl_table;$es)
		Form:C1466.uloList:=$es_return
		
	: ($vt_eventObject="ULO_Button_SHOWSUBSET")
		Form:C1466.uloList:=Form:C1466.records
		
	: ($vt_eventObject="ULO_Button_OMITSUBSET")
		Form:C1466.uloList:=Form:C1466.uloList.minus(Form:C1466.records)
		
		
	Else 
		ALERT:C41($vt_eventObject)
		  //ALERT(OBJECT Get title(*;$vt_eventObject)+" : "+String($vl_event))
		$vl_buttonNumber:=Num:C11($vt_eventObject)
		$vt_method:=Form:C1466.buttons[$vl_buttonNumber].method
		  //pass
		  //tableNumber
		  //entitySelection
		EXECUTE METHOD:C1007($vt_method;*;$1;Form:C1466.navItem;JSON Stringify:C1217(Form:C1466.buttons[$vl_buttonNumber]))
End case 