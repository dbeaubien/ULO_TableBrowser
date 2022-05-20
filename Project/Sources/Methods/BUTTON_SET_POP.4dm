//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 20/02/20, 14:39:24
  // ----------------------------------------------------
  // Method: BUTTON_SET_POP
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1)

C_TEXT:C284($vt_addMenu;$vt_case;$vt_deleteMenu;$vt_id;$vt_menu;\
$vt_newMenu;$vt_pk;$vt_removeMenu;$vt_table;$vt_userMenu;$vt_pubMenu;$vt_selected;$vt_name)
C_OBJECT:C1216($es_resultRecords;$es_setRecords;$es_sets;$e_set;$vo_coord;$vo_saveForm)
C_LONGINT:C283($vl_NumParameters;$vl_wind)

$vl_NumParameters:=Count parameters:C259


Case of 
	: ($vl_NumParameters=0)
		$vt_menu:=Create menu:C408
		
		  // ~~~~~ System Sets ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		$es_sets:=ds:C1482["uloData"].query("table == :1 && type == 1 && user # :2 && detail.public = :3";\
			Form:C1466.tableNumber;Storage:C1525.user.id;True:C214)
		$vt_pubMenu:=Create menu:C408
		For each ($e_set;$es_sets)
			APPEND MENU ITEM:C411($vt_pubMenu;$e_set.name+" ["+String:C10($e_set.detail.recordIds.length)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_pubMenu;-1;"LOAD:"+$e_set.id)
		End for each 
		
		APPEND MENU ITEM:C411($vt_menu;"Public Sets";$vt_pubMenu)
		If ($es_sets.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		RELEASE MENU:C978($vt_pubMenu)
		
		  // ~~~~~ User Sets ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		$es_sets:=ds:C1482["uloData"].query("table == :1 && user == :2 && type == 1";Form:C1466.tableNumber;Storage:C1525.user.id)
		$vt_userMenu:=Create menu:C408
		For each ($e_set;$es_sets)
			APPEND MENU ITEM:C411($vt_userMenu;$e_set.name+" ["+String:C10($e_set.detail.recordIds.length)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_userMenu;-1;"LOAD:"+$e_set.id)
		End for each 
		
		APPEND MENU ITEM:C411($vt_menu;"My Sets";$vt_userMenu)
		If ($es_sets.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		RELEASE MENU:C978($vt_userMenu)
		
		APPEND MENU ITEM:C411($vt_menu;"-")
		DISABLE MENU ITEM:C150($vt_menu;-1)
		
		
		  // ~~~~~ New Options ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		$vt_newMenu:=Create menu:C408
		APPEND MENU ITEM:C411($vt_newMenu;"From Current Selection")
		SET MENU ITEM PARAMETER:C1004($vt_newMenu;-1;"NEW:SELECTION")
		If (Form:C1466.uloRecords.length=0)
			DISABLE MENU ITEM:C150($vt_newMenu;-1)
		End if 
		
		APPEND MENU ITEM:C411($vt_newMenu;"Empty")
		SET MENU ITEM PARAMETER:C1004($vt_newMenu;-1;"NEW:EMPTY")
		
		APPEND MENU ITEM:C411($vt_menu;"Create New Set";$vt_newMenu)
		RELEASE MENU:C978($vt_newMenu)
		
		  // ~~~~~ Add to Set ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		$vt_addMenu:=Create menu:C408
		For each ($e_set;$es_sets)
			APPEND MENU ITEM:C411($vt_addMenu;$e_set.name+" ["+String:C10($e_set.detail.recordIds.length)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_addMenu;-1;"ADD:"+$e_set.id)
		End for each 
		
		APPEND MENU ITEM:C411($vt_menu;"Add Current Selection to Set";$vt_addMenu)
		If ($es_sets.length=0) | (Form:C1466.uloRecords.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		RELEASE MENU:C978($vt_addMenu)
		
		  // ~~~~~ Remove from Set ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		$vt_removeMenu:=Create menu:C408
		For each ($e_set;$es_sets)
			APPEND MENU ITEM:C411($vt_removeMenu;$e_set.name+" ["+String:C10($e_set.detail.recordIds.length)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_removeMenu;-1;"REMOVE:"+$e_set.id)
		End for each 
		
		APPEND MENU ITEM:C411($vt_menu;"Remove Current Selection from Set";$vt_removeMenu)
		If ($es_sets.length=0) | (Form:C1466.uloRecords.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		RELEASE MENU:C978($vt_removeMenu)
		
		APPEND MENU ITEM:C411($vt_menu;"-")
		DISABLE MENU ITEM:C150($vt_menu;-1)
		
		  // ~~~~~ Manage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		APPEND MENU ITEM:C411($vt_menu;"Manage Sets")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"MANAGE")
		If ($es_sets.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		
		APPEND MENU ITEM:C411($vt_menu;"-")
		DISABLE MENU ITEM:C150($vt_menu;-1)
		
		  // ~~~~~ Delete Set ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		$vt_deleteMenu:=Create menu:C408
		For each ($e_set;$es_sets)
			APPEND MENU ITEM:C411($vt_deleteMenu;$e_set.name+" ["+String:C10($e_set.detail.recordIds.length)+"]")
			SET MENU ITEM PARAMETER:C1004($vt_deleteMenu;-1;"DELETE:"+$e_set.id)
		End for each 
		
		APPEND MENU ITEM:C411($vt_menu;"Delete Set";$vt_deleteMenu)
		If ($es_sets.length=0)
			DISABLE MENU ITEM:C150($vt_menu;-1)
		End if 
		RELEASE MENU:C978($vt_deleteMenu)
		
		$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_SETS")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_SET_POP ($vt_selected)
		End if 
		
		RELEASE MENU:C978($vt_menu)
		
	: ($1="LOAD:@")
		$vt_id:=Replace string:C233($1;"LOAD:";"")
		$e_set:=ds:C1482["uloData"].get($vt_id)
		$vt_table:=Table name:C256($e_set.table)
		$vt_pk:=ds:C1482[$vt_table].getInfo().primaryKey
		Form:C1466.uloRecords:=ds:C1482[$vt_table].query($vt_pk+" in :1";$e_set.detail.recordIds)
		
	: ($1="NEW:@")
		$vt_case:=Replace string:C233($1;"NEW:";"")
		
		$e_set:=ds:C1482["uloData"].new()
		$e_set.detail:=New object:C1471
		$e_set.user:=Storage:C1525.user.id
		$e_set.table:=Form:C1466.tableNumber
		
		  //$vt_name:=Request("Please enter a name for your new Set")
		$vo_saveForm:=New object:C1471
		$vo_saveForm.name:="New Set - "+Form:C1466.tableName
		$vo_saveForm.public:=False:C215
		
		  //open save form
		$vl_wind:=Open form window:C675("ULO_Set_Save";Sheet form window:K39:12)
		SET WINDOW TITLE:C213("Set Save";$vl_wind)
		DIALOG:C40("ULO_Set_Save";$vo_saveForm)
		CLOSE WINDOW:C154($vl_wind)
		If (OK=1)
			$vt_name:=$vo_saveForm.name
		End if 
		
		If ($vt_name>"")
			If (ds:C1482["uloData"].query("table == :1 && user == :2 && type == 1 && name == :3";Form:C1466.tableNumber;Storage:C1525.user.id;$vt_name).length>0)
				ALERT:C41("You already have a Set with this name!")
			Else 
				$e_set.name:=$vt_name
				$e_set.type:=1
				$e_set.handle:=Form:C1466.navItem.handle
				$e_set.group:=1
				$e_set.detail.public:=$vo_saveForm.public
				$e_set.detail.recordIds:=New collection:C1472
				
				If ($vt_case="SELECTION")
					$vt_table:=Table name:C256($e_set.table)
					$vt_pk:=ds:C1482[$vt_table].getInfo().primaryKey
					If (Form:C1466.selectedRecords.length>0)
						$e_set.detail.recordIds:=Form:C1466.selectedRecords[$vt_pk]
					Else 
						$e_set.detail.recordIds:=Form:C1466.uloRecords[$vt_pk]
					End if 
				End if 
				
				$e_set.save()
			End if 
		Else 
			ALERT:C41("The set name cannot be blank!")
		End if 
		
	: ($1="ADD:@")
		$vt_id:=Replace string:C233($1;"ADD:";"")
		$e_set:=ds:C1482["uloData"].get($vt_id)
		$vt_table:=Table name:C256($e_set.table)
		
		$vt_pk:=ds:C1482[$vt_table].getInfo().primaryKey
		
		$es_setRecords:=ds:C1482[$vt_table].query($vt_pk+" in :1";$e_set.detail.recordIds)
		If (Form:C1466.selectedRecords.length>0)
			$es_resultRecords:=Form:C1466.selectedRecords.or($es_setRecords)
		Else 
			$es_resultRecords:=Form:C1466.uloRecords.or($es_setRecords)
		End if 
		$e_set.detail.recordIds:=$es_resultRecords[$vt_pk]
		$e_set.detail:=$e_set.detail
		$e_set.save()
		
	: ($1="REMOVE:@")
		$vt_id:=Replace string:C233($1;"REMOVE:";"")
		$e_set:=ds:C1482["uloData"].get($vt_id)
		
		$vt_table:=Table name:C256($e_set.table)
		
		$vt_pk:=ds:C1482[$vt_table].getInfo().primaryKey
		
		$es_setRecords:=ds:C1482[$vt_table].query($vt_pk+" in :1";$e_set.detail.recordIds)
		If (Form:C1466.selectedRecords.length>0)
			$es_resultRecords:=$es_setRecords.minus(Form:C1466.selectedRecords)
		Else 
			$es_resultRecords:=$es_setRecords.minus(Form:C1466.uloRecords)
		End if 
		$e_set.detail.recordIds:=$es_resultRecords[$vt_pk]
		$e_set.detail:=$e_set.detail
		$e_set.save()
		
	: ($1="DELETE:@")
		$vt_id:=Replace string:C233($1;"DELETE:";"")
		
		$e_set:=ds:C1482["uloData"].get($vt_id)
		CONFIRM:C162("Are you sure you wish to delete the Set "+$e_set.name+"?")
		If (OK=1)
			$e_set.drop()
		End if 
		
		
		
	: ($1="MANAGE")
		SET_MANAGE 
		
End case 


