//%attributes = {}
C_OBJECT:C1216($1; $vo_status)
C_TEXT:C284($vt_eventObject; $vt_method)
C_LONGINT:C283($vl_event; $vl_index)
C_COLLECTION:C1488(vc_buttons)
C_BOOLEAN:C305($vb_continue)

$vl_event:=$1.code

If (OB Is defined:C1231($1; "objectName"))
	$vt_eventObject:=$1.objectName
Else 
	$vt_eventObject:="form"
End if 

Case of 
	: ($vt_eventObject="form")
		Case of 
			: ($vl_event=On Load:K2:1)
				
				ULO_SET_BACKGROUND
				
				//ULO_LOAD_THEME
				UEO_LOAD_BUTTONS(vc_buttons)  //Form.buttons)
				//EXECUTE METHOD(Storage.hostMethods.inputFormEvent; *; $1)
				SET TIMER:C645(1)
				
			: ($vl_event=On Timer:K2:25)
				SET TIMER:C645(0)
				OBJECT SET ENABLED:C1123(*; "UEO_Button_FIRSTRECORD"; (Form:C1466.selectedRecordIndex>1))
				OBJECT SET ENABLED:C1123(*; "UEO_Button_PREVIOUSRECORD"; (Form:C1466.selectedRecordIndex>1))
				OBJECT SET ENABLED:C1123(*; "UEO_Button_NEXTRECORD"; (Form:C1466.selectedRecordIndex<Form:C1466.uloRecords.length))
				OBJECT SET ENABLED:C1123(*; "UEO_Button_LASTRECORD"; (Form:C1466.selectedRecordIndex<Form:C1466.uloRecords.length))
				OBJECT SET TITLE:C194(*; "UEO_navText"; "Record "+String:C10(Form:C1466.selectedRecordIndex)+" of "+String:C10(Form:C1466.uloRecords.length))
				
		End case 
		
		
	: ($vt_eventObject="UEO_Button_@")  //One of the buttons has been clicked
		$vb_continue:=True:C214
		$vl_index:=vc_buttons.findIndex("UTIL_Find_Collection"; "reference"; $vt_eventObject)
		If ($vl_index>=0)
			$vt_method:=vc_buttons[$vl_index].method
		End if 
		Case of 
			: ($vt_eventObject="UEO_Button_SAVERECORD")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; $vo_status; Form:C1466.selectedRecord)
					$vb_continue:=$vo_status.success
				End if 
				If ($vb_continue)
					ACCEPT:C269
				End if 
				
			: ($vt_eventObject="UEO_Button_CANCELRECORD")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; $vo_status; Form:C1466.selectedRecord)
					$vb_continue:=$vo_status.success
				End if 
				If ($vb_continue)
					CANCEL:C270
				End if 
				
			: ($vt_eventObject="UEO_Button_FIRSTRECORD")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; $vo_status; Form:C1466.selectedRecord)
					$vb_continue:=$vo_status.success
				End if 
				If ($vb_continue)
					Form:C1466.selectedRecordIndex:=1
					Form:C1466.selectedRecord:=Form:C1466.uloRecords.first()
				End if 
				
			: ($vt_eventObject="UEO_Button_LASTRECORD")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; $vo_status; Form:C1466.selectedRecord)
					$vb_continue:=$vo_status.success
				End if 
				If ($vb_continue)
					Form:C1466.selectedRecordIndex:=Form:C1466.uloRecords.length
					Form:C1466.selectedRecord:=Form:C1466.uloRecords.last()
				End if 
				
			: ($vt_eventObject="UEO_Button_PREVIOUSRECORD")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; $vo_status; Form:C1466.selectedRecord)
					$vb_continue:=$vo_status.success
				End if 
				If ($vb_continue)
					If (Form:C1466.selectedRecordIndex>1)
						Form:C1466.selectedRecordIndex:=Form:C1466.selectedRecordIndex-1
						Form:C1466.selectedRecord:=Form:C1466.uloRecords[(Form:C1466.selectedRecordIndex-1)]
					End if 
				End if 
			: ($vt_eventObject="UEO_Button_NEXTRECORD")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; $vo_status; Form:C1466.selectedRecord)
					$vb_continue:=$vo_status.success
				End if 
				If ($vb_continue)
					If (Form:C1466.selectedRecordIndex<Form:C1466.uloRecords.length)
						Form:C1466.selectedRecordIndex:=Form:C1466.selectedRecordIndex+1
						Form:C1466.selectedRecord:=Form:C1466.uloRecords[(Form:C1466.selectedRecordIndex-1)]
					End if 
				End if 
			: ($vt_eventObject="UEO_Button_HISTORY")
				If ($vt_method#"")
					EXECUTE METHOD:C1007($vt_method; *)
				End if 
				
		End case 
		//Set nav button states
		OBJECT SET ENABLED:C1123(*; "UEO_Button_FIRSTRECORD"; (Form:C1466.selectedRecordIndex>1))
		OBJECT SET ENABLED:C1123(*; "UEO_Button_PREVIOUSRECORD"; (Form:C1466.selectedRecordIndex>1))
		OBJECT SET ENABLED:C1123(*; "UEO_Button_NEXTRECORD"; (Form:C1466.selectedRecordIndex<Form:C1466.uloRecords.length))
		OBJECT SET ENABLED:C1123(*; "UEO_Button_LASTRECORD"; (Form:C1466.selectedRecordIndex<Form:C1466.uloRecords.length))
		OBJECT SET TITLE:C194(*; "UEO_navText"; "Record "+String:C10(Form:C1466.selectedRecordIndex)+" of "+String:C10(Form:C1466.uloRecords.length))
		
End case 