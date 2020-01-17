//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 15/01/20, 15:15:16
  // ----------------------------------------------------
  // Method: VIEW_FORM_BUILD_DISPLAY_COL
  // Description
  // Populates the collection Form.displayCols
  // according to selected tableName and fields
  // Parameters
  // ----------------------------------------------------

Form:C1466.displayCols:=New collection:C1472
For each ($vo_field;Form:C1466.view.detail.cols)
	If ($vo_field.selected)
		Form:C1466.displayCols.push(OB Copy:C1225($vo_field))
	End if 
End for each 
