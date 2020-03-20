//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 20/03/20, 08:32:49
  // ----------------------------------------------------
  // Method: ULO_IMPORT_DATA
  // Description
  // Imports selected JSON files as [uloData] records
  //
  // Parameters
  // $0 - Collection - Collection of newly created [uloData]id
  // ----------------------------------------------------

C_COLLECTION:C1488($0;$vc_uloDataId;$e_uloData)

C_TEXT:C284($vt_file;$vt_json)
C_OBJECT:C1216($vo_data;$vo_res)
C_LONGINT:C283($i;$j)
C_BOOLEAN:C305($vb_continue)

ARRAY TEXT:C222($at_files;0)

ARRAY TEXT:C222($at_requiredProps;0)
APPEND TO ARRAY:C911($at_requiredProps;"name")
APPEND TO ARRAY:C911($at_requiredProps;"handle")
APPEND TO ARRAY:C911($at_requiredProps;"table")
APPEND TO ARRAY:C911($at_requiredProps;"type")
APPEND TO ARRAY:C911($at_requiredProps;"default")
APPEND TO ARRAY:C911($at_requiredProps;"user")
APPEND TO ARRAY:C911($at_requiredProps;"detail")

$vc_uloDataId:=New collection:C1472

$vt_file:=Select document:C905("";"json";"Data to Import...";Multiple files:K24:7;$at_files)
If (OK=1)
	If (Size of array:C274($at_files)>0)
		For ($i;1;Size of array:C274($at_files))
			$vt_json:=Document to text:C1236($at_files{$i})
			$vo_data:=JSON Parse:C1218($vt_json)
			
			$vb_continue:=True:C214
			
			For ($j;1;Size of array:C274($at_requiredProps))
				If (Not:C34(OB Is defined:C1231($vo_data;$at_requiredProps{$j})))
					$vb_continue:=False:C215
				End if 
			End for 
			
			If ($vb_continue)
				$e_uloData:=ds:C1482["uloData"].new()
				$e_uloData.name:=$vo_data.name
				$e_uloData.handle:=$vo_data.handle
				$e_uloData.table:=$vo_data.table
				$e_uloData.type:=$vo_data.type
				$e_uloData.default:=$vo_data.default
				$e_uloData.user:=$vo_data.user
				$e_uloData.detail:=OB Copy:C1225($vo_data.detail)
				$vo_res:=$e_uloData.save()
				If ($vo_res.success)
					$vc_uloDataId.push($e_uloData.id)
				End if 
			End if 
		End for 
	End if 
End if 
$0:=$vc_uloDataId
