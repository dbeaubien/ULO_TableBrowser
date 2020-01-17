//%attributes = {"invisible":true,"shared":true}

  // ----------------------------------------------------
  // User name (OS): Dougie
  // Date and time: 07/01/20, 12:05:15
  // ----------------------------------------------------
  // Method: ULO_BROWSER_EVENT
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($1;$vl_event;$cp)
C_OBJECT:C1216($vo_sub)
C_TEXT:C284($2;$vt_eventType)
C_POINTER:C301($vp_nil)
$cp:=Count parameters:C259
If ($cp>1)
	$vt_eventType:=$2
Else 
	$vt_eventType:="form"
End if 

Case of 
	: ($vt_eventType="form")
		Case of 
			: ($vl_event=On Load:K2:1)
				LISTBOX SELECT ROW:C912(*;"ULO_Navbar";1;lk replace selection:K53:1)
				ULO_LOAD_VIEW (Form:C1466)
		End case 
		
	: ($vt_eventType="ULO_Navbar")
		Case of 
			: ($1=On Double Clicked:K2:5)
				If (Form:C1466.entity.sub#Null:C1517)
					If (Form:C1466.entity.sub.length>0)
						If (Form:C1466.entity.collapsed)  //Then expand based on type
							For each ($vo_sub;Form:C1466.entity.sub)
								Form:C1466.entities.insert(Form:C1466.selectedEntity;$vo_sub)
							End for each 
							Form:C1466.entity.collapsed:=False:C215
						Else   //Then collapse
							If (UTIL_Recursive_Find_Col_Number (Form:C1466.entity.sub;"index";Form:C1466.lastEntityIndex;"sub")=Null:C1517)
								For each ($vo_sub;Form:C1466.entity.sub)
									Form:C1466.entities.remove(Form:C1466.selectedEntity)
								End for each 
								Form:C1466.entity.collapsed:=True:C214
							End if 
						End if 
						Form:C1466.entities:=Form:C1466.entities
					End if   //END Check that the entity has sub elements
				End if   //END Check Form.entity.sub not null
				ALERT:C41($vt_eventType+" - "+String:C10($1))
				
			: ($1=On Clicked:K2:4)
				ULO_LOAD_VIEW (Form:C1466)
				
				
		End case 
		
	Else 
		
End case 