//%attributes = {}
  //Need to show popup for search button:
  //1 - Host search option/s
  //2 - Generic query from ULO
  //3 - Break line
  //4 - Sub menu for loading saved searches
  //5 - Sub menu for deleting saved searches


  //Manages all fo the popup actions for the search button
C_TEXT:C284($1;$vt_menu;$vt_selected)
C_LONGINT:C283($vl_CurrentUser;$cp;$vl_menuNum)
C_OBJECT:C1216($vo_view;$vo_option;$vo_coord)
C_COLLECTION:C1488($vc_hostOptions)
C_POINTER:C301($vp_table)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259

Case of 
	: ($cp=0)
		$vt_menu:=Create menu:C408
		
		  //first make call to host to get any options.
		If (Storage:C1525.hostMethods.search#"")  //If there is a host search method specified
			EXECUTE METHOD:C1007(Storage:C1525.hostMethods.search;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle)
			  //Return a collection
		End if 
		
		For each ($vo_option;$vc_hostOptions)
			$vl_menuNum:=-1
			If (OB Is defined:C1231($vo_option;"number"))
				$vl_menuNum:=$vo_option.number
			End if 
			APPEND MENU ITEM:C411($vt_menu;$vo_option.label)
			SET MENU ITEM PARAMETER:C1004($vt_menu;$vl_menuNum;$vo_option.function)
			If ($vo_option.enabled)
				ENABLE MENU ITEM:C149($vt_menu;$vl_menuNum)
			Else 
				DISABLE MENU ITEM:C150($vt_menu;$vl_menuNum)
			End if 
		End for each 
		
		
		  //If ($vc_options.length>0)
		APPEND MENU ITEM:C411($vt_menu;"-")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"-")
		  //End if 
		  //Now get the default options
		APPEND MENU ITEM:C411($vt_menu;"Quick Report")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"SEARCHEDITOR")
		
		  //Now build the saved searches for run and delete
		
		
		$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_SEARCH")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_SEARCH_POP ($vt_selected)
		End if 
		
	: ($1="QUERYEDITOR")
		Form:C1466.uloList:=ULO_Query (Form:C1466.tableNumber)
		
		
	: ($1="LOAD:@")
		  //get the name of the search to load and run it.
		
	: ($1="LOAD:@")
		  //get the name of the search selected and delete it.
		
	Else   //Otherwise call the host search option
		
		EXECUTE METHOD:C1007(Storage:C1525.hostMethods.search;*;Form:C1466.tableNumber;Form:C1466.navItem.handle;$1)
		
End case 


