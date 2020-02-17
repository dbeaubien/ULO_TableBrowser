//%attributes = {"shared":true}
C_OBJECT:C1216($1;$vo_sub;$es;$es_return;$vo_sort)
C_TEXT:C284($vt_eventObject;$vt_value;$vt_method)
C_LONGINT:C283($vl_event;$vl_table;$vl_selected;$index;\
$vl_buttonNumber;$vl_idx;$vl_field;$vl_fieldIdx;\
$vl_sortIdx)
C_COLLECTION:C1488($vc_fields)

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
				Form:C1466.resize:=False:C215
				Form:C1466.pendingResize:=False:C215
				Form:C1466.refresh:=True:C214
				Form:C1466.fullRefresh:=False:C215
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
				
				ULO_SET_BACKGROUND 
				
				ULO_LOAD_THEME 
				ULO_LOAD_BUTTONS (Form:C1466.buttons)
				SIDEBAR_REBUILD 
				
				  //Find in Form.navItems
				$index:=UTIL_Col_Find_Index (Form:C1466.navItems;"handle";Form:C1466.sidebarStart)
				If ($index=-1)
					$index:=1
				End if 
				
				LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$index+1;lk replace selection:K53:1)
				Form:C1466.lastNavItemIndex:=$index+1
				ULO_LOAD_VIEW   //This is also calling ULO_LIST_UPDATE_FOOTER if a default view exists
				SET TIMER:C645(1)
				SIDEBAR_REBUILD 
				
			: ($vl_event=On Timer:K2:25)
				Case of 
					: (Form:C1466.fullRefresh)
						Form:C1466.fullRefresh:=False:C215
						Form:C1466.navItem.selection:=Form:C1466.uloList  //OB Copy(Form.uloList)//This was returning a null
						ULO_LOAD_VIEW 
						SET TIMER:C645(0)
						$vl_selected:=Form:C1466.records.length
						OBJECT SET ENABLED:C1123(*;"ULO_Button_SHOWSUBSET";($vl_selected>0))
						OBJECT SET ENABLED:C1123(*;"ULO_Button_OMITSUBSET";($vl_selected>0))
						
						
					: (Form:C1466.refresh)
						Form:C1466.refresh:=False:C215
						SET TIMER:C645(0)
						$vl_selected:=Form:C1466.records.length
						OBJECT SET ENABLED:C1123(*;"ULO_Button_SHOWSUBSET";($vl_selected>0))
						OBJECT SET ENABLED:C1123(*;"ULO_Button_OMITSUBSET";($vl_selected>0))
						ULO_LIST_UPDATE_FOOTER   //We're calling this twice on startup if a default view exists, but it needs to be called here
						ULO_SELECTION_MESSAGE 
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
				
				SIDEBAR_DBL_CLICK 
				
				If (Form:C1466.navItem.type="header")
					LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
				End if 
				
				
				
			: ($vl_event=On Selection Change:K2:29)  // | ($vl_event=On Clicked)
				If (Form:C1466.navItem#Null:C1517)
					Case of 
						: (Form:C1466.navItem.type="HEADER")
							LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
							
						: (Form:C1466.navItem.type="DATA")
							Form:C1466.tableNumber:=Form:C1466.navItem.table
							ULO_LOAD_VIEW 
							
						: (Form:C1466.navItem.type="WEB")
							ULO_LOAD_WEB_AREA 
							
					End case 
				Else 
					LISTBOX SELECT ROW:C912(*;"ULO_Navbar";Form:C1466.lastNavItemIndex;lk replace selection:K53:1)
				End if 
				ULO_SELECTION_MESSAGE 
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
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
				
			: ($vl_event=On Clicked:K2:4) & (Right click:C712)
				If (OB Is defined:C1231(Form:C1466.navItem;"rowContext"))
					$vt_method:=Form:C1466.navItem.rowContext
					If (Form:C1466.record#Null:C1517)
						EXECUTE METHOD:C1007($vt_method;*;"context test: "+JSON Stringify:C1217(Form:C1466.record.toObject()))
					End if 
				End if 
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
				
			: ($vl_event=On Clicked:K2:4)
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
				
			: ($vl_event=On Column Resize:K2:31)
				  //Resize event is fired for every pixel that the column is changed by
				  //Therefore Case in On Timer event handles the saving of new widths
				  //after the user has finished resizing
				Form:C1466.resizing:=True:C214
				SET TIMER:C645(1)
				
			: ($vl_event=On Header Click:K2:40)
				
				C_LONGINT:C283($vl_col;$vl_row)
				
				ARRAY TEXT:C222($at_colName;0)
				ARRAY TEXT:C222($at_headerName;0)
				ARRAY POINTER:C280($ap_style;0)
				ARRAY POINTER:C280($ap_colVar;0)
				ARRAY POINTER:C280($ap_headerVar;0)
				ARRAY BOOLEAN:C223($ab_colVisible;0)
				
				LISTBOX GET CELL POSITION:C971(*;"ULO_LIST";$vl_col;$vl_row)
				
				LISTBOX GET ARRAYS:C832(*;"ULO_LIST";$at_colName;$at_headerName;$ap_colVar;$ap_headerVar;\
					$ab_colVisible;$ap_style)
				
				TRACE:C157
				
				$vt_header:=$at_headerName{$vl_col}
				
				$vt_temp:=Replace string:C233($vt_header;"head_";"")
				$vt_temp:=Replace string:C233($vt_temp;"h_";"")
				$vl_pos:=Position:C15("_";$vt_temp)
				If ($vl_pos>0)
					$vl_table:=Num:C11(Substring:C12($vt_temp;1;$vl_pos-1))
					$vl_field:=Num:C11(Substring:C12($vt_temp;$vl_pos+1))
					
					If ($vl_field>0)  //negatives are custom fields
						$vc_fields:=ULO_Get_Table_Fields (Table name:C256($vl_table))
						$vl_fieldIdx:=UTIL_Col_Find_Index ($vc_fields;"fieldNumber";$vl_field)
						If ($vl_fieldIdx>=0)
							If (Form:C1466.navItem.selectedSort=Null:C1517)
								Form:C1466.navItem.selectedSort:=New object:C1471
								Form:C1466.navItem.selectedSort.detail:=New object:C1471
								Form:C1466.navItem.selectedSort.id:=""
								Form:C1466.navItem.selectedSort.type:=13
								Form:C1466.navItem.selectedSort.handle:=Form:C1466.navItem.handle
								Form:C1466.navItem.selectedSort.user:=Storage:C1525.user.id
								Form:C1466.navItem.selectedSort.table:=Form:C1466.tableNumber
								Form:C1466.navItem.selectedSort.name:="New Sort #"+String:C10(ds:C1482["uloData"]\
									.query("type == 13 && user == :1 && table == :2";Storage:C1525.user.id;Form:C1466.tableNumber).length+1)
								Form:C1466.navItem.selectedSort.group:=1  //TODO: Group?
								Form:C1466.navItem.selectedSort.detail.public:=False:C215
								Form:C1466.navItem.selectedSort.detail.sortData:=New collection:C1472
							End if 
							
							$vl_sortIdx:=UTIL_Col_Find_Index (Form:C1466.navItem.selectedSort.detail.sortData;"field";$vl_field;"table";$vl_table)
							If ($vl_sortIdx>=0)
								If (Form:C1466.navItem.selectedSort.detail.sortData[$vl_sortIdx].sortDir="ASC")
									Form:C1466.navItem.selectedSort.detail.sortData[$vl_sortIdx].sortDir:="DES"
								Else 
									Form:C1466.navItem.selectedSort.detail.sortData.remove($vl_sortIdx)
								End if 
								
								
							Else 
								$vo_sort:=New object:C1471
								$vo_sort.table:=$vl_table
								$vo_sort.field:=$vl_field
								$vo_sort.fieldName:=$vc_fields[$vl_fieldIdx].fieldName
								$vo_sort.formula:=""
								$vo_sort.relation:=""
								
								If (OB Is defined:C1231($vc_fields[$vl_fieldIdx];"relation"))
									$vo_sort.relation:=$vc_fields[$vl_fieldIdx].relation
									If ($vo_sort.relation#"")
										$vo_sort.formula:=$vo_sort.relation+"."+$vc_fields[$vl_fieldIdx].fieldName
									End if 
								End if 
								
								If ($vo_sort.formula="")
									$vo_sort.formula:=$vc_fields[$vl_fieldIdx].fieldName
								End if 
								
								$vo_sort.sortDir:="ASC"
								
								Form:C1466.navItem.selectedSort.detail.sortData.push(OB Copy:C1225($vo_sort))
								
							End if 
							ULO_LOAD_SORT 
						End if   // fieldIdx check
					End if   // (not a) formula check
				End if 
		End case 
		
	: ($vt_eventObject="SearchPop@")
		
	: ($vt_eventObject="SearchText_@")  //Text field from the find widget
		Case of 
			: ($vl_event=On Selection Change:K2:29)
				$vt_value:=OBJECT Get pointer:C1124(Object named:K67:5;"ULO_DEFAULT_FIND")->  //Get the value from the find object
				$es_return:=Form:C1466.uloList
				$index:=UTIL_Col_Find_Index (Storage:C1525.buttons;"action";"FIND")
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
		
		
	: ($vt_eventObject="ULO_Button_SHOWALL")
		  //Need to make callback to host for filter
		Case of 
			: ($vl_event=On Clicked:K2:4)
				$vl_table:=Form:C1466.tableNumber
				$es:=ds:C1482[Table name:C256(Form:C1466.tableNumber)].all()
				If (Storage:C1525.hostMethods.filter#"")
					EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es;Form:C1466.tableNumber;Form:C1466.navItem.handle;$es)
				End if 
				Form:C1466.uloList:=$es
				Form:C1466.refresh:=True:C214
				SET TIMER:C645(1)
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
	: ($vt_eventObject="ULO_Button_SORT")
		Case of 
			: ($vl_event=On Clicked:K2:4)
				BUTTON_SORT_POP 
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
