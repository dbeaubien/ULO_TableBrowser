//%attributes = {"invisible":true}
C_OBJECT:C1216($vo_col;$vo_view)
C_POINTER:C301($vp_nil;$vp_table)
C_LONGINT:C283($i)

Form:C1466.tableNumber:=Form:C1466.navItem.table
If (Form:C1466.tableNumber>0)
	Form:C1466.lastNavItemIndex:=Form:C1466.navItem.index
	$vl_columns:=LISTBOX Get number of columns:C831(*;"ULO_LIST")
	LISTBOX DELETE COLUMN:C830(*;"ULO_LIST";1;$vl_columns)
	$vp_table:=Table:C252(Form:C1466.tableNumber)
	  //Need a way to check to see if we have a selection 
	  //for the selected data store and load it if we have
	  //If not then revert to all records...
	If (Form:C1466.navItem.selection#Null:C1517)
		Form:C1466.uloList:=Form:C1466.navItem.selection
	Else 
		Form:C1466.navItem.selection:=New object:C1471
		Form:C1466.navItem.selection:=ds:C1482[Table name:C256($vp_table)].all()
		Form:C1466.uloList:=Form:C1466.navItem.selection
		  //Push the loaded selection to the sore of current selections???
	End if 
	
	If (Form:C1466.navItem.selectedView=Null:C1517)
		$vo_view:=ULO_GET_VIEW (Storage:C1525.user.id;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //EXECUTE METHOD("HOST_ULO_SET_VIEW";$vo_view;Form.tableNumber)
		  //Form.navItem.view:=$vo_view.detail
		Form:C1466.navItem.selectedView:=OB Copy:C1225($vo_view)
	End if 
	
	If (Form:C1466.navItem.selectedView#Null:C1517)
		$i:=0
		For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
			If ($vo_col.selected)
				If (Is field number valid:C1000($vp_table;$vo_col.field))  //& (Type(Field(Table($vp_table);$i)->)#38)
					$i:=$i+1
					If (Undefined:C82($vo_col.colName))
						  //$vt_colName:="h_"+Field name(Table($vp_table);$vo_col.field) //Tom - Field name is not always unique, changed to Table + Field num
						$vt_colName:="h_"+String:C10($vo_col.table)+"_"+String:C10($vo_col.field)
					Else 
						$vt_colName:="h_"+$vo_col.colName
					End if 
					$vt_hObject:=$vt_colName
					If (Undefined:C82($vo_col.formula))
						$vt_formula:=Field name:C257(Table:C252($vp_table);$vo_col.field)
					Else 
						$vt_formula:=$vo_col.formula
					End if 
					If (Undefined:C82($vo_col.type))
						$vl_type:=Type:C295(Field:C253(Table:C252($vp_table);$vo_col.field)->)
					Else 
						$vl_type:=$vo_col.type
					End if 
					If (Undefined:C82($vo_col.header))
						$vt_header:=Field name:C257(Table:C252($vp_table);$vo_col.field)
					Else 
						$vt_header:=$vo_col.header
					End if 
					
					LISTBOX INSERT COLUMN FORMULA:C970(*;"ULO_LIST";$i;$vt_colName;\
						"This."+$vt_formula;\
						$vl_type;$vt_hObject;$vp_nil)
					OBJECT SET TITLE:C194(*;$vt_hObject;$vt_header)  //Sets the header text.
					OBJECT SET FONT:C164(*;$vt_hObject;"Label")  //Sets the header text.
					If (Not:C34(Undefined:C82($vo_col.width)))
						LISTBOX SET COLUMN WIDTH:C833(*;$vt_hObject;$vo_col.width)
					End if 
				End if 
			End if 
			
		End for each 
	Else 
		Form:C1466.navItem.selectedView:=New object:C1471
		Form:C1466.navItem.selectedView.id:=""
		Form:C1466.navItem.selectedView.user:=0
		Form:C1466.navItem.selectedView.detail:=New object:C1471
		Form:C1466.navItem.selectedView.detail.cols:=New collection:C1472
		$vl_numFields:=Get last field number:C255($vp_table)
		For ($i;1;$vl_numFields)
			If (Is field number valid:C1000($vp_table;$i))  //& (Type(Field(Table($vp_table);$i)->)#38)
				$vt_hObject:="h_"+Field name:C257(Table:C252($vp_table);$i)
				LISTBOX INSERT COLUMN FORMULA:C970(*;"ULO_LIST";$i;Field name:C257(Table:C252($vp_table);$i);\
					"This."+Field name:C257(Table:C252($vp_table);$i);\
					Type:C295(Field:C253(Table:C252($vp_table);$i)->);$vt_hObject;$vp_nil)
				OBJECT SET TITLE:C194(*;$vt_hObject;Field name:C257(Table:C252($vp_table);$i))  //Sets the header text.
				OBJECT SET FONT:C164(*;$vt_hObject;"Label")  //Sets the header text.
				  //If (al_AL_FieldWidth{$vl_Find}>0)
				  //LISTBOX SET COLUMN WIDTH(*;as_AL_FieldHeader{$vl_Find};al_AL_FieldWidth{$vl_Find})
				  //End if 
			End if 
			  //$vo_col:=New object("field";$i)
			  //;"colName";Field name(Table($vp_table);$i)
			  //;"formula";Field name(Table($vp_table);$vo_col.field)
			
			Form:C1466.navItem.selectedView.detail.cols.push(New object:C1471("field";$i))
		End for 
	End if 
	Form:C1466.uloList:=Form:C1466.uloList
End if 
