//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 19/03/20, 15:30:37
  // ----------------------------------------------------
  // Method: ULO_EXPORT_DATA
  // Description
  // Exports given entity selection of ULO Data records
  //
  // Parameters
  // $1 - Entity Selection - [uloData] records to export
  // ----------------------------------------------------

C_OBJECT:C1216($1;$es_uloData)
C_TEXT:C284($vt_filepath;$vt_json;$vt_filename)

$es_uloData:=$1

$vt_filepath:=Select folder:C670("Please select the folder to export files to")
If (OK=1)
	If (Test path name:C476($vt_filepath)=Is a folder:K24:2)
		For each ($e_uloData;$es_uloData)
			$vt_filename:=String:C10($e_uloData.id)+"_"+$e_uloData.name+".json"
			
			$vo_export:=New object:C1471
			$vo_export.name:=$e_uloData.name
			$vo_export.handle:=$e_uloData.handle
			$vo_export.table:=$e_uloData.table
			$vo_export.type:=$e_uloData.type
			$vo_export.default:=$e_uloData.default
			$vo_export.user:=$e_uloData.user
			$vo_export.detail:=OB Copy:C1225($e_uloData.detail;*)
			
			$vt_json:=JSON Stringify:C1217($vo_export)
			
			TEXT TO DOCUMENT:C1237($vt_filepath+$vt_filename;$vt_json)
		End for each 
		SHOW ON DISK:C922($vt_filepath)
	End if 
End if 
