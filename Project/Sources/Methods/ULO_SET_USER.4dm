//%attributes = {"shared":true,"preemptive":"capable"}
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_OBJECT:C1216($e_uloData; $vo_defaultPrefs)

Use (Storage:C1525)
	If (Not:C34(OB Is defined:C1231(Storage:C1525; "user")))
		Storage:C1525.user:=New shared object:C1526
	End if 
	Use (Storage:C1525.user)
		Storage:C1525.user.id:=$1
		Storage:C1525.user.name:=$2
	End use 
	
	//$e_uloData:=ds["uloData"].query("user == :1 && type == 20";Storage.user.id).first()
	//If ($e_uloData#Null)
	//  //TODO: Update obj to storage to allow setting obj deeper into Storage 🤦‍ 
	//UTIL_OBJ_TO_STORAGE ("userPrefs";$e_uloData.detail)
	
	//Else 
	//$vo_defaultPrefs:=New object
	//$vo_defaultPrefs.persistentSorting:=False
	//$vo_defaultPrefs.saveHeaderSort:=False
	
	//UTIL_OBJ_TO_STORAGE ("userPrefs";$vo_defaultPrefs)
	
	//$e_uloData:=ds["uloData"].new()
	//$e_uloData.type:=20
	//$e_uloData.user:=Storage.user.id
	//$e_uloData.detail:=OB Copy($vo_defaultPrefs)
	//$e_uloData.save()
	//End if 
	
End use 