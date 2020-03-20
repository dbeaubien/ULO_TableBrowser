//%attributes = {"invisible":true}
  //Manages all fo the popup actions for theview button
C_TEXT:C284($1;$vt_menu;$vt_selected;$vt_shortcut)
C_LONGINT:C283($cp;$vl_menuNum;$index;$vl_modifier)
C_POINTER:C301($vp_table)
C_OBJECT:C1216($vo_option;$vo_coord)
C_COLLECTION:C1488($vc_hostOptions)
$vp_table:=Table:C252(Form:C1466.tableNumber)
$cp:=Count parameters:C259
$vc_hostOptions:=New collection:C1472

Case of 
	: ($cp=0)
		$vt_menu:=Create menu:C408
		
		  //first make call to host to get any options.
		$index:=UTIL_Col_Find_Index (Storage:C1525.buttons;"action";"PRINT")
		If ($index>=0)
			If (Storage:C1525.buttons[$index].method#"")  //If there is a host search method specified
				EXECUTE METHOD:C1007(Storage:C1525.buttons[$index].method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //Return a collection
			End if 
		End if 
		
		If ($vc_hostOptions.length>0)
			$vt_menu:=UTIL_Parse_Host_Menu_Options ($vt_menu;$vc_hostOptions)
			APPEND MENU ITEM:C411($vt_menu;"-")
			SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"-")
		End if 
		  //Now get the default options
		  //Now get the default options
		APPEND MENU ITEM:C411($vt_menu;"Export View")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"EXPORTVIEW")
		SET MENU ITEM SHORTCUT:C423($vt_menu;-1;"E";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($vt_menu;"Quick Report")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"QUICKREPORT")
		
		
		  //Now get the default options
		APPEND MENU ITEM:C411($vt_menu;"Quick Label")
		SET MENU ITEM PARAMETER:C1004($vt_menu;-1;"PRINTLABEL")
		
		
		$vo_coord:=ULO_Get_Popup_Coord ("ULO_Button_PRINT")
		
		$vt_selected:=Dynamic pop up menu:C1006($vt_menu;"";$vo_coord.x;$vo_coord.y)
		If ($vt_selected#"")
			BUTTON_PRINT_POP ($vt_selected)
		End if 
		
	: ($1="EXPORTVIEW")
		C_OBJECT:C1216($vo_eventObject)
		$vo_eventObject:=New object:C1471
		$vo_eventObject.code:=-999
		$vo_eventObject.objectName:="ULO_ExportView"
		ULO_BROWSER_EVENT ($vo_eventObject)
		
	: ($1="QUICKREPORT")
		USE ENTITY SELECTION:C1513(Form:C1466.uloRecords)
		QR REPORT:C197($vp_table->;Char:C90(1))
		
	: ($1="PRINTLABEL")
		USE ENTITY SELECTION:C1513(Form:C1466.uloRecords)
		PRINT LABEL:C39($vp_table->;Char:C90(1))
		
	Else 
		  //Must be a host option so call the host method
		$index:=UTIL_Col_Find_Index (Storage:C1525.buttons;"action";"PRINT")
		If ($index>=0)
			If (Storage:C1525.buttons[$index].method#"")  //If there is a host search method specified
				EXECUTE METHOD:C1007(Storage:C1525.buttons[$index].method;$vc_hostOptions;Form:C1466.tableNumber;Form:C1466.navItem.handle;$1)  //Return a collection
			End if 
		End if 
		
		
		
End case 


