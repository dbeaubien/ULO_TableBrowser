//%attributes = {"shared":true}
C_OBJECT:C1216($1;$vo_sub;$es;$es_return)
C_TEXT:C284($vt_eventObject;$vt_value;$vt_method)
C_LONGINT:C283($vl_event;$cp;$row;$vl_table;$vl_selected;$index;$vl_buttonNumber)
C_POINTER:C301($vp_nil)
C_BOOLEAN:C305($vb_buttonUpdate)
$vl_event:=$1.code
If (OB Is defined:C1231($1;"objectName"))
	$vt_eventObject:=$1.objectName
Else 
	$vt_eventObject:="form"
End if 

$vb_buttonUpdate:=True:C214
Case of 
	: ($vt_eventObject="form")
		Case of 
			: ($vl_event=On Load:K2:1)
				Form:C1466.resize:=False:C215
				Form:C1466.pendingResize:=False:C215
				Form:C1466.refresh:=True:C214
				
				ULO_LOAD_BUTTONS (Form:C1466.buttons)
				$index:=Form:C1466.navItems.findIndex("UTIL_Find_Collection";"handle";Form:C1466.sidebarStart)
				If ($index=-1)
					$index:=1
				End if 
				LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$index+1;lk replace selection:K53:1)
				ULO_LOAD_VIEW 
				$vb_buttonUpdate:=False:C215
				SET TIMER:C645(1)
				
			: ($vl_event=On Timer:K2:25)
				Case of 
					: (Form:C1466.refresh)
						Form:C1466.refresh:=False:C215
						SET TIMER:C645(0)
					: (Form:C1466.resizing)
						Form:C1466.resizing:=False:C215
						Form:C1466.pendingResize:=True:C214
					Else 
						If (Form:C1466.pendingResize)
							ULO_COLUMN_RESIZE 
						End if 
						SET TIMER:C645(0)
				End case 
				
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
				
			: ($vl_event=On Selection Change:K2:29)  // | ($vl_event=On Clicked)
				If (Form:C1466.navItem#Null:C1517)
					If (Form:C1466.navItem.type="header")
						LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
					Else 
						ULO_LOAD_VIEW 
					End if 
				Else 
					LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
				End if 
				
		End case 
		
	: ($vt_eventObject="ULO_LIST")
		Case of 
			: ($vl_event=On Double Clicked:K2:5)
				If (OB Is defined:C1231(Form:C1466.navItem;"rowDoubleClick"))
					$vt_method:=Form:C1466.navItem.rowDoubleClick
					If (Form:C1466.record#Null:C1517)
						EXECUTE METHOD:C1007($vt_method;*;"Double click test: "+JSON Stringify:C1217(Form:C1466.record.toObject()))
					End if 
				End if 
				
			: ($vl_event=On Clicked:K2:4) & (Right click:C712)
				If (OB Is defined:C1231(Form:C1466.navItem;"rowContext"))
					$vt_method:=Form:C1466.navItem.rowContext
					If (Form:C1466.record#Null:C1517)
						EXECUTE METHOD:C1007($vt_method;*;"context test: "+JSON Stringify:C1217(Form:C1466.record.toObject()))
					End if 
				End if 
				
			: ($vl_event=On Column Resize:K2:31)
				  //Resize event is fired for every pixel that the column is changed by
				  //Therefore Case in On Timer event handles the saving of new widths
				  //after the user has finished resizing
				Form:C1466.resizing:=True:C214
				SET TIMER:C645(1)
				
		End case 
		
	: ($vt_eventObject="SearchPop@")
		
	: ($vt_eventObject="SearchText_@")  //Text field from the find widget
		Case of 
			: ($vl_event=On Selection Change:K2:29)
				$vt_value:=OBJECT Get pointer:C1124(Object named:K67:5;"ULO_DEFAULT_FIND")->  //Get the value from the find object
				$es_return:=Form:C1466.uloList
				$index:=Storage:C1525.buttons.findIndex("UTIL_Find_Collection";"action";"FIND")
				If ($index>=0)
					If (Storage:C1525.buttons[$index].method#"")  //If there is a host search method specified
						EXECUTE METHOD:C1007(Storage:C1525.buttons[$index].method;$es_return;Form:C1466.tableNumber;$vt_value)  //Return an entity selection
					End if 
				End if 
				Form:C1466.uloList:=$es_return
				
		End case 
		
	: ($vt_eventObject="ULO_Button_VIEW") | ($vt_eventObject="ULO_ButtonBG_VIEW")
		
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_VIEW_POP   //ALERT("VIEW Button Clicked!")
		End case 
		
	: ($vt_eventObject="ULO_Button_PRINT") | ($vt_eventObject="ULO_ButtonBG_PRINT")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_PRINT_POP   //ALERT("PRINT Button Clicked!")
		End case 
	: ($vt_eventObject="ULO_Button_SHOWALL")
		  //Need to make callback to host for filter
		Case of 
			: ($vl_event=On Clicked:K2:4)
				$vl_table:=Form:C1466.tableNumber
				$es:=ds:C1482[Table name:C256(Form:C1466.tableNumber)].all()
				If (Storage:C1525.hostMethods.filter#"")
					EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es;Form:C1466.tableNumber;$es)
				End if 
				Form:C1466.uloList:=$es
		End case 
		
	: ($vt_eventObject="ULO_Button_SHOWSUBSET")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				Form:C1466.uloList:=Form:C1466.records
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
		End case 
		
	: ($vt_eventObject="ULO_Button_OMITSUBSET")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				Form:C1466.uloList:=Form:C1466.uloList.minus(Form:C1466.records)
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
		End case 
		
	: ($vt_eventObject="ULO_Button_SEARCH")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_SEARCH_POP 
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
		End case 
		
	Else 
		Case of 
			: ($vl_event=On Clicked:K2:4)
				ALERT:C41($vt_eventObject)
				  //ALERT(OBJECT Get title(*;$vt_eventObject)+" : "+String($vl_event))
				$vl_buttonNumber:=Num:C11($vt_eventObject)
				$vt_method:=Form:C1466.buttons[$vl_buttonNumber].method
				  //pass
				  //tableNumber
				  //entitySelection
				EXECUTE METHOD:C1007($vt_method;*;$1;Form:C1466.navItem;JSON Stringify:C1217(Form:C1466.buttons[$vl_buttonNumber]))
		End case 
		
End case 


  //Does this need to update on every event?
If ($vb_buttonUpdate)
	$vl_selected:=Form:C1466.records.length
	OBJECT SET ENABLED:C1123(*;"ULO_Button_SHOWSUBSET";($vl_selected>0))
	OBJECT SET ENABLED:C1123(*;"ULO_Button_OMITSUBSET";($vl_selected>0))
End if 