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
C_LONGINT:C283($5;$6;$cp;$index)
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
				$index:=Storage:C1525.sidebar.length
				Storage:C1525.sidebar[$index-1].index:=$index
				Storage:C1525.sidebar[$index-1].type:=$1
				Storage:C1525.sidebar[$index-1].title:=$2
				Storage:C1525.sidebar[$index-1].handle:=$3
				Storage:C1525.sidebar[$index-1].icon:=$4
				Storage:C1525.sidebar[$index-1].style:=$5
				If ($cp>5)
					Storage:C1525.sidebar[$index-1].table:=$6
					Storage:C1525.sidebar[$index-1].childOf:=$7  //Parent handle
					Storage:C1525.sidebar[$index-1].findFields:=New shared collection:C1527
					If ($8.length>0)
						Use (Storage:C1525.sidebar[$index-1].findFields)
							For each ($vt_field;$8)
								Storage:C1525.sidebar[$index-1].findFields.push($vt_field)
							End for each 
						End use   //END use findFields
					End if   //END findFields length check
					Storage:C1525.sidebar[$index-1].actionMethods:=New shared collection:C1527
					If ($9.length>0)
						Use (Storage:C1525.sidebar[$index-1].actionMethods)
							For each ($vo_act;$9)
								Storage:C1525.sidebar[$index-1].actionMethods.push(New shared object:C1526("action";$vo_act.action;"method";$vo_act.method))
							End for each 
						End use   //END use actionMethods
					End if   //END actionMethods length check
				End if   //END Count parameter check
				
			End use   //END Use Storage.sidebar
		End use   //END Use Storage
	End if   //End INIT check
End if   //End parameter check

