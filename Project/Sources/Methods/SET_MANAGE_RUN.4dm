//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 21/02/20, 15:57:28
  // ----------------------------------------------------
  // Method: SET_MANAGE_RUN
  // Description
  // Runs set manipulation operations defined in Form
  //
  // Parameters
  // ----------------------------------------------------


C_OBJECT:C1216($es_runningSet;$vo_line;$e_newSet;$e_ulo;$e_ulo1;\
$e_ulo2;$es_set1;$es_set2;$vo_res)
C_BOOLEAN:C305($vb_continue)
C_POINTER:C301($vp_oper;$vp_set1;$vp_set2)
C_TEXT:C284($vt_pk;$vt_table)

Form:C1466.errorMessage:=""

  //First validate user data
  //Check a name has been entered and is valid
If (Form:C1466.newSetName#"")
	If (ds:C1482["uloData"].query("table == :1 && type == 1 && user == :2 && name == :3";Form:C1466.tableNumber;Storage:C1525.user.id;Form:C1466.newSetName).length=0)
		$vb_continue:=True:C214
	Else 
		Form:C1466.errorMessage:="A Set of this name already exists!"
		GOTO OBJECT:C206(*;"txt_newSetName")
	End if 
Else 
	Form:C1466.errorMessage:="The Result Set Name cannot be blank!"
	GOTO OBJECT:C206(*;"txt_newSetName")
End if 

  //Check original Sets / operation are selected
If ($vb_continue)
	$vb_continue:=False:C215
	$vp_set1:=OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_setOrig1")
	$vp_set2:=OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_setOrig2")
	$vp_oper:=OBJECT Get pointer:C1124(Object named:K67:5;"dropdown_operationOrig")
	
	Case of 
		: ($vp_set1->=0)
			Form:C1466.errorMessage:="Please select a starting Set 1"
		: ($vp_set2->=0)
			Form:C1466.errorMessage:="Please select a starting Set 2"
		: ($vp_oper->=0)
			Form:C1466.errorMessage:="Please select a starting Operation"
		Else 
			$vb_continue:=True:C214
	End case 
End if 

  //Check all lines have a selected Set and Operation
If ($vb_continue)
	For each ($vo_line;Form:C1466.subform.manipLines)
		If ($vo_line.set="") | ($vo_line.operation="")
			$vb_continue:=False:C215
		End if 
	End for each 
	If (Not:C34($vb_continue))
		Form:C1466.errorMessage:="All lines must have a Operation and Set selected!"
	End if 
End if 

If ($vb_continue)
	  //OK to run?
	$vt_table:=Table name:C256(Form:C1466.tableNumber)
	$vt_pk:=ds:C1482[$vt_table].getInfo().primaryKey
	
	$e_ulo1:=ds:C1482["uloData"].get(at_setId{$vp_set1->})
	$e_ulo2:=ds:C1482["uloData"].get(at_setId{$vp_set2->})
	
	$es_set1:=ds:C1482[$vt_table].query($vt_pk+" in :1";$e_ulo1.detail.recordIds)
	$es_set2:=ds:C1482[$vt_table].query($vt_pk+" in :1";$e_ulo2.detail.recordIds)
	
	Case of 
		: ($vp_oper->{$vp_oper->}="UNION")
			$es_runningSet:=$es_set1.or($es_set2)
			
		: ($vp_oper->{$vp_oper->}="DIFFERENCE")
			$es_runningSet:=$es_set1.minus($es_set2)
			
		: ($vp_oper->{$vp_oper->}="INTERSECTION")
			$es_runningSet:=$es_set1.and($es_set2)
			
	End case 
	
	For each ($vo_line;Form:C1466.subform.manipLines)
		$e_ulo:=ds:C1482["uloData"].get($vo_line.set)
		$es_set1:=ds:C1482[$vt_table].query($vt_pk+" in :1";$e_ulo.detail.recordIds)
		
		Case of 
			: ($vo_line.operation="UNION")
				$es_runningSet:=$es_runningSet.or($es_set1)
				
			: ($vo_line.operation="DIFFERENCE")
				$es_runningSet:=$es_runningSet.minus($es_set1)
				
			: ($vo_line.operation="INTERSECTION")
				$es_runningSet:=$es_runningSet.and($es_set1)
				
		End case 
		
	End for each 
	
	  //Save RunningSet as new!
	
	$e_newSet:=ds:C1482["uloData"].new()
	$e_newSet.detail:=New object:C1471
	$e_newSet.user:=Storage:C1525.user.id
	$e_newSet.table:=Form:C1466.tableNumber
	$e_newSet.name:=Form:C1466.newSetName
	$e_newSet.type:=1
	$e_newSet.handle:=Form:C1466.handle
	$e_newSet.group:=1
	$e_newSet.detail.public:=Form:C1466.public
	$e_newSet.detail.recordIds:=New collection:C1472
	$e_newSet.detail.recordIds:=$es_runningSet[$vt_pk]
	$vo_res:=$e_newSet.save()
	
	If ($vo_res.success)
		ALERT:C41("New Set created!")
		
		  //Reset form
	End if 
	
End if 
