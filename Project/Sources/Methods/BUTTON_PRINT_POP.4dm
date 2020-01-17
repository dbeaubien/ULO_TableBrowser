//%attributes = {}
  //Manages all fo the popup actions for theview button
C_TEXT:C284($1)
C_TEXT:C284($vt_MyViews;$vt_Option;$vt_ViewMenu;$vt_defaultViewId)
C_LONGINT:C283($vl_CurrentUser;$vl_Default;$vl_DefaultViewID;$vl_NumParameters)
C_OBJECT:C1216($vo_view)
C_COLLECTION:C1488($vc_views)
C_POINTER:C301($vp_table)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$vl_NumParameters:=Count parameters:C259

Case of 
	: ($vl_NumParameters=0)
		$vt_ViewMenu:=Create menu:C408
		
		  //first make call to host to get any options.
		
		
		  //If ($vc_options.length>0)
		APPEND MENU ITEM:C411($vt_ViewMenu;"-")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"-")
		  //End if 
		  //Now get the default options
		APPEND MENU ITEM:C411($vt_ViewMenu;"Quick Report")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"QUICKREPORT")
		
		
		  //Now get the default options
		APPEND MENU ITEM:C411($vt_ViewMenu;"Quick Label")
		SET MENU ITEM PARAMETER:C1004($vt_ViewMenu;-1;"PRINTLABEL")
		
		
		$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_PRINT")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_ViewMenu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_PRINT_POP ($vt_selected)
		End if 
		
	: ($1="QUICKREPORT")
		USE ENTITY SELECTION:C1513(Form:C1466.uloList)
		QR REPORT:C197($vp_table->;Char:C90(1))
		
	: ($1="PRINTLABEL")
		USE ENTITY SELECTION:C1513(Form:C1466.uloList)
		PRINT LABEL:C39($vp_table->;Char:C90(1))
		
	Else 
		
		
		
		
		
End case 


