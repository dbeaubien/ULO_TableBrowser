//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/03/20, 11:58:27
  // ----------------------------------------------------
  // Method: ULO_VIEW_CUSTOM_COL
  // Description
  // Puts given data into Form.customColumns for use
  // by View edit screen.
  // Parameters
  // $1 - String  - Name
  // $2 - String  - Method
  // $3 - Collection  - Parameters, in string form
  // $4 - Longint     - Data Type
  // $5 - String  - Header
  // $6 - String  - Display Format (optional)
  // $7 - Object  - Allowed Aggregates - { sum: bool, avg: bool, min: bool, max: bool } (Optional, defaults to all false)
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$5;$6;$vt_param)
C_COLLECTION:C1488($3)
C_LONGINT:C283($4)

C_OBJECT:C1216($vo_col)

If (UTIL_Col_Find_Index (Form:C1466.customColumns;"name";$1)=-1)
	$vo_col:=New object:C1471
	$vo_col.name:=$1
	$vo_col.method:=$2
	$vo_col.formula:=$2+"(vo_colObj"
	$vo_col.sortFormula:=$2+"(vo_sortObj"
	$vo_col.footerFormula:=$2+"(vo_footerObj"
	For each ($vt_param;$3)
		$vo_col.formula:=$vo_col.formula+";"+$vt_param
		$vo_col.sortFormula:=$vo_col.sortFormula+";"+$vt_param
		$vo_col.footerFormula:=$vo_col.footerFormula+";"+$vt_param
	End for each 
	$vo_col.formula:=$vo_col.formula+")"
	$vo_col.sortFormula:=$vo_col.sortFormula+")"
	$vo_col.footerFormula:=$vo_col.footerFormula+")"
	
	$vo_col.dataType:=$4
	$vo_col.header:=$5
	If (Count parameters:C259>5)
		$vo_col.format:=$6
	Else 
		$vo_col.format:=""
	End if 
	If (Count parameters:C259>6)
		$vo_col.aggregates:=OB Copy:C1225($7)
	Else 
		$vo_col.aggregates:=New object:C1471("sum";False:C215;"avg";False:C215;"min";False:C215;"max";False:C215)
	End if 
	Form:C1466.customColumns.push(OB Copy:C1225($vo_col))
End if 
