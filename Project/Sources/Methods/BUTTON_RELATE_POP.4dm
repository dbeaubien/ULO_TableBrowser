//%attributes = {"invisible":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 23/01/20, 16:41:31
  // ----------------------------------------------------
  // Method: BUTTON_RELATE_POP
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_menu;$vt_selected;$vt_hostMethod)
C_LONGINT:C283($vl_CurrentUser;$cp;$vl_menuNum;$index;$vl_count;$vl_idx)
C_OBJECT:C1216($vo_view;$vo_option;$vo_coord;$vo_field;$vo_param;$vo_col)
C_COLLECTION:C1488($vc_hostOptions;$vc_fields;$vc_menuItems)
C_POINTER:C301($vp_table)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259
$vc_hostOptions:=New collection:C1472

  //first make call to host to get any host options.
$index:=UTIL_Col_Find_Index (Storage:C1525.buttons;"action";"RELATE")
If ($index>=0)
	If (Storage:C1525.buttons[$index].method#"")  //If there is a host search method specified
		$vt_hostMethod:=Storage:C1525.buttons[$index].method
	End if 
End if 

If ($cp=0)
	$vt_menu:=Create menu:C408
	
	If ($vt_hostMethod#"")
		EXECUTE METHOD:C1007($vt_hostMethod;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //Return a collection
	End if 
	
	If ($vc_hostOptions.length>0)
		$vt_menu:=UTIL_Parse_Host_Menu_Options ($vt_menu;$vc_hostOptions)
	End if 
	
	
	$vc_menuItems:=New collection:C1472
	$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_RELATE")
	
	$vc_fields:=ULO_Get_Table_Fields (Table name:C256(Form:C1466.tableNumber))  //TODO: Validate the view is accessible by navBar / user permissions
	For each ($vo_field;$vc_fields)
		If ($vo_field.kind="relatedEntit@")
			$vl_count:=Form:C1466.uloRecords[$vo_field.fieldName].length
			
			$vl_idx:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"handle";$vo_field.relatedDataClass)  //TODO: Needs changing
			If ($vl_idx>=0)
				$vc_menuItems.push(New object:C1471("relation";$vo_field.fieldName;"table";Form:C1466.sidebarSource[$vl_idx].table;"count";$vl_count;"fieldName";$vo_field.relatedDataClass))
			Else 
				  //Can't find nav item for this table number
			End if 
		End if 
	End for each 
	
	If ($vc_menuItems.length>0)
		If ($vc_hostOptions.length>0)  //If we had host items put a break line between them and automatic items.
			APPEND MENU ITEM:C411($vt_menu;"-")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"-")
		End if 
		
		For each ($vo_col;$vc_menuItems)
			$vo_col.action:="same"
			APPEND MENU ITEM:C411($vt_menu;$vo_col.fieldName+" ["+String:C10($vo_col.count)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;JSON Stringify:C1217($vo_col))
		End for each 
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_RELATE_POP ($vt_selected)
		End if 
	Else 
		If ($vc_hostOptions.length=0)
			APPEND MENU ITEM:C411($vt_menu;"None Available")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"")
			DISABLE MENU ITEM:C150($vt_menu;-1)
			$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
		End if 
	End if 
Else 
	  //swap selected table!
	$vo_param:=JSON Parse:C1218($1)
	Case of 
		: ($vo_param.action="new")
			C_OBJECT:C1216($vo_winData)
			$vo_winData:=New object:C1471
			$vo_winData.wLeft:=10
			$vo_winData.wTop:=120
			$vo_winData.wRight:=1510
			$vo_winData.wBottom:=650
			$vo_winData.wType:=Plain window:K34:13
			$vo_winData.wTitle:="My Browser"
			$vo_winData.sidebarStart:=$vo_param.fieldName
			
			ULO_MAIN ($vo_param.table;$vo_winData;Form:C1466.uloRecords[$vo_param.relation])
			
		: ($vo_param.action="same") | ($vo_param.action="sameHost")
			
			If ($vo_param.action="sameHost") & ($vt_hostMethod#"")  //If host we will have already set the selection
				EXECUTE METHOD:C1007($vt_hostMethod;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle;$vo_param.relation)  //Return a collection
			Else 
				Form:C1466.uloRecords:=Form:C1466.uloRecords[$vo_param.relation]
			End if 
			Form:C1466.tableNumber:=$vo_param.table
			
			$index:=UTIL_Col_Find_Index (Form:C1466.sidebarSource;"table";$vo_param.table;"type";"DATA")
			
			  //If desired sidebar item is child, ensure parent(s) are expanded
			If (OB Is defined:C1231(Form:C1466.sidebarSource[$index];"childOfIndex"))
				Form:C1466.sidebarSource[Form:C1466.sidebarSource[$index].childOfIndex].expanded:=True:C214
				If (OB Is defined:C1231(Form:C1466.sidebarSource[Form:C1466.sidebarSource[$index].childOfIndex];"childOfIndex"))
					Form:C1466.sidebarSource[Form:C1466.sidebarSource[Form:C1466.sidebarSource[$index].childOfIndex].childOfIndex].expanded:=True:C214
				End if 
				  //Else is top level item and always visible!
			End if 
			
			
			SIDEBAR_REBUILD 
			$vl_idx:=UTIL_Col_Find_Index (Form:C1466.navItems;"index";Form:C1466.sidebarSource[$index].index)
			If ($vl_idx>=0)
				Form:C1466.fullRefresh:=True:C214
				Form:C1466.lastNavItemIndex:=($vl_idx+1)
				LISTBOX SELECT ROW:C912(*;"ULO_Navbar";$vl_idx+1;lk replace selection:K53:1)
				Form:C1466.relate:=True:C214
				SET TIMER:C645(-1)
			Else 
				  //Can't find nav item with selected relation table number
			End if 
			
	End case 
	
End if 