C_TEXT:C284($vt_saveMenu;$vt_selected)
C_BOOLEAN:C305($vb_disable)
C_OBJECT:C1216($vo_saveForm)
C_LONGINT:C283($vl_wind)

If (Form event code:C388=On Clicked:K2:4)
	
	$vt_saveMenu:=Create menu:C408
	
	APPEND MENU ITEM:C411($vt_saveMenu;"Save")
	SET MENU ITEM PARAMETER:C1004($vt_saveMenu;-1;"save")
	
	$vb_disable:=True:C214
	If (OB Is defined:C1231(Form:C1466.selectedQuery;"user"))
		If (Form:C1466.selectedQuery.user=Storage:C1525.user.id)
			$vb_disable:=False:C215
		End if 
	End if 
	
	If ($vb_disable)
		DISABLE MENU ITEM:C150($vt_saveMenu;-1)
	End if 
	
	APPEND MENU ITEM:C411($vt_saveMenu;"Save as New")
	SET MENU ITEM PARAMETER:C1004($vt_saveMenu;-1;"savenew")
	
	$vt_selected:=Dynamic pop up menu:C1006($vt_saveMenu)
	
	If ($vt_selected#"")
		$vo_saveForm:=New object:C1471
		If ($vt_selected="save")
			$vo_saveForm.name:=Form:C1466.selectedQuery.name
			$vo_saveForm.public:=Form:C1466.selectedQuery.detail.public
		Else 
			If (OB Is defined:C1231(Form:C1466.selectedQuery;"name"))
				$vo_saveForm.name:=Form:C1466.selectedQuery.name+" - Copy"
				$vo_saveForm.public:=False:C215
			Else 
				$vo_saveForm.name:="New Query - "+Form:C1466.tableName
				$vo_saveForm.public:=False:C215
			End if 
		End if 
		
		  //open save form
		$vl_wind:=Open form window:C675("ULO_Query_Save";Sheet form window:K39:12)
		SET WINDOW TITLE:C213("Query Save";$vl_wind)
		DIALOG:C40("ULO_Query_Save";$vo_saveForm)
		CLOSE WINDOW:C154($vl_wind)
		
		If (OK=1)
			If ($vt_selected="save")
				Form:C1466.selectedQuery.name:=$vo_saveForm.name
				Form:C1466.selectedQuery.detail.public:=$vo_saveForm.public
				Form:C1466.selectedQuery.detail.query:=Form:C1466.lastQuery
				$vo_res:=Form:C1466.selectedQuery.save()
				If ($vo_res.success)
					vt_loadMenu:=QE_BUILD_LOAD_MENU (Form:C1466.tableNumber)
					ALERT:C41("Query Saved!")
				Else 
					ALERT:C41("Error saving Query! "+$vo_res.statusText)
				End if 
				
			Else 
				$e_query:=ds:C1482["uloData"].new()
				$e_query.user:=Storage:C1525.user.id
				$e_query.name:=$vo_saveForm.name
				$e_query.type:=5
				$e_query.table:=Form:C1466.tableNumber
				$e_query.handle:=Form:C1466.tableName
				$e_query.detail:=New object:C1471
				$e_query.detail.public:=$vo_saveForm.public
				$e_query.detail.query:=Form:C1466.lastQuery
				$vo_res:=$e_query.save()
				If ($vo_res.success)
					Form:C1466.selectedQuery:=$e_query
					vt_loadMenu:=QE_BUILD_LOAD_MENU (Form:C1466.tableNumber)
					ALERT:C41("Query Saved!")
				Else 
					ALERT:C41("Error saving Query! "+$vo_res.statusText)
				End if 
			End if 
			
			
		End if 
		
		RELEASE MENU:C978($vt_saveMenu)
		
	End if 