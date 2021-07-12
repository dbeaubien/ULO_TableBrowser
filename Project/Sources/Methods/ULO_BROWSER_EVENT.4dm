//%attributes = {"shared":true}
C_OBJECT:C1216($1;$vo_sub;$es;$es_return;$vo_sort;$vo_sidebar)

C_TEXT:C284($vt_eventObject;$vt_value;$vt_method;$vt_head;$vt_case;$vt_selected;$m_menu)
C_LONGINT:C283($vl_event;$vl_table;$vl_selected;$index;\
$vl_buttonNumber;$vl_idx;$vl_field;$vl_fieldIdx;\
$vl_sortIdx)
C_COLLECTION:C1488($vc_fields;$vc_hostOptions)
C_OBJECT:C1216(vo_colObj;$vo_state)

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
				  //TRACE
				Form:C1466.resize:=False:C215
				Form:C1466.pendingResize:=False:C215
				Form:C1466.footerRefresh:=False:C215
				Form:C1466.refresh:=False:C215
				Form:C1466.fullRefresh:=True:C214
				Form:C1466.forceSelectNav:=False:C215
				Form:C1466.themeSelected:=False:C215
				Form:C1466.themeSelectedId:=""
				Form:C1466.customColumns:=New collection:C1472
				Form:C1466.customSort:=New object:C1471("field";0;"dir";1)
				If (Not:C34(OB Is defined:C1231(Form:C1466;"relate")))
					Form:C1466.relate:=False:C215
				End if 
				
				vo_colObj:=New object:C1471("case";"data")
				
				$index:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"handle";Form:C1466.sidebarStart)
				If ($index=-1)
					$index:=1
				End if 
				  //If desired sidebar item is child, ensure parent(s) are expanded
				If (OB Is defined:C1231(Form:C1466.sidebarSource[$index];"childOfIndex"))
					Form:C1466.sidebarSource[Form:C1466.sidebarSource[$index].childOfIndex].expanded:=True:C214
					If (OB Is defined:C1231(Form:C1466.sidebarSource[Form:C1466.sidebarSource[$index].childOfIndex];"childOfIndex"))
						Form:C1466.sidebarSource[Form:C1466.sidebarSource[Form:C1466.sidebarSource[$index].childOfIndex].childOfIndex].expanded:=True:C214
					End if 
					  //Else is top level item and always visible!
				End if 
				
				  //Set all top level nav headers to expanded
				For each ($vo_sidebar;Form:C1466.sidebarSource)
					If ($vo_sidebar.type="HEADER")
						$vo_sidebar.expanded:=True:C214
					End if 
				End for each 
				
				EXECUTE METHOD:C1007("ULO_FORM_EVENT";*;$1)
				
				
				ULO_SET_BACKGROUND 
				
				ULO_LOAD_THEME 
				ULO_LOAD_BUTTONS (Form:C1466.buttons)
				ULO_LOAD_SHORTCUTS 
				SIDEBAR_REBUILD 
				
				  //Find in Form.navItems
				$index:=UTIL_Col_Find_Index (Form:C1466.navItems;"handle";Form:C1466.sidebarStart)
				If ($index=-1)
					$index:=1
				End if 
				
				LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$index+1;lk replace selection:K53:1)
				Form:C1466.lastNavItemIndex:=$index+1
				  //Case of 
				  //: (Form.navItem.type="DATA")
				  //Form.tableNumber:=Form.navItem.table
				  //ULO_LOAD_VIEW   //This is also calling ULO_LIST_UPDATE_FOOTER if a default view exists
				
				
				  //: (Form.navItem.type="WEB")
				  //ULO_LOAD_WEB_AREA 
				
				  //End case 
				  //If (Storage.hostMethods.sidebarLoad#"")
				  //EXECUTE METHOD(Storage.hostMethods.sidebarLoad;$es_return;Form.tableNumber;Form.navItem.handle)
				  //Form.uloRecords:=$es_return
				  //End if 
				ULO_CREATE_SHORTCUTS 
				
				SET WINDOW RECT:C444(Form:C1466.wLeft;Form:C1466.wTop;Form:C1466.wRight;Form:C1466.wBottom)
				SET TIMER:C645(-1)
				
			: ($vl_event=On Timer:K2:25)
				Case of 
					: (Form:C1466.fullRefresh) | (Form:C1466.refresh)  //compressed both refresh events into the same case as 90% was the same.
						SET TIMER:C645(0)
						If (Form:C1466.relate)
							Form:C1466.navItem.selection:=Form:C1466.uloRecords
							Form:C1466.sidebarSource[$index].selection:=Form:C1466.navItem.selection
							Form:C1466.relate:=False:C215
						End if 
						
						Case of 
							: (Form:C1466.fullRefresh)
								Form:C1466.fullRefresh:=False:C215
								Case of 
									: (Form:C1466.navItem.type="DATA")
										  //Check if table access is disabled and image to display is defined
										If (Not:C34(Form:C1466.navItem.allowedAccess)) & (OB Is defined:C1231(Storage:C1525.prefs;"noAccessImage"))
											  //Access disabled, display image assigned by SET_PREF
											ULO_DISABLE_ACCESS 
										Else 
											Form:C1466.tableNumber:=Form:C1466.navItem.table
											ULO_LOAD_VIEW (True:C214)
										End if 
										
									: (Form:C1466.navItem.type="WEB")
										ULO_LOAD_WEB_AREA 
								End case 
								
								If (OB Is defined:C1231(Form:C1466.navItem;"buttonState"))
									For each ($vo_state;Form:C1466.navItem.buttonState)
										If ($vo_state.disabled)
											ULO_DISABLE_BUTTON ($vo_state.code)
										End if 
									End for each 
								End if 
								
							: (Form:C1466.footerRefresh)
								Form:C1466.footerRefresh:=False:C215
								ULO_LIST_UPDATE_FOOTER 
								
						End case 
						
						$vl_selected:=Form:C1466.selectedRecords.length
						OBJECT SET ENABLED:C1123(*;"ULO_Button_SHOWSUBSET";($vl_selected>0))
						OBJECT SET ENABLED:C1123(*;"ULO_Button_OMITSUBSET";($vl_selected>0))
						ULO_SELECTION_MESSAGE 
						Form:C1466.navItem.selection:=Form:C1466.uloRecords
						Form:C1466.uloRecords:=Form:C1466.uloRecords  //to reload data after user Actions / Contexual actions
						$index:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"index";Form:C1466.navItem.index)
						If ($index>=0)
							Form:C1466.sidebarSource[$index].selection:=Form:C1466.navItem.selection
						End if 
						
					: (Form:C1466.resizing)
						Form:C1466.resizing:=False:C215
						Form:C1466.pendingResize:=True:C214
						
					Else 
						If (Form:C1466.pendingResize)
							ULO_COLUMN_RESIZE 
						End if 
						SET TIMER:C645(0)
				End case 
				
			: ($vl_event=On Outside Call:K2:11)
				TRACE:C157
				
				If (vt_buttonName#"")
					OBJECT SET ENABLED:C1123(*;"ULO_Button_"+vt_buttonName;Not:C34(vb_disableButton))
				End if 
				
		End case 
		
		
	: ($vt_eventObject="ULO_Navbar")
		Case of 
			: ($vl_event=On Double Clicked:K2:5)
				
				SIDEBAR_DBL_CLICK 
				
				
				Case of 
					: (Form:C1466.navItem.type="header")
						LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
						Form:C1466.forceSelectNav:=True:C214
						
					: (Form:C1466.navItem.type="data")
						LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.selectedNavItem;lk replace selection:K53:1)
						
				End case 
				
			: ($vl_event=On Selection Change:K2:29)  // | ($vl_event=On Clicked)
				If (Form:C1466.navItem#Null:C1517)
					Case of 
						: (Form:C1466.navItem.type="HEADER")
							If (Form:C1466.lastNavItemIndex#Form:C1466.selectedNavItem)
								LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
								Form:C1466.forceSelectNav:=True:C214
							End if 
						: (Form:C1466.navItem.type="DATA")
							If (Not:C34(Form:C1466.forceSelectNav))
								
								EXECUTE METHOD:C1007("ULO_FORM_EVENT";*;$1;Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].table;Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].handle)
								
								Form:C1466.tableNumber:=Form:C1466.navItem.table
								Form:C1466.customColumns:=New collection:C1472
								
								If (Not:C34(Form:C1466.navItem.allowedAccess)) & (OB Is defined:C1231(Storage:C1525.prefs;"noAccessImage"))
									  //Access disabled, display image assigned by SET_PREF
									ULO_DISABLE_ACCESS 
								Else 
									ULO_LOAD_VIEW (True:C214)
									ULO_CREATE_SHORTCUTS 
									SET TIMER:C645(-1)
								End if 
							Else 
								Form:C1466.forceSelectNav:=False:C215
							End if 
						: (Form:C1466.navItem.type="WEB")
							If (Not:C34(Form:C1466.forceSelectNav))
								EXECUTE METHOD:C1007("ULO_FORM_EVENT";*;$1;Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].table;Form:C1466.navItems[Form:C1466.lastNavItemIndex-1].handle)
								ULO_LOAD_WEB_AREA 
								ULO_CREATE_SHORTCUTS 
							Else 
								Form:C1466.forceSelectNav:=False:C215
							End if 
					End case 
					
					If (OB Is defined:C1231(Form:C1466.navItem;"buttonState"))
						For each ($vo_state;Form:C1466.navItem.buttonState)
							If ($vo_state.disabled)
								ULO_DISABLE_BUTTON ($vo_state.code)
							End if 
						End for each 
					End if 
					
				Else 
					LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
				End if 
				  //ULO_SELECTION_MESSAGE 
				  //This was causing an error when called here...
		End case 
		
	: ($vt_eventObject="ULO_LIST")
		Case of 
			: ($vl_event=On Double Clicked:K2:5)
				$vt_method:=Storage:C1525.hostMethods.rowDoubleClick  //Defind in INIT_STORAGE and set to a default of "ULO_MODIFY"
				If (Form:C1466.selectedRecord#Null:C1517)
					EXECUTE METHOD:C1007($vt_method;*;Form:C1466.tableNumber;Form:C1466.navItem.handle)
				End if 
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(-1)
				
			: ($vl_event=On Clicked:K2:4) & (Right click:C712)
				
				CONTEXT_CLICK_POP 
				Form:C1466.refresh:=True:C214
				Form:C1466.footerRefresh:=True:C214
				SET TIMER:C645(-1)
				
			: ($vl_event=On Clicked:K2:4)
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(-1)
				
			: ($vl_event=On Column Resize:K2:31)
				  //Resize event is fired for every pixel that the column is changed by
				  //Therefore Case in On Timer event handles the saving of new widths
				  //after the user has finished resizing
				Form:C1466.resizing:=True:C214
				SET TIMER:C645(-1)
		End case 
		
		
	: ($vt_eventObject="ULO_SelectAll")
		LISTBOX SELECT ROW:C912(*;"ULO_LIST";0;lk replace selection:K53:1)
		GOTO OBJECT:C206(*;"ULO_LIST")
		Form:C1466.refresh:=True:C214
		SET TIMER:C645(-1)
		
	: ($vt_eventObject="ULO_ExportView")
		  //If ($vl_event=On Clicked)
		If (Form:C1466.navItem.type="DATA")
			ULO_EXPORT_VIEW 
			
			GOTO OBJECT:C206(*;"ULO_LIST")
			  //End if 
		End if 
	: ($vt_eventObject="ULO_DEFAULT_FIND")
		
		Case of 
			: ($vl_event=On Losing Focus:K2:8)
				
				$vt_value:=OBJECT Get pointer:C1124(Object named:K67:5;"ULO_DEFAULT_FIND")->  //Get the value from the find object
				If (Not:C34(OB Is defined:C1231(Form:C1466.navItem;"findHistory")))
					Form:C1466.navItem.findHistory:=New collection:C1472
				End if 
				If (Form:C1466.navItem.findHistory.indexOf($vt_value)=-1)
					Form:C1466.navItem.findHistory.push($vt_value)
				End if 
				
				$es_return:=Form:C1466.uloRecords
				$index:=UTIL_Col_Find_Index (Storage:C1525.buttons;"action";"FIND")
				If ($index>=0)
					If (Storage:C1525.buttons[$index].method#"")  //If there is a host search method specified
						EXECUTE METHOD:C1007(Storage:C1525.buttons[$index].method;$es_return;Form:C1466.tableNumber;Form:C1466.navItem.handle;$vt_value)  //Return an entity selection
					End if 
				End if 
				If (Storage:C1525.hostMethods.filter#"")
					EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es_return;Form:C1466.tableNumber;Form:C1466.navItem.handle;$es_return)
				End if 
				Form:C1466.uloRecords:=$es_return
				OBJECT Get pointer:C1124(Object named:K67:5;"ULO_DEFAULT_FIND")->:=""  //Clear search field value
				If (Not:C34(Is macOS:C1572))
					OBJECT SET VISIBLE:C603(*;"SearchPopWin";True:C214)
				End if 
				Form:C1466.refresh:=True:C214
				Form:C1466.footerRefresh:=True:C214
				SET TIMER:C645(-1)
		End case 
		
		
	: ($vt_eventObject="SearchText_Win")
		$vt_value:=OBJECT Get pointer:C1124(Object named:K67:5;"ULO_DEFAULT_FIND")->  //Get the value from the find object
		If ($vl_event=On Selection Change:K2:29)
			OBJECT SET VISIBLE:C603(*;"SearchPopWin";($vt_value=""))
		End if 
		
		
	: ($vt_eventObject="SearchPopWin") | ($vt_eventObject="SearchPopMac")
		If ($vl_event=On Clicked:K2:4)
			  //Show menu for selection of value from search history
			If (OB Is defined:C1231(Form:C1466.navItem;"findHistory"))
				If (Form:C1466.navItem.findHistory.length>0)
					$m_menu:=Create menu:C408
					For each ($vt_value;Form:C1466.navItem.findHistory)
						APPEND MENU ITEM:C411($m_menu;$vt_value)
						SET MENU ITEM PARAMETER:C1004($m_menu;-1;$vt_value)
					End for each 
					
					$vt_selected:=Dynamic pop up menu:C1006($m_menu)
					
					If ($vt_selected#"")
						OBJECT Get pointer:C1124(Object named:K67:5;"ULO_DEFAULT_FIND")->:=$vt_selected
						If (Not:C34(Is macOS:C1572))
							OBJECT SET VISIBLE:C603(*;"SearchPopWin";($vt_value=""))
						End if 
						
						If (Is macOS:C1572)
							EXECUTE METHOD IN SUBFORM:C1085("ULO_DEFAULT_FIND";"UTIL_SUBFORM_GOTO";*;"SearchText_Mac")
						Else 
							EXECUTE METHOD IN SUBFORM:C1085("ULO_DEFAULT_FIND";"UTIL_SUBFORM_GOTO";*;"SearchText_Win")
						End if 
					End if 
				End if 
			End if 
		End if 
		
		
	: ($vt_eventObject="ULO_Button_VIEW") | ($vt_eventObject="ULO_ButtonBG_VIEW")
		
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_VIEW_POP 
		End case 
		
	: ($vt_eventObject="ULO_Button_PRINT") | ($vt_eventObject="ULO_ButtonBG_PRINT")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_PRINT_POP 
		End case 
		
	: ($vt_eventObject="ULO_Button_RELATE") | ($vt_eventObject="ULO_ButtonBG_RELATE")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_RELATE_POP 
		End case 
		
	: ($vt_eventObject="ULO_Button_SETS") | ($vt_eventObject="ULO_ButtonBG_SETS")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_SET_POP 
		End case 
		
		
	: ($vt_eventObject="ULO_Button_SHOWALL")
		  //Need to make callback to host for filter
		Case of 
			: ($vl_event=On Clicked:K2:4)
				$vl_table:=Form:C1466.tableNumber
				$es:=ds:C1482[Table name:C256(Form:C1466.tableNumber)].all()
				If (Storage:C1525.hostMethods.filter#"")
					EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es;Form:C1466.tableNumber;Form:C1466.navItem.handle;$es)
				End if 
				Form:C1466.uloRecords:=$es
				Form:C1466.refresh:=True:C214
				Form:C1466.footerRefresh:=True:C214
				SET TIMER:C645(-1)
		End case 
		
	: ($vt_eventObject="ULO_Button_SHOWSUBSET")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				Form:C1466.uloRecords:=Form:C1466.selectedRecords
				Form:C1466.refresh:=True:C214
				Form:C1466.footerRefresh:=True:C214
				SET TIMER:C645(-1)
		End case 
		
	: ($vt_eventObject="ULO_Button_OMITSUBSET")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				Form:C1466.uloRecords:=Form:C1466.uloRecords.minus(Form:C1466.selectedRecords)
				Form:C1466.refresh:=True:C214
				Form:C1466.footerRefresh:=True:C214
				SET TIMER:C645(-1)
		End case 
		
	: ($vt_eventObject="ULO_Button_SEARCH")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_SEARCH_POP 
				
				$es:=Form:C1466.uloRecords
				If (Storage:C1525.hostMethods.filter#"")
					EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es;Form:C1466.tableNumber;Form:C1466.navItem.handle;$es)
				End if 
				Form:C1466.uloRecords:=$es
				
				Form:C1466.refresh:=True:C214
				Form:C1466.footerRefresh:=True:C214
				SET TIMER:C645(-1)
				
		End case 
	: ($vt_eventObject="ULO_Button_SORT")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_SORT_POP 
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(-1)
		End case 
		
	: ($vt_eventObject="ULO_Button_@")
		If ($vl_event=On Clicked:K2:4)
			BUTTON_GENERIC_POP ($vt_eventObject)
		End if 
	: ($vt_eventObject="ULO_HostShortcut@")
		If ($vl_event=On Clicked:K2:4)
			$vt_case:=Replace string:C233($vt_eventObject;"ULO_HostShortcut";"")
			EXECUTE METHOD:C1007("ULO_Shortcut";*;$vt_case)
		End if 
	: ($vt_eventObject="ULO_Shortcut_@")
		If ($vl_event=On Clicked:K2:4)
			$vl_idx:=UTIL_Col_Find_Index (Form:C1466.shortcuts;"name";$vt_eventObject)
			If ($vl_idx>=0)
				If (Form:C1466.shortcuts[$vl_idx].function#"")
					EXECUTE METHOD:C1007(Form:C1466.shortcuts[$vl_idx].method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle;Form:C1466.shortcuts[$vl_idx].function)  //Return a collection
				End if 
			End if 
		End if 
	Else 
		Case of 
			: ($vl_event=On Clicked:K2:4)
				$vl_idx:=UTIL_Col_Find_Index (Form:C1466.buttons;"reference";$vt_eventObject)
				If ($vl_idx>=0)
					If (Form:C1466.buttons[$vl_idx].method#"")  //Temp fix
						EXECUTE METHOD:C1007(Form:C1466.buttons[$vl_idx].method;*;$1;Form:C1466.navItem;JSON Stringify:C1217(Form:C1466.buttons[$vl_buttonNumber]))
					End if 
				End if 
		End case 
		
End case 
