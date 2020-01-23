  //C_LONGINT($vl_col;$vl_Row;$vl_Browser_Listing_BG_Colour;$vl_Browser_Listing_BG_AltColour)

  //LISTBOX GET CELL POSITION(*;"BRW_Styles";$vl_col;$vl_Row)
  //If ($vl_Row=1)
  //EXECUTE METHOD("PREF_GET_NUM";$vl_Browser_Listing_BG_Colour;"Browser Listing Background Colour")
  //EXECUTE METHOD("PREF_GET_NUM";$vl_Browser_Listing_BG_AltColour;"Browser Listing Background Alt Colour")

  //OBJECT SET RGB COLORS(*;"brw_Preview_styles";0x0000;$vl_Browser_Listing_BG_Colour;$vl_Browser_Listing_BG_AltColour)
  //vt_BRW_VIEW_STYLE:=""
  //Else 
  //BRW_VIEW_SET_STYLE(at_Colour_Style{$vl_Row})
  //OBJECT SET RGB COLORS(*;"brw_Preview_styles";0x0000;vl_BRW_Colour_2;vl_BRW_Colour_1)
  //vt_BRW_VIEW_STYLE:=at_Colour_Style{$vl_Row}
  //End if 