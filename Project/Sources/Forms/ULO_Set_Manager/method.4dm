C_LONGINT:C283($vl_FormEvent;$vl_Col;$vl_Row)
C_LONGINT:C283($vl_Total;vl_SET_HowManyFavourites)
C_TEXT:C284($vt_setChosen1;$vt_setChosen2)

$vl_FormEvent:=Form event code:C388

If ($vl_FormEvent=On Load:K2:1)
	OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->:=1
	OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_4")->:=0
	OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->:=0
	OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=0
End if 

If ($vl_FormEvent=On Load:K2:1)
	ULO_SET_BACKGROUND 
	ULO_SET_LIST_COLOURS ("MySets")
	
	OBJECT SET ENABLED:C1123(*;"SET_Manage_Load";False:C215)
	
End if 

Case of 
	: (FORM Get current page:C276=2) & ($vl_FormEvent=On Clicked:K2:4)
		
		If (vl_SET_HowManyFavourites>=Storage:C1525.prefs.maxSetsInMenu)
			OBJECT SET ENABLED:C1123(*;"SET_Is_Favourite";False:C215)
			OBJECT SET TITLE:C194(*;"SET_Is_Favourite";"Maximum Favourites Reached")
			OBJECT Get pointer:C1124(Object named:K67:5;"SET_Is_Favourite")->:=0
		Else 
			OBJECT SET ENABLED:C1123(*;"SET_Is_Favourite";True:C214)
			OBJECT SET TITLE:C194(*;"SET_Is_Favourite";"Is Favourite")
		End if 
		
		LISTBOX GET CELL POSITION:C971(*;"MySets";$vl_Col;$vl_Row)
		OBJECT SET ENABLED:C1123(*;"SET_Manage_Load";($vl_Row>0))
		
		
	: (FORM Get current page:C276=1) & (($vl_FormEvent=On Load:K2:1) | ($vl_FormEvent=On Clicked:K2:4) | ($vl_FormEvent=On Data Change:K2:15))
		
		$vt_setChosen1:="Set 1"  //Set this value
		$vt_setChosen2:="Set 2"  //Set this value
		If (vl_SET_HowManyFavourites>=Storage:C1525.prefs.maxSetsInMenu)
			OBJECT SET ENABLED:C1123(*;"SET_Is_Favourite";False:C215)
			OBJECT SET TITLE:C194(*;"SET_Is_Favourite";"Maximum Favourites Reached")
		Else 
			OBJECT SET TITLE:C194(*;"SET_Is_Favourite";"Is Favourite")
		End if 
		
		Case of 
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=0)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:=""
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=0
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=0)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="All records which are in set '"+$vt_setChosen1+"' but are not in set '"+$vt_setChosen1+"'."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=1
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=0)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="All records which appear in both set '"+$vt_setChosen1+"' and in set '"+$vt_setChosen2+"', ignoring those that only appear in one of the sets and not the other."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=2
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SETS_Venn_1")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=1)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="All records which are in set '"+$vt_setChosen2+"' but are not in set '"+$vt_setChosen1+"'."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=3
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=0)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="Duplicate of set '"+$vt_setChosen1+"'."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=4
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=1)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="Duplicate of set '"+$vt_setChosen2+"'."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=5
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=0) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=1)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="All records which appear either in set '"+$vt_setChosen1+"' or in set '"+$vt_setChosen1+"', ignoring those that appear in both."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=6
				
			: (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->=1) & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->=1)
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->:="All records which appear in either set '"+$vt_setChosen1+"' and in set '"+$vt_setChosen2+"'."
				OBJECT Get pointer:C1124(Object named:K67:5;"SET_ShowVenn")->:=7
				
		End case 
		
		If (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Name")->#"") & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_VennDesc")->#"") & (OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_1")->+OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_2")->+OBJECT Get pointer:C1124(Object named:K67:5;"SET_Venn_3")->#0)
			OBJECT SET ENABLED:C1123(*;"SET_Manage_Save";True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*;"SET_Manage_Save";False:C215)
		End if 
		
		If (cb_SETS_Venn_1=0) & (cb_SETS_Venn_2=0) & (cb_SETS_Venn_3=0)
			OBJECT SET ENABLED:C1123(*;"SET_Manage_LoadSel";False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*;"SET_Manage_LoadSel";True:C214)
		End if 
		
		
End case 