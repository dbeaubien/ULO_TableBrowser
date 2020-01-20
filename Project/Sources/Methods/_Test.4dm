//%attributes = {}
  //Waggler test method - Commented

  //C_LONGINT($vl_elem)
  //C_COLLECTION($vc_sidebar;$vc_buttons)
  //EXECUTE METHOD("ULO_SET_TABLE_TITLES")

  //  //Set up the sidebar nav tems
  //$vl_err:=0
  //EXECUTE METHOD("ULO_SET_SIDEBAR_ITEM";$vl_err;"INIT")
  //EXECUTE METHOD("ULO_SET_SIDEBAR_ITEM";$vl_err;"HEADER";"GROUP ONE";"HEADER1";"";Bold)
  //EXECUTE METHOD("ULO_SET_SIDEBAR_ITEM";$vl_err;"DATA";"Member";"MEMBER";"";Plain;Table(->[member]);"HEADER1";$vc_findFields;$vc_actionMethods)
  //EXECUTE METHOD("ULO_SET_SIDEBAR_ITEM";$vl_err;"HEADER";"GROUP TWO";"HEADER2";"";Bold)
  //EXECUTE METHOD("ULO_SET_SIDEBAR_ITEM";$vl_err;"DATA";"JT Form";"JTFORM";"";Italic;Table(->[jtForm]);"HEADER2";$vc_findFields;$vc_actionMethods)
  //EXECUTE METHOD("ULO_SET_SIDEBAR_ITEM";$vl_err;"DATA";"Profile";"PROFILE";"";Plain;Table(->[profile]);"JTFORM";$vc_findFields;$vc_actionMethods)

  //  //Now set up the browser buttons
  //$vl_colour:=0x00E5F2F7  //0x00FF6929
  //$vl_colourFont:=0x7BAD
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"INIT")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"New Record";"New";"Add new record";"add.png";False;"N";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_NEW")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"SHOWALL";"Show All";"Show all records";"showall.png";False;"G";Command key mask;$vl_colour;$vl_colourFont;"")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"SHOWSUBSET";"Show Subset";"Show subset";"showsubset.png";False;"H";Command key mask;$vl_colour;$vl_colourFont;"")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"OMITSUBSET";"Omit Subset";"Omit subset";"omitsubset.png";False;"O";Command key mask;$vl_colour;$vl_colourFont;"")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"SEARCH";"Find";"Run a query";"searchpop.png";True;"F";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_SEARCH")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"Sort";"Sort";"Sort the listing";"sortpop.png";True;"T";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_SORT")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"PRINT";"Print";"Print options";"printpop.png";True;"P";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_PRINT")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"Actions";"Actions";"Special actions";"actionspop.png";True;"";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_BUTTON_METHOD")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"FIND";"Find";"Find";"";True;"";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_FIND")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"Advanced";"Advanced";"Advanced actions";"advancedpop.png";True;"";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_BUTTON_METHOD")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"VIEWS";"Views";"Manage views";"viewspop.png";True;"";Command key mask;$vl_colour;$vl_colourFont;"")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"ToDo";"To Do Items";"To do actions";"todospop.png";True;"";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_BUTTON_METHOD")
  //EXECUTE METHOD("ULO_SET_BUTTON";*;"Inspector";"Inspector";"Data inspector";"inspector.png";True;"";Command key mask;$vl_colour;$vl_colourFont;"HOST_ULO_BUTTON_METHOD")

  //EXECUTE METHOD("ULO_SET_USER";*;1;"Test")

  //C_OBJECT($vo_winData)
  //$vo_winData:=New object
  //$vo_winData.wLeft:=10
  //$vo_winData.wTop:=120
  //$vo_winData.wRight:=1510
  //$vo_winData.wBottom:=650
  //$vo_winData.wType:=Plain window
  //$vo_winData.wTitle:="My Browser"
  //$vo_winData.sidebarStart:="MEMBER"
  //EXECUTE METHOD("ULO_MAIN";*;1;$vo_winData)

