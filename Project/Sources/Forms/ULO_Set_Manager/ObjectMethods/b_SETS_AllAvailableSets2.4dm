  //C_LONGINT($vl_L;$vl_R;$vl_T;$vl_B;$i)
  //C_TEXT($vt_Selected)
  //OBJECT GET COORDINATES(*;"SETS_AllAvailableSets2";$vl_L;$vl_T;$vl_R;$vl_B)

  //For ($i;1;Size of array(al_SETS_AllMySets))
  //Case of 
  //: ($i=vl_SETS_Selected_2)
  //SET MENU ITEM MARK(vt_SETS_AllAvailableSetsMenu;$i;Char(18))
  //ENABLE MENU ITEM(vt_SETS_AllAvailableSetsMenu;$i)
  //: ($i=vl_SETS_Selected_1)
  //SET MENU ITEM MARK(vt_SETS_AllAvailableSetsMenu;$i;"")
  //DISABLE MENU ITEM(vt_SETS_AllAvailableSetsMenu;$i)
  //Else 
  //SET MENU ITEM MARK(vt_SETS_AllAvailableSetsMenu;$i;"")
  //ENABLE MENU ITEM(vt_SETS_AllAvailableSetsMenu;$i)
  //End case 
  //End for 

  //$vt_Selected:=Dynamic pop up menu(vt_SETS_AllAvailableSetsMenu;String(vl_SETS_Selected_1);$vl_L;$vl_T)
  //If ($vt_Selected#"")
  //vl_SETS_Selected_2:=Num($vt_Selected)
  //at_SETS_AllAvailableSets2{0}:=at_SETS_AllMySets{vl_SETS_Selected_2}
  //End if 