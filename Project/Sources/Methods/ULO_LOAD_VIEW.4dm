//%attributes = {"shared":true}
C_BOOLEAN:C305($1;$vb_useViewTheme)
C_OBJECT:C1216($vo_col;$vo_view;$es_return;$es)
C_POINTER:C301($vp_nil;$vp_table)
C_LONGINT:C283($i;$vl_columns;$vl_type;$vl_numFields;$vl_fontStyle;$vl_alignment;\
$vl_fontColour;$vl_totalWidth;$vl_left;$vl_top;$vl_right;$vl_bottom;$vl_hAlignment)
C_TEXT:C284($vt_colName;$vt_hObject;$vt_formula;$vt_header;$vt_fObject;$vt_format;$vt_themeId)
  //Form.tableNumber:=Form.navItem.table

If (Count parameters:C259>0)
	$vb_useViewTheme:=$1
End if 

If (Form:C1466.tableNumber>0)
	FORM GOTO PAGE:C247(1)
	OBJECT SET ENABLED:C1123(*;"ULO_Button@";True:C214)
	OBJECT SET ENABLED:C1123(*;"ULO_Button_SHOWSUBSET";(Form:C1466.selectedRecords.length>0))
	OBJECT SET ENABLED:C1123(*;"ULO_Button_OMITSUBSET";(Form:C1466.selectedRecords.length>0))
	
	
	  //Form.lastNavItemIndex:=Form.navItem.index
	Form:C1466.lastNavItemIndex:=UTIL_Col_Find_Index (Form:C1466.navItems;"index";Form:C1466.navItem.index)+1
	$vl_columns:=LISTBOX Get number of columns:C831(*;"ULO_LIST")
	LISTBOX DELETE COLUMN:C830(*;"ULO_LIST";1;$vl_columns)
	$vp_table:=Table:C252(Form:C1466.tableNumber)
	
	If (Form:C1466.navItem.selectedView=Null:C1517)
		$vo_view:=ULO_GET_VIEW (Storage:C1525.user.id;Form:C1466.tableNumber;Form:C1466.navItem.handle)  //EXECUTE METHOD("HOST_ULO_SET_VIEW";$vo_view;Form.tableNumber)
		Form:C1466.navItem.selectedView:=OB Copy:C1225($vo_view)
	Else 
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView;"createNew"))
			  //Case only entered when 'System Default View' selected with no ID
			  //Below forces creation of default view
			$vo_view:=ULO_GET_VIEW (-10;-10;"NA")
			Form:C1466.navItem.selectedView:=OB Copy:C1225($vo_view)
		End if 
	End if 
	If (Storage:C1525.hostMethods.sidebarLoad#"")
		EXECUTE METHOD:C1007(Storage:C1525.hostMethods.sidebarLoad;$es_return;Form:C1466.tableNumber;Form:C1466.navItem.handle)
		Form:C1466.uloRecords:=$es_return
	End if 
	
	  //Need a way to check to see if we have a selection 
	  //for the selected data store and load it if we have
	  //If not then revert to all records...
	If (Form:C1466.navItem.selection#Null:C1517)
		Form:C1466.uloRecords:=Form:C1466.navItem.selection
	Else 
		If ($es_return#Null:C1517)
			Form:C1466.uloRecords:=$es_return
		Else 
			Form:C1466.navItem.selection:=New object:C1471
			$es:=ds:C1482[Table name:C256($vp_table)].all()
			If (Storage:C1525.hostMethods.filter#"")
				EXECUTE METHOD:C1007(Storage:C1525.hostMethods.filter;$es;Form:C1466.tableNumber;Form:C1466.navItem.handle;$es)
			End if 
			Form:C1466.navItem.selection:=$es
			Form:C1466.uloRecords:=Form:C1466.navItem.selection
		End if 
		  //Push the loaded selection to the sore of current selections???
	End if 
	
	If (Form:C1466.navItem.selectedView#Null:C1517)
		$i:=0
		$vl_totalWidth:=0
		
		For each ($vo_col;Form:C1466.navItem.selectedView.detail.cols)
			If ($vo_col.selected)
				$i:=$i+1
				
				$vt_colName:="h_"+String:C10($vo_col.table)+"_"+String:C10($vo_col.field)
				
				$vt_hObject:="head_"+$vt_colName
				$vt_fObject:="foot_"+$vt_colName
				
				If ($vo_col.table=-1)
					$vt_formula:=$vo_col.formula
				Else 
					$vt_formula:="This."+$vo_col.formula
				End if 
				
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
				
				$vl_fontColour:=Choose:C955($vo_col.fontColourOverride;$vo_col.fontColour;Form:C1466.theme.rowFontColour)
				
				LISTBOX INSERT COLUMN FORMULA:C970(*;"ULO_LIST";$i;$vt_colName;$vt_formula;\
					$vo_col.fieldType;$vt_hObject;$vp_nil;$vt_fObject;$vp_nil)
				
				If ($vo_col.fieldType=Is picture:K8:10)
					OBJECT SET FORMAT:C236(*;$vt_colName;Char:C90(Scaled to fit prop centered:K6:6))
				Else 
					If ($vo_col.format#"")
						OBJECT SET FORMAT:C236(*;$vt_colName;$vo_col.format)
					End if 
				End if 
				
				OBJECT SET FONT STYLE:C166(*;$vt_colName;$vo_col.fontStyle)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$vt_colName;$vl_alignment)
				OBJECT SET RGB COLORS:C628(*;$vt_colName;$vl_fontColour)
				OBJECT SET ENTERABLE:C238(*;$vt_colName;False:C215)
				
				OBJECT SET TITLE:C194(*;$vt_hObject;$vo_col.header)  //Sets the header text.
				OBJECT SET FONT:C164(*;$vt_hObject;"Label")  //Sets the header text.
				If (OB Is defined:C1231($vo_col;"headerAlignment"))
					Case of 
						: ($vo_col.headerAlignment="left")
							$vl_hAlignment:=Align left:K42:2
						: ($vo_col.headerAlignment="right")
							$vl_hAlignment:=Align right:K42:4
						: ($vo_col.headerAlignment="center")
							$vl_hAlignment:=Align center:K42:3
						Else 
							$vl_hAlignment:=Align default:K42:1
					End case 
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$vt_hObject;$vl_hAlignment)
				End if 
				
				If (Form:C1466.navItem.selectedView.detail.useFooter)
					If ($vo_col.average) | ($vo_col.max) | ($vo_col.total) | ($vo_col.min)
						LISTBOX SET FOOTER CALCULATION:C1140(*;$vt_colName;lk footer custom:K70:1)
						
						OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$vt_fObject;$vl_alignment)
						  //OBJECT SET FORMAT(*;$vt_fObject;$vo_col.format)
						
						If ($vo_col.fontStyle=0) | ($vo_col.fontStyle=2) | ($vo_col.fontStyle=4) | ($vo_col.fontStyle=6)
							$vl_fontStyle:=$vo_col.fontStyle+1  //Add bold if missing
						End if 
						OBJECT SET FONT STYLE:C166(*;$vt_fObject;$vl_fontStyle)
						OBJECT SET RGB COLORS:C628(*;$vt_fObject;$vl_fontColour)
					End if 
				End if 
				LISTBOX SET COLUMN WIDTH:C833(*;$vt_hObject;$vo_col.width)
				$vl_totalWidth:=$vl_totalWidth+$vo_col.width
				
				
				If (False:C215)
					  //If (Is field number valid($vp_table;$vo_col.field))  //& (Type(Field(Table($vp_table);$i)->)#38)
					  //  //$vt_colName:="h_"+Field name(Table($vp_table);$vo_col.field) //Tom - Field name is not always unique, changed to Table + Field num
					  //$vt_colName:="h_"+String($vo_col.table)+"_"+String($vo_col.field)
					
					  //$vt_hObject:="head_"+$vt_colName
					  //$vt_fObject:="foot_"+$vt_colName
					
					  //If (Undefined($vo_col.formula))
					  //$vt_formula:=Field name(Table($vp_table);$vo_col.field)
					  //Else 
					  //$vt_formula:=$vo_col.formula
					  //End if 
					  //If (Undefined($vo_col.type))
					  //$vl_type:=Type(Field(Table($vp_table);$vo_col.field)->)
					  //Else 
					  //$vl_type:=$vo_col.type
					  //End if 
					  //If (Undefined($vo_col.header))
					  //$vt_header:=Field name(Table($vp_table);$vo_col.field)
					  //Else 
					  //$vt_header:=$vo_col.header
					  //End if 
					  //If (Undefined($vo_col.fontStyle))
					  //$vl_fontStyle:=0
					  //Else 
					  //$vl_fontStyle:=$vo_col.fontStyle
					  //End if 
					  //If (Undefined($vo_col.alignment))
					  //$vl_alignment:=Align default
					  //Else 
					  //Case of 
					  //: ($vo_col.alignment="left")
					  //$vl_alignment:=Align left
					  //: ($vo_col.alignment="right")
					  //$vl_alignment:=Align right
					  //: ($vo_col.alignment="center")
					  //$vl_alignment:=Align center
					  //Else 
					  //$vl_alignment:=Align default
					  //End case 
					  //End if 
					  //If (Undefined($vo_col.fontColour))
					  //$vl_fontColour:=0
					  //Else 
					  //$vl_fontColour:=$vo_col.fontColour
					  //End if 
					  //If (Undefined($vo_col.fontColourOverride))
					  //$vl_fontColour:=Form.theme.rowFontColour
					  //Else 
					  //$vl_fontColour:=Choose($vo_col.fontColourOverride;$vl_fontColour;Form.theme.rowFontColour)
					  //End if 
					  //If (Undefined($vo_col.format))
					  //$vt_format:=""
					  //Else 
					  //$vt_format:=$vo_col.format
					  //End if 
					
					  //If ($vo_col.table>0)
					  //$vt_formula:="This."+$vt_formula
					  //End if 
					
					  //LISTBOX INSERT COLUMN FORMULA(*;"ULO_LIST";$i;$vt_colName;$vt_formula;\
																																																																																							$vl_type;$vt_hObject;$vp_nil;$vt_fObject;$vp_nil)
					
					  //OBJECT SET FORMAT(*;$vt_colName;$vt_format)
					  //OBJECT SET FONT STYLE(*;$vt_colName;$vl_fontStyle)
					  //OBJECT SET HORIZONTAL ALIGNMENT(*;$vt_colName;$vl_alignment)
					  //OBJECT SET RGB COLORS(*;$vt_colName;$vl_fontColour)
					  //OBJECT SET ENTERABLE(*;$vt_colName;False)
					
					  //OBJECT SET TITLE(*;$vt_hObject;$vt_header)  //Sets the header text.
					  //OBJECT SET FONT(*;$vt_hObject;"Label")  //Sets the header text.
					
					  //If (Form.navItem.selectedView.detail.useFooter)
					  //If ($vo_col.average) | ($vo_col.max) | ($vo_col.total) | ($vo_col.min)
					  //LISTBOX SET FOOTER CALCULATION(*;$vt_colName;lk footer custom)
					
					  //OBJECT SET HORIZONTAL ALIGNMENT(*;$vt_fObject;$vl_alignment)
					  //OBJECT SET FORMAT(*;$vt_fObject;$vt_format)
					  //If ($vl_fontStyle=0) | ($vl_fontStyle=2) | ($vl_fontStyle=4) | ($vl_fontStyle=6)
					  //$vl_fontStyle:=$vl_fontStyle+1  //Add bold if missing
					  //End if 
					  //OBJECT SET FONT STYLE(*;$vt_fObject;$vl_fontStyle)
					  //OBJECT SET RGB COLORS(*;$vt_fObject;$vl_fontColour)
					  //End if 
					  //End if 
					
					  //If (Not(Undefined($vo_col.width)))
					  //End if 
					  //End if 
				End if 
			End if 
			
		End for each 
		
		OBJECT GET COORDINATES:C663(*;"ULO_LIST";$vl_left;$vl_top;$vl_right;$vl_bottom)
		  //If total width of columns is less than Listbox width, add blank column for auto filling remaining space
		If ($vl_totalWidth<($vl_right-$vl_left))
			$i:=$i+1
			LISTBOX INSERT COLUMN FORMULA:C970(*;"ULO_LIST";$i;"fillerColumn";"This";Is text:K8:3;"header_fillerColumn";$vp_nil)
			LISTBOX SET COLUMN WIDTH:C833(*;"fillerColumn";0;0;0)
		End if 
		
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
		Form:C1466.navItem.selectedView.id:="XXXX"  //To link to 'System Default View' in BUTTON_VIEW_POP
		Form:C1466.navItem.selectedView.user:=0
		Form:C1466.navItem.selectedView.handle:=Form:C1466.navItem.handle
		Form:C1466.navItem.selectedView.detail:=New object:C1471
		Form:C1466.navItem.selectedView.detail.cols:=New collection:C1472
		$vl_numFields:=Get last field number:C255($vp_table)
		For ($i;1;$vl_numFields)
			
			If (Is field number valid:C1000($vp_table;$i)) & (Type:C295(Field:C253(Table:C252($vp_table);$i)->)#Is BLOB:K8:12)
				$vt_hObject:="h_"+String:C10(Table:C252($vp_table))+"_"+String:C10($i)
				$vt_colName:=Field name:C257(Table:C252($vp_table);$i)
				LISTBOX INSERT COLUMN FORMULA:C970(*;"ULO_LIST";$i;$vt_colName;\
					"This."+Field name:C257(Table:C252($vp_table);$i);\
					Type:C295(Field:C253(Table:C252($vp_table);$i)->);$vt_hObject;$vp_nil)
				OBJECT SET TITLE:C194(*;$vt_hObject;Field name:C257(Table:C252($vp_table);$i))  //Sets the header text.
				OBJECT SET FONT:C164(*;$vt_hObject;"Label")  //Sets the header text.
				OBJECT SET ENTERABLE:C238(*;$vt_colName;False:C215)
				$vl_fontColour:=Form:C1466.theme.rowFontColour
				OBJECT SET RGB COLORS:C628(*;Field name:C257(Table:C252($vp_table);$i);$vl_fontColour)  //Set column font colour
				
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
			End if   //END field valid and type check
		End for 
	End if 
	Form:C1466.uloRecords:=Form:C1466.uloRecords
	If ($vb_useViewTheme)
		If (OB Is defined:C1231(Form:C1466.navItem.selectedView.detail;"themeId"))
			$vt_themeId:=Form:C1466.navItem.selectedView.detail.themeId
		End if 
		If ($vt_themeId#"")
			Form:C1466.themeSelected:=False:C215
			ULO_LOAD_THEME ($vt_themeId)
		Else 
			ULO_LOAD_THEME (Form:C1466.themeSelectedId)
		End if 
	End if 
	
	ULO_APPLY_THEME ("ULO_LIST";Form:C1466.theme)
End if 
