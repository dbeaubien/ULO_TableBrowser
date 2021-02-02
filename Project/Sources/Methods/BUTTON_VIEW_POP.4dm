//%attributes = {"invisible":true}
  //Manages all fo the popup actions for theview button
C_TEXT:C284($1)
C_TEXT:C284($vt_id;$vt_MyViews;$vt_Option;$vt_ViewMenu;$vt_defaultViewId;$vt_userDefaultId;$vt_selected)
C_LONGINT:C283($vl_CurrentUser;$vl_NumParameters)
C_OBJECT:C1216($vo_view;$e_view;$es_views;$vo_coord)
C_COLLECTION:C1488($vc_views)
C_BOOLEAN:C305($vb_disable)

$vl_NumParameters:=Count parameters:C259

Case of 
	: ($vl_NumParameters=0)
		$vt_ViewMenu:=Create menu:C408
		
		  //separate menu options for user/system default
		  //Look for system default
		$es_views:=ds:C1482["uloData"].query("table == :1 && handle == :2 && default == True && user == 0 && type == 2";Form:C1466.tableNumber;Form:C1466.navItem.handle)
		If ($es_views.length>0)
			$vt_defaultViewId:=$es_views.first().id
		Else 
			  //No system default found, need to generate one from json data
			$vt_defaultViewId:="XXXX"
		End if 
		
		APPEND MENU ITEM:C411($vt_ViewMenu;"System Default View")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"LOAD:"+$vt_defaultViewId)
		If ($vt_defaultViewId=Form:C1466.navItem.selectedView.id)
			SET MENU ITEM MARK:C208($vt_ViewMenu;-1;Char:C90(18))
		End if 
		
		  //Look for user default
		$es_views:=ds:C1482["uloData"].query("table == :1 && default == :2 && user == :3 && handle == :4 && type == 2";Form:C1466.tableNumber;True:C214;Storage:C1525.user.id;Form:C1466.navItem.handle)
		If ($es_views.length>0)
			$vt_userDefaultId:=$es_views.first().id
		End if 
		
		APPEND MENU ITEM:C411($vt_ViewMenu;"Your Default View")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"LOAD:"+$vt_userDefaultId)
		If ($vt_userDefaultId="")
			DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
		End if 
		If ($vt_userDefaultId=Form:C1466.navItem.selectedView.id)
			SET MENU ITEM MARK:C208($vt_ViewMenu;-1;Char:C90(18))
		End if 
		
		
		  //Now add a submenu of my personal Views
		$vl_CurrentUser:=Storage:C1525.user.id
		If ($vl_CurrentUser>0)
			
			$vc_views:=ds:C1482["uloData"].query("user == :1 && table == :2 && type == 2";\
				$vl_CurrentUser;Form:C1466.tableNumber).orderBy("name").toCollection("id,name,user,detail")
		End if 
		
		If ($vc_views.length>0)
			$vt_MyViews:=Create menu:C408
			$vb_disable:=True:C214
			For each ($vo_view;$vc_views)
				If (($vo_view.id#$vt_defaultViewId) & ($vo_view.id#$vt_userDefaultId))
					$vb_disable:=False:C215
					APPEND MENU ITEM:C411($vt_MyViews;$vo_view.name)
					SET MENU ITEM PARAMETER:C1004($vt_MyViews;-1;"VIEW:LOAD:"+$vo_view.id)
					If ($vo_view.id=Form:C1466.navItem.selectedView.id)
						SET MENU ITEM MARK:C208($vt_MyViews;-1;Char:C90(18))
					End if 
				End if 
			End for each 
			APPEND MENU ITEM:C411($vt_ViewMenu;"My Views";$vt_MyViews)
			If ($vb_disable)
				DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
			End if 
			RELEASE MENU:C978($vt_MyViews)
		Else 
			APPEND MENU ITEM:C411($vt_ViewMenu;"My Views")
			DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
		End if 
		
		  //Now get other views I can use.
		$vc_views:=ds:C1482["uloData"].query("group != -1 && user != :1 && table == :2 && type == 2";\
			$vl_CurrentUser;Form:C1466.tableNumber).orderBy("name").toCollection("id,name,user,detail")
		If ($vc_views.length>0)
			$vt_MyViews:=Create menu:C408
			$vb_disable:=True:C214
			For each ($vo_view;$vc_views)
				If (($vo_view.id#$vt_defaultViewId) & ($vo_view.id#$vt_userDefaultId))
					$vb_disable:=False:C215
					APPEND MENU ITEM:C411($vt_MyViews;$vo_view.name)
					SET MENU ITEM PARAMETER:C1004($vt_MyViews;-1;"VIEW:LOAD:"+$vo_view.id)
					If ($vo_view.id=Form:C1466.navItem.selectedView.id)
						SET MENU ITEM MARK:C208($vt_MyViews;-1;Char:C90(18))
					End if 
				End if 
			End for each 
			APPEND MENU ITEM:C411($vt_ViewMenu;"Other Views";$vt_MyViews)
			If ($vb_disable)
				DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
			End if 
			RELEASE MENU:C978($vt_MyViews)
		Else 
			APPEND MENU ITEM:C411($vt_ViewMenu;"Other Views")
			DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
		End if 
		
		  //Break
		APPEND MENU ITEM:C411($vt_ViewMenu;"-")
		DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
		
		  //New view
		APPEND MENU ITEM:C411($vt_ViewMenu;"New View")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"VIEW:New")
		
		  //Amend current view
		APPEND MENU ITEM:C411($vt_ViewMenu;"Amend Current View")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"VIEW:Amend")
		If (($vl_CurrentUser#Form:C1466.navItem.selectedView.user) | (Form:C1466.navItem.selectedView.handle#Form:C1466.navItem.handle)) & ($vl_CurrentUser#-1)  //can only amend views that belong to you unless designer
			DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
		End if 
		
		  //Dupe current view
		APPEND MENU ITEM:C411($vt_ViewMenu;"Duplicate Current View")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"DUPE")
		
		  //Break
		APPEND MENU ITEM:C411($vt_ViewMenu;"-")
		DISABLE MENU ITEM:C150($vt_ViewMenu;-1)
		
		  //General view options - Style and font size.
		APPEND MENU ITEM:C411($vt_ViewMenu;"Amend Theme")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"VIEW:Options")
		
		
		$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_VIEW")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_ViewMenu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_VIEW_POP ($vt_selected)
		End if 
		
	: ($1="VIEW:@") | ($1="DEFAULT VIEW:@")
		$vt_Option:=Replace string:C233(Replace string:C233($1;"DEFAULT VIEW:";"");"VIEW:";"")
		BUTTON_VIEW_POP ($vt_Option)
		
		  //Set default view
		
		  //vb_View_Loaded_Is_Default:=($1="DEFAULT VIEW:@")
		
	: ($1="New")  //New view
		VIEW_EDIT ("New")
		
	: ($1="Amend")  //Amend current view
		VIEW_EDIT ("Edit")
		
	: ($1="Options")  //General view options - Style and font size.
		ULO_EDIT_THEME 
		
	: ($1="LOAD@")  //load a passed view
		$vt_id:=Replace string:C233($1;"LOAD:";"")
		$e_view:=ds:C1482["uloData"].get($vt_id)
		If ($e_view#Null:C1517)
			Form:C1466.navItem.selectedView:=$e_view.toObject()
		Else 
			Form:C1466.navItem.selectedView:=New object:C1471("createNew";True:C214)
		End if 
		ULO_LOAD_VIEW 
		
	: ($1="DUPE")
		
		VIEW_EDIT ("Dupe")
		
		
End case 


