//%attributes = {"invisible":true}
C_OBJECT:C1216($vo_col;$vo_view)
C_POINTER:C301($vp_nil;$vp_table)
C_LONGINT:C283($i;$vl_columns;$vl_type;$vl_numFields;$vl_fontStyle;$vl_alignment;$vl_fontColour)
C_TEXT:C284($vt_colName;$vt_hObject;$vt_formula;$vt_header;$vt_fObject;$vt_format)

Form:C1466.tableNumber:=Form:C1466.navItem.table
If (Form:C1466.tableNumber>0)
	  //Form.lastNavItemIndex:=Form.navItem.index
	Form:C1466.lastNavItemIndex:=UTIL_Col_Find_Index (Form:C1466.navItems;"index";Form:C1466.navItem.index)+1
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
					  //$vt_colName:="h_"+Field name(Table($vp_table);$vo_col.field) //Tom - Field name is not always unique, changed to Table + Field num
					$vt_colName:="h_"+String:C10($vo_col.table)+"_"+String:C10($vo_col.field)
					
					$vt_hObject:="head_"+$vt_colName
					$vt_fObject:="foot_"+$vt_colName
					
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
					If (Undefined:C82($vo_col.fontStyle))
						$vl_fontStyle:=0
					Else 
						$vl_fontStyle:=$vo_col.fontStyle
					End if 
					If (Undefined:C82($vo_col.alignment))
						$vl_alignment:=Align default:K42:1
					Else 
						Case of 
							: ($vo_col.alignment="left")
								$vl_alignment:=Align left:K42:2
							: ($vo_col.alignment="right")
								$vl_alignment:=Align right:K42:4
							: ($vo_col.alignment="center")
								$vl_alignment:=Align center:K42:3
							Else 
								$vl_alignment:=Align default:K42:1
						End case 
					End if 
					If (Undefined:C82($vo_col.fontColour))
						$vl_fontColour:=0
					Else 
						$vl_fontColour:=$vo_col.fontColour
					End if 
					If (Undefined:C82($vo_col.fontColourOverride))
						$vl_fontColour:=Form:C1466.theme.rowFontColour
					Else 
						$vl_fontColour:=Choose:C955($vo_col.fontColourOverride;$vl_fontColour;Form:C1466.theme.rowFontColour)
					End if 
					If (Undefined:C82($vo_col.format))
						$vt_format:=""
					Else 
						$vt_format:=$vo_col.format
					End if 
					
					If ($vo_col.table>0)
						$vt_formula:="This."+$vt_formula
					End if 
					LISTBOX INSERT COLUMN FORMULA:C970(*;"ULO_LIST";$i;$vt_colName;$vt_formula;\
						$vl_type;$vt_hObject;$vp_nil;$vt_fObject;$vp_nil)
					
					OBJECT SET FORMAT:C236(*;$vt_colName;$vt_format)
					OBJECT SET FONT STYLE:C166(*;$vt_colName;$vl_fontStyle)
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$vt_colName;$vl_alignment)
					OBJECT SET RGB COLORS:C628(*;$vt_colName;$vl_fontColour)
					
					OBJECT SET TITLE:C194(*;$vt_hObject;$vt_header)  //Sets the header text.
					OBJECT SET FONT:C164(*;$vt_hObject;"Label")  //Sets the header text.
					
					If (Form:C1466.navItem.selectedView.detail.useFooter)
						If ($vo_col.average) | ($vo_col.max) | ($vo_col.total) | ($vo_col.min)
							LISTBOX SET FOOTER CALCULATION:C1140(*;$vt_colName;lk footer custom:K70:1)
							
							OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$vt_fObject;$vl_alignment)
							OBJECT SET FORMAT:C236(*;$vt_fObject;$vt_format)
							If ($vl_fontStyle=0) | ($vl_fontStyle=2) | ($vl_fontStyle=4) | ($vl_fontStyle=6)
								$vl_fontStyle:=$vl_fontStyle+1  //Add bold if missing
							End if 
							OBJECT SET FONT STYLE:C166(*;$vt_fObject;$vl_fontStyle)
							OBJECT SET RGB COLORS:C628(*;$vt_fObject;$vl_fontColour)
						End if 
					End if 
					
					If (Not:C34(Undefined:C82($vo_col.width)))
						LISTBOX SET COLUMN WIDTH:C833(*;$vt_hObject;$vo_col.width)
					End if 
				End if 
			End if 
			
		End for each 
		
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView.detail;"headerHeight"))
			LISTBOX SET HEADERS HEIGHT:C1143(*;"ULO_LIST";Form:C1466.navItem.selectedView.detail.headerHeight;lk lines:K53:23)
		Else 
			LISTBOX SET HEADERS HEIGHT:C1143(*;"ULO_LIST";1;lk lines:K53:23)
		End if 
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView.detail;"rowHeight"))
			LISTBOX SET ROWS HEIGHT:C835(*;"ULO_LIST";Form:C1466.navItem.selectedView.detail.rowHeight;lk lines:K53:23)
		Else 
			LISTBOX SET ROWS HEIGHT:C835(*;"ULO_LIST";1;lk lines:K53:23)
		End if 
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView.detail;"lockedColumns"))
			LISTBOX SET LOCKED COLUMNS:C1151(*;"ULO_LIST";Form:C1466.navItem.selectedView.detail.lockedColumns)
		Else 
			LISTBOX SET LOCKED COLUMNS:C1151(*;"ULO_LIST";0)
		End if 
		
		ULO_LIST_UPDATE_FOOTER 
		
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
				$vl_fontColour:=Form:C1466.theme.rowFontColour
				OBJECT SET RGB COLORS:C628(*;Field name:C257(Table:C252($vp_table);$i);$vl_fontColour)  //Set column font colour
			End if 
			
			  //Define default column properties
			$vo_col:=New object:C1471
			$vo_col.field:=$i
			$vo_col.table:=Form:C1466.tableNumber
			$vo_col.fieldName:=Field name:C257(Table:C252($vp_table);$i)
			$vo_col.fieldType:=Type:C295(Field:C253(Table:C252($vp_table);$i)->)
			$vo_col.header:=$vo_col.fieldName
			$vo_col.formula:=$vo_col.fieldName
			$vo_col.relation:=""
			$vo_col.width:=100
			$vo_col.format:=""
			$vo_col.fontColourOverride:=False:C215
			$vo_col.fontColour:=0x0000
			$vo_col.fontColourHex:="000000"
			$vo_col.fontStyle:=0
			$vo_col.alignment:="Left"
			$vo_col.total:=False:C215
			$vo_col.min:=False:C215
			$vo_col.max:=False:C215
			$vo_col.average:=False:C215
			$vo_col.selected:=True:C214
			
			Form:C1466.navItem.selectedView.detail.cols.push(OB Copy:C1225($vo_col))
		End for 
	End if 
	Form:C1466.uloList:=Form:C1466.uloList
	ULO_APPLY_THEME ("ULO_LIST";Form:C1466.theme)
End if 
