//%attributes = {}

  // Setting a boolean on all view columns to stop 4D's wierdness where the 
  // value defaults to longint unless the property is defined for check boxes. 
C_OBJECT:C1216($es_ulo;$e_ulo;$vo_col)

$es_ulo:=ds:C1482.uloData.query("type == 2")

For each ($e_ulo;$es_ulo)
	For each ($vo_col;$e_ulo.detail.cols)
		$vo_col.fontColourOverride:=False:C215
	End for each 
	$e_ulo.detail:=$e_ulo.detail
	$e_ulo.save()
End for each 
