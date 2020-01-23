  //C_LONGINT($vl_FormEvent;$vl_Which)
  //  //$vl_FormEvent:=BRW_Form_Event

  //Case of 
  //: ($vl_FormEvent=On Load)
  //  //BRW_SET_BACKGROUND

  //ARRAY TEXT(at_Colour_Style;6)
  //at_Colour_Style{1}:="Default"
  //at_Colour_Style{2}:="OSX Blue"
  //at_Colour_Style{3}:="Old Grey"
  //at_Colour_Style{4}:="Plain"
  //at_Colour_Style{5}:="Windows Orange"
  //at_Colour_Style{6}:="Windows Pink"




  //$vl_Which:=Find in array(at_Colour_Style;<>vt_BRW_VIEW_STYLE)
  //LISTBOX SELECT ROW(*;"BRW_Styles";$vl_Which;lk replace selection)
  //If (<>vl_Browser_Listing_BG_Colour=0) & (<>vl_Browser_Listing_BG_AltColour=0)
  //  //BRW_VIEW_SET_STYLE
  //OBJECT SET RGB COLORS(*;"brw_Preview_styles";0x0000;vl_BRW_Colour_1;vl_BRW_Colour_2)
  //Else 
  //OBJECT SET RGB COLORS(*;"brw_Preview_styles";0x0000;<>vl_Browser_Listing_BG_Colour;<>vl_Browser_Listing_BG_AltColour)
  //End if 

  //If (Not(Is macOS))
  //vl_BRW_FONT_SIZE_Screen:=vl_BRW_FONT_SIZE+1
  //Else 
  //vl_BRW_FONT_SIZE_Screen:=vl_BRW_FONT_SIZE
  //End if 


  //vt_BRW_VIEW_STYLE:=<>vt_BRW_VIEW_STYLE

  //: ($vl_FormEvent=On Unload)
  //vl_BRW_FONT_SIZE:=vl_BRW_FONT_SIZE_Screen


  //End case 