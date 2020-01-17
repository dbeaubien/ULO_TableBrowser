//%attributes = {}
  //C_TEXT($1)
  //C_TEXT(vt_BROWSER_Button_Tip;$vt_ButtonName;$vt_Selected)
  //C_TEXT($vt_ULO_ActionRequested)
  //C_LONGINT($vl_ActionIndex;$vl_FormEvent;$vl_Find)
  //C_LONGINT($vl_NumParameters;$vl_PosAmend;$vl_PosDelete)
  //C_TEXT($vt_CurrentMethod)
  //C_BOOLEAN(vb_Query_Loaded)

  //$vl_FormEvent:=FORM Event.code
  //$vl_NumParameters:=Count parameters
  //$vt_CurrentMethod:=Current method name

  //  //INIT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //Case of 
  //: ($vl_NumParameters=0) & ($vl_FormEvent=On Menu Selected)
  //$vt_ULO_ActionRequested:=Get selected menu item parameter

  //: ($vl_NumParameters=0)
  //$vt_ButtonName:=OBJECT Get name(Object current)
  //vl_ULO_ButtonClicked:=Num($vt_ButtonName)
  //If (vl_ULO_ButtonClicked>0) & (vl_ULO_ButtonClicked<=Size of array(at_ULO_ListButtons_Action))
  //$vt_ULO_ActionRequested:=at_ULO_ListButtons_Action{vl_ULO_ButtonClicked}
  //End if 

  //Else 
  //$vt_ULO_ActionRequested:=$1

  //End case 

  //  //METHOD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  //Case of 
  //: ($vl_FormEvent=On Mouse Leave)
  //vt_BROWSER_Button_Tip:=""

  //: ($vl_FormEvent=On Mouse Enter)
  //If (<>vl_ULO_Button_Mode=2)
  //vt_BROWSER_Button_Tip:=at_ULO_ListButtons_Text{vl_ULO_ButtonClicked}+": "+at_ULO_ListButtons_TipText{vl_ULO_ButtonClicked}
  //Else 
  //vt_BROWSER_Button_Tip:=at_ULO_ListButtons_TipText{vl_ULO_ButtonClicked}
  //End if 

  //: ($vt_ULO_ActionRequested#"")

  //Case of 
  //: ($vt_ULO_ActionRequested=BROWSER Show All)
  //BRW_SHOW_ALL

  //: ($vt_ULO_ActionRequested=BROWSER Show Subset)
  //BRW_SHOW_SUBSET

  //: ($vt_ULO_ActionRequested=BROWSER Omit Subset)
  //BRW_OMIT_SUBSET

  //: ($vt_ULO_ActionRequested=BROWSER Query)  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
  //If (Not(vb_Query_Loaded))
  //vb_Query_Loaded:=True
  //BRW_QUERY_TABLE_START
  //End if 
  //BRW_QUERY_POPUP

  //: ($vt_ULO_ActionRequested=BROWSER Order By)
  //BRW_SORT_POPUP

  //: ($vt_ULO_ActionRequested=BROWSER Action)
  //BRW_TABLE_ACTIONS

  //: ($vt_ULO_ActionRequested=BROWSER New Record)
  //BRW_NEW_RECORD

  //: ($vt_ULO_ActionRequested=BROWSER Delete Record)
  //BRW_DELETE_RECORD

  //: ($vt_ULO_ActionRequested=BROWSER Modify Record)
  //BRW_MODIFY_RECORD

  //: ($vt_ULO_ActionRequested=BROWSER Views)
  //If (Not(vb_View_Loaded))
  //vb_View_Loaded:=True
  //If (vt_Views_Menu#"")
  //RELEASE MENU(vt_Views_Menu)
  //End if 
  //vt_Views_Menu:=BRW_VIEW_POPUP
  //End if 

  //OBJECT GET COORDINATES(*;$vt_ButtonName;$vl_L;$vl_T;$vl_R;$vl_B)
  //If (<>vl_ULO_Button_Mode=1)  //Icon And Text")
  //$vl_B:=$vl_B-12
  //End if 

  //ARRAY TEXT($at_Titles;0)
  //ARRAY TEXT($at_Refs;0)
  //GET MENU ITEMS(vt_Views_Menu;$at_Titles;$at_Refs)
  //$vl_PosAmend:=Find in array($at_Titles;"Amend Current View")
  //$vl_PosDelete:=Find in array($at_Titles;"Delete Current View")

  //If (vb_ULO_CanAmendCurrent)
  //If ($vl_PosAmend#-1)
  //ENABLE MENU ITEM(vt_Views_Menu;$vl_PosAmend)
  //End if 
  //If ($vl_PosDelete#-1)
  //ENABLE MENU ITEM(vt_Views_Menu;$vl_PosDelete)
  //End if 

  //Else 
  //If ($vl_PosAmend#-1)
  //DISABLE MENU ITEM(vt_Views_Menu;$vl_PosAmend)
  //End if 
  //If ($vl_PosDelete#-1)
  //DISABLE MENU ITEM(vt_Views_Menu;$vl_PosDelete)
  //End if 

  //End if 


  //$vt_Selected:=Dynamic pop up menu(vt_Views_Menu;"";$vl_L;$vl_B)
  //If ($vt_Selected#"")
  //BRW_VIEW_POPUP($vt_Selected)
  //End if 

  //: ($vt_ULO_ActionRequested=BROWSER Inspector)
  //BRW_INSPECTOR


  //: ($vt_ULO_ActionRequested=BROWSER Apply Formula)



  //: ($vt_ULO_ActionRequested=BROWSER Find)

  //: ($vt_ULO_ActionRequested=BROWSER Help)





  //: ($vt_ULO_ActionRequested=BROWSER Print Selection)
  //BRW_PRINT_SELECTION

  //: ($vt_ULO_ActionRequested=BROWSER Quick Report)  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  //: ($vt_ULO_ActionRequested=BROWSER Report)  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //BRW_REPORT_POPUP

  //: ($vt_ULO_ActionRequested=BROWSER Tools)  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  //Else 

  //$vl_Find:=Find in array(at_ULO_ListButtons_Action;$vt_ULO_ActionRequested)
  //If ($vl_Find>0)
  //If (Find in array(<>at_MethodPath;"HOST_ULO_TABLE_CUSTOM_BUTTON")>0)
  //If (METHOD Get attribute("HOST_ULO_TABLE_CUSTOM_BUTTON";Attribute shared;*))
  //EXECUTE METHOD("HOST_ULO_TABLE_CUSTOM_BUTTON";*;$vt_ULO_ActionRequested;vl_ULO_Table;vt_ULO_Handle;OBJECT Get name(Object current))
  //End if 
  //End if 
  //End if 



  //End case 

  //End case 

  //BRW_BUTTONS_UPDATE(vb_Showing_URL)

