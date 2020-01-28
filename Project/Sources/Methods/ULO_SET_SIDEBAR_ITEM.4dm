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
  // $6 = table
  // $7 = childOf
  // $8 = findFields
  // $9 = actionMethods
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$3;$4;$7;$vt_field)
C_LONGINT:C283($5;$6;$cp;$index;$vl_idx)
C_COLLECTION:C1488($8;$9)
C_OBJECT:C1216($vo_act)
$cp:=Count parameters:C259
If ($cp>10) | ($cp=0)
	  //return an error for incorrect number of parameters
Else 
	  //$vc_navItems:=New shared collection
	If ($1="INIT")
		Use (Storage:C1525)
			Storage:C1525.sidebar:=New shared collection:C1527
		End use 
	Else 
		Use (Storage:C1525)
			If (Storage:C1525.sidebar=Null:C1517)
				Storage:C1525.sidebar:=New shared collection:C1527
			End if 
			Use (Storage:C1525.sidebar)
				Storage:C1525.sidebar.push(New shared object:C1526)
				  //IF HEADER - There can only be 4 parameters type,title,icon and style
				$index:=Storage:C1525.sidebar.length-1
				Storage:C1525.sidebar[$index].index:=$index+1
				Storage:C1525.sidebar[$index].type:=$1
				Storage:C1525.sidebar[$index].title:=$2
				Storage:C1525.sidebar[$index].handle:=$3
				Storage:C1525.sidebar[$index].icon:=$4
				Storage:C1525.sidebar[$index].style:=$5
				Storage:C1525.sidebar[$index].sub:=New shared collection:C1527
				Storage:C1525.sidebar[$index].expanded:=False:C215
				If ($cp>5)
					Storage:C1525.sidebar[$index].table:=$6
					Storage:C1525.sidebar[$index].childOf:=$7  //Parent handle
					
					If ($7#"")
						$vl_idx:=UTIL_Col_Find_Index (Storage:C1525.sidebar;"handle";$7)
						If ($vl_idx>=0)
							Storage:C1525.sidebar[$vl_idx].sub.push($index+1)
							Storage:C1525.sidebar[$index].childOfIndex:=$vl_idx
						End if 
					End if 
					
					Storage:C1525.sidebar[$index].findFields:=New shared collection:C1527
					If ($8.length>0)
						Use (Storage:C1525.sidebar[$index].findFields)
							For each ($vt_field;$8)
								Storage:C1525.sidebar[$index].findFields.push($vt_field)
							End for each 
						End use   //END use findFields
					End if   //END findFields length check
					Storage:C1525.sidebar[$index].actionMethods:=New shared collection:C1527
					If ($9.length>0)
						Use (Storage:C1525.sidebar[$index].actionMethods)
							For each ($vo_act;$9)
								Storage:C1525.sidebar[$index].actionMethods.push(New shared object:C1526("action";$vo_act.action;"method";$vo_act.method))
							End for each 
						End use   //END use actionMethods
					End if   //END actionMethods length check
				End if   //END Count parameter check
				
			End use   //END Use Storage.sidebar
		End use   //END Use Storage
	End if   //End INIT check
End if   //End parameter check

