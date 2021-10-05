C_LONGINT:C283($vl_row;$i)
C_TEXT:C284($vt_rowExtension;$vt_rowToHide)

If (FORM Event:C1606.code=On Clicked:K2:4)
	If (Form:C1466.parent.lastQuery.length>1)
		$vl_row:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
		$vt_rowExtension:=String:C10($vl_row;"0000")
		$vt_rowToHide:=String:C10(Form:C1466.parent.lastQuery.length-1;"0000")
		
		OBJECT SET VISIBLE:C603(*;"ql_@"+$vt_rowToHide;False:C215)
		
		Form:C1466.parent.lastQuery.remove($vl_row)
		Form:C1466.parent.lastQuery[Form:C1466.parent.lastQuery.length-1].conjunction:=""  //clear conjunction on 'new' last row
		If ($vl_row=0)
			$vl_row:=1
		End if 
		For ($i;$vl_row-1;Form:C1466.parent.lastQuery.length-1)
			QE_FILL_LINE_DATA (Form:C1466.parent.lastQuery[$i];String:C10($i;"0000"))
		End for 
		
	Else 
		ALERT:C41("Cannot delete the last query line")
	End if 
End if 
