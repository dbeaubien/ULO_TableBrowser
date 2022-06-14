//%attributes = {}
C_TEXT:C284($1; $2)
C_VARIANT:C1683($0)
Case of 
	: ($1="ICON")
		Case of 
			: ($2="New Record")
				$0:="add.png"
			: ($2="Modify Record")
				$0:="edit.png"
			: ($2="Delete Record")
				$0:="delete.png"
			: ($2="Show All")
				$0:="showall.png"
			: ($2="Show Subset")
				$0:="showsubset.png"
			: ($2="Omit Subset")
				$0:="omitsubset.png"
			: ($2="Query")
				$0:="search.png"
			: ($2="Order By")
				$0:="sort.png"
			: ($2="Report")
				$0:="report.png"
			: ($2="Print Selection")
				$0:="print.png"
			: ($2="Tools")
				$0:="tools.png"
			: ($2="Action")
				$0:="action.png"
			: ($2="Find")
				$0:=""
			: ($2="Views")
				$0:="views.png"
			: ($2="Space")
				$0:=""
				
		End case 
		
	: ($1="COLOUR")
		$0:=0x00E5F2F7  //Could be replaced by Storage.buttonColour
		
	: ($1="FONTCOLOUR")
		$0:=0x7BAD  //Could be replaced by Storage.buttonFontColour
		
	: ($1="METHOD")
		$0:="HOST_ULO_BUTTON_METHOD"  //Could be replaced by Storage.buttonMethod
		
End case 