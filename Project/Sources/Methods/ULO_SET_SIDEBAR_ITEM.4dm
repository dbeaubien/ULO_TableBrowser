//%attributes = {"shared":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 09/01/20, 15:44:21
  // ----------------------------------------------------
  // Method: ULO_SET_SIDEBAR_ITEM
  // Description
  // Adds an item to the sidebar collection for the browser.
  //
  // Parameters
  // $1 = type
  // $2 = title
  // $3 = icon
  // $4 = fontStyle
  // $5 = handle
  // $6 = Object possible values - url, table, parent, findFields and actionMethods
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$3;$4;$vt_field;$vt_parent)
C_LONGINT:C283($5;$cp;$index;$vl_idx;$vl_levels)
C_OBJECT:C1216($6;$vo_act)
$cp:=Count parameters:C259
If ($cp>10) | ($cp=0)
	  //return an error for incorrect number of parameters
Else 
	If ($1="INIT")
		Use (Storage:C1525)
			Storage:C1525.sidebar:=New shared collection:C1527
		End use 
		
	Else 
		Use (Storage:C1525.sidebar)
			Storage:C1525.sidebar.push(New shared object:C1526)
			$index:=Storage:C1525.sidebar.length-1
			
			Storage:C1525.sidebar[$index].index:=$index+1
			Storage:C1525.sidebar[$index].type:=$1
			Storage:C1525.sidebar[$index].title:=$2
			Storage:C1525.sidebar[$index].handle:=$3
			Storage:C1525.sidebar[$index].icon:=$4
			Storage:C1525.sidebar[$index].style:=$5
			Storage:C1525.sidebar[$index].sub:=New shared collection:C1527
			Storage:C1525.sidebar[$index].expanded:=False:C215
			
			Case of 
				: ($1="HEADER")
					
					
				: ($1="WEB")
					$vt_parent:=$6.parent
					Storage:C1525.sidebar[$index].targetUrl:=$6.url
					If (Count parameters:C259>6)
						Storage:C1525.sidebar[$index].childOf:=$vt_parent
						
						If ($vt_parent#"")
							$vl_idx:=UTIL_Col_Find_Index (Storage:C1525.sidebar;"handle";$vt_parent)
							If ($vl_idx>=0)
								Storage:C1525.sidebar[$vl_idx].sub.push($index+1)
								Storage:C1525.sidebar[$index].childOfIndex:=$vl_idx
								$vl_levels:=ULO_Sidebar_Count_Level ($index)
								Storage:C1525.sidebar[$index].title:=("   "*$vl_levels)+Storage:C1525.sidebar[$index].title
							End if 
						End if 
					End if 
					
				: ($1="DATA")
					$vt_parent:=$6.parent
					
					Storage:C1525.sidebar[$index].table:=$6.table
					If (Count parameters:C259>6)
						Storage:C1525.sidebar[$index].childOf:=$vt_parent
						
						If ($vt_parent#"")
							$vl_idx:=UTIL_Col_Find_Index (Storage:C1525.sidebar;"handle";$vt_parent)
							If ($vl_idx>=0)
								Storage:C1525.sidebar[$vl_idx].sub.push($index+1)
								Storage:C1525.sidebar[$index].childOfIndex:=$vl_idx
								$vl_levels:=ULO_Sidebar_Count_Level ($index)
								Storage:C1525.sidebar[$index].title:=("   "*$vl_levels)+Storage:C1525.sidebar[$index].title
							End if 
						End if 
						
						Storage:C1525.sidebar[$index].findFields:=New shared collection:C1527
						If ($6.fiendFields.length>0)
							Use (Storage:C1525.sidebar[$index].findFields)
								For each ($vt_field;$6.fiendFields)
									Storage:C1525.sidebar[$index].findFields.push($vt_field)
								End for each 
							End use   //END use findFields
						End if   //END findFields length check
						
						Storage:C1525.sidebar[$index].buttonState:=New shared collection:C1527
						If ($6.buttonState.length>0)
							Use (Storage:C1525.sidebar[$index].buttonState)
								For each ($vo_act;$6.buttonState)
									Storage:C1525.sidebar[$index].buttonState.push(New shared object:C1526("code";$vo_act.code;"disabled";$vo_act.disabled))
								End for each 
							End use   //END use findFields
						End if   //END findFields length check
						
						If (OB Is defined:C1231($6;"windowTitle"))
							Storage:C1525.sidebar[$index].windowTitle:=$6.windowTitle
						Else 
							Storage:C1525.sidebar[$index].windowTitle:=$2
						End if 
						
					End if 
					
				Else 
					
					
					  //Use (Storage)
					  //If (Storage.sidebar=Null)
					  //Storage.sidebar:=New shared collection
					  //End if 
					  //Use (Storage.sidebar)
					  //Storage.sidebar.push(New shared object)
					  //  //IF HEADER - There can only be 4 parameters type,title,icon and style
					  //$index:=Storage.sidebar.length-1
					  //Storage.sidebar[$index].index:=$index+1
					  //Storage.sidebar[$index].type:=$1
					  //Storage.sidebar[$index].title:=$2
					  //Storage.sidebar[$index].handle:=$3
					  //Storage.sidebar[$index].icon:=$4
					  //Storage.sidebar[$index].style:=$5
					  //Storage.sidebar[$index].sub:=New shared collection
					  //Storage.sidebar[$index].expanded:=False
					  //If ($cp>5)
					  //Storage.sidebar[$index].table:=$6
					  //Storage.sidebar[$index].childOf:=$7  //Parent handle
					
					  //If ($7#"")
					  //$vl_idx:=UTIL_Col_Find_Index (Storage.sidebar;"handle";$7)
					  //If ($vl_idx>=0)
					  //Storage.sidebar[$vl_idx].sub.push($index+1)
					  //Storage.sidebar[$index].childOfIndex:=$vl_idx
					  //End if 
					  //End if 
					
					  //Storage.sidebar[$index].findFields:=New shared collection
					  //If ($8.length>0)
					  //Use (Storage.sidebar[$index].findFields)
					  //For each ($vt_field;$8)
					  //Storage.sidebar[$index].findFields.push($vt_field)
					  //End for each 
					  //End use   //END use findFields
					  //End if   //END findFields length check
					
					  //Storage.sidebar[$index].actionMethods:=New shared collection
					  //If ($9.length>0)
					  //Use (Storage.sidebar[$index].actionMethods)
					  //For each ($vo_act;$9)
					  //Storage.sidebar[$index].actionMethods.push(New shared object("action";$vo_act.action;"method";$vo_act.method))
					  //End for each 
					  //End use   //END use actionMethods
					  //End if   //END actionMethods length check
					  //End if   //END Count parameter check
					
					  //End use   //END Use Storage.sidebar
					  //End use   //END Use Storage
			End case   //End type check
		End use 
	End if 
End if   //End parameter check

