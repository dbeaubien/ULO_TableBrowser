//%attributes = {"invisible":true}
  //Need to show popup for search button:
  //1 - Host search option/s
  //2 - Generic query from ULO
  //3 - Break line
  //4 - Sub menu for loading saved searches
  //5 - Sub menu for deleting saved searches


  //Manages all fo the popup actions for the search button
C_TEXT:C284($1;$vt_menu;$vt_selected;$vt_systemMenu;$vt_userMenu;$vt_id)
C_LONGINT:C283($cp;$vl_menuNum;$index)
C_OBJECT:C1216($vo_coord;$e_sort;$e_systemSort;$e_userSort;\
$es_systemSort;$es_userSort)
C_COLLECTION:C1488($vc_hostOptions)
C_POINTER:C301($vp_table)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259

Case of 
	: ($cp=0)
		$vt_menu:=Create menu:C408
		
		APPEND MENU ITEM:C411($vt_menu;"No Sort")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"LOAD:")
		  //If (Form.navItem.selectedSort=Null)
		  //SET MENU ITEM MARK($vt_systemMenu;-1;Char(18))
		  //Else 
		  //If (Form.navItem.selectedSort.id="")
		  //SET MENU ITEM MARK($vt_systemMenu;-1;Char(18))
		  //End if 
		  //End if 
		
		$es_systemSort:=ds:C1482["uloData"].query("user == 0 && type == 13 && table == :1";Form:C1466.tableNumber)
		
		$vt_systemMenu:=Create menu:C408
		For each ($e_systemSort;$es_systemSort)
			APPEND MENU ITEM:C411($vt_systemMenu;$e_systemSort.name)
			SET MENU ITEM PARAMETER:C1004($vt_systemMenu;-1;"LOAD:"+$e_systemSort.id)
			  //If (Form.navItem.selectedSort#Null)
			  //If ($e_systemSort.id=Form.navItem.selectedSort.id)
			  //SET MENU ITEM MARK($vt_systemMenu;-1;Char(18))
			  //End if 
			  //End if 
		End for each 
		APPEND MENU ITEM:C411($vt_menu;"System Sorts";$vt_systemMenu)
		If ($es_systemSort.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		
		$es_userSort:=ds:C1482["uloData"].query("user == :1 && type == 13 && table == :2";Storage:C1525.user.id;Form:C1466.tableNumber)
		
		$vt_userMenu:=Create menu:C408
		For each ($e_userSort;$es_userSort)
			APPEND MENU ITEM:C411($vt_userMenu;$e_userSort.name)
			SET MENU ITEM PARAMETER:C1004($vt_userMenu;-1;"LOAD:"+$e_userSort.id)
			  //If ($e_userSort.id=Form.navItem.selectedSort.id)
			  //SET MENU ITEM MARK($vt_userMenu;-1;Char(18))
			  //End if 
		End for each 
		APPEND MENU ITEM:C411($vt_menu;"My Sorts";$vt_userMenu)
		If ($es_userSort.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		
		APPEND MENU ITEM:C411($vt_menu;"-")
		DISABLE MENU ITEM:C150($vt_menu;-1)
		
		  //Opportunity to add userPreferences that dictates the behaviour of sorting?
		
		  //If (Storage.userPrefs.persistentSorting)
		If (False:C215)
			APPEND MENU ITEM:C411($vt_menu;"New Sort")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"NEW")
			
			APPEND MENU ITEM:C411($vt_menu;"Amend Current Sort")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"EDIT")
			If (Form:C1466.navItem.selectedSort#Null:C1517)
				If (Storage:C1525.user.id#Form:C1466.navItem.selectedSort.user)
					DISABLE MENU ITEM:C150($vt_menu;-1)
				End if 
			Else 
				DISABLE MENU ITEM:C150($vt_menu;-1)
			End if 
			
			APPEND MENU ITEM:C411($vt_menu;"Duplicate Current Sort")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"DUPE")
			If (Form:C1466.navItem.selectedSort=Null:C1517)
				DISABLE MENU ITEM:C150($vt_menu;-1)
			End if 
			
		Else 
			APPEND MENU ITEM:C411($vt_menu;"Manage Sorts")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"MANAGE")
		End if 
		
		$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_SORT")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_SORT_POP ($vt_selected)
		End if 
		
	: ($1="MANAGE")
		SORT_MANAGE 
		
	: ($1="LOAD:@")
		  //get the name of the sort to load and run it.
		$vt_id:=Replace string:C233($1;"LOAD:";"")
		If ($vt_id="")
			Form:C1466.navItem.selectedSort:=Null:C1517
		Else 
			$e_sort:=ds:C1482["uloData"].get($vt_id)
			Form:C1466.navItem.selectedSort:=$e_sort.toObject()
		End if 
		ULO_LOAD_SORT 
		
End case 


