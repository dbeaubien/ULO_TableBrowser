//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 01/12/20, 15:19:39
  // ----------------------------------------------------
  // Method: QE_BUILD_LOAD_MENU
  // Description
  // Builds Menu of loadable Queries for given handle
  //
  // Parameters
  // $0 - String - Created Menu
  // $1 - String - Table Handle
  // ----------------------------------------------------

C_TEXT:C284($0;$vt_menu)
C_LONGINT:C283($1;$vl_tableNum)

C_TEXT:C284($vt_userMenu;$vt_publicMenu)
C_OBJECT:C1216($es_userQuery;$es_publicQuery)

$vl_tableNum:=$1

$es_userQuery:=ds:C1482["uloData"].query("table == :1 && user == :2 && type == 5";$vl_tableNum;Storage:C1525.user.id)

$es_publicQuery:=ds:C1482["uloData"].query("table == :1 && user != :2 && type == 5 && detail.public == :3";$vl_tableNum;Storage:C1525.user.id;True:C214)

$vt_userMenu:=Create menu:C408

If ($es_userQuery.length=0)
	APPEND MENU ITEM:C411($vt_userMenu;"None Available")
	SET MENU ITEM PARAMETER:C1004($vt_userMenu;-1;"n/a")
	DISABLE MENU ITEM:C150($vt_userMenu;-1)
Else 
	For each ($e_userQuery;$es_userQuery)
		APPEND MENU ITEM:C411($vt_userMenu;$e_userQuery.name;"";0;*)
		SET MENU ITEM PARAMETER:C1004($vt_userMenu;-1;$e_userQuery.id)
	End for each 
End if 

$vt_publicMenu:=Create menu:C408

If ($es_publicQuery.length=0)
	APPEND MENU ITEM:C411($vt_publicMenu;"None Available")
	SET MENU ITEM PARAMETER:C1004($vt_publicMenu;-1;"n/a")
	DISABLE MENU ITEM:C150($vt_publicMenu;-1)
Else 
	For each ($e_publicQuery;$es_publicQuery)
		APPEND MENU ITEM:C411($vt_publicMenu;$e_publicQuery.name;"";0;*)
		SET MENU ITEM PARAMETER:C1004($vt_publicMenu;-1;$e_publicQuery.id)
	End for each 
End if 

$vt_menu:=Create menu:C408

APPEND MENU ITEM:C411($vt_menu;"Your Queries";$vt_userMenu)
APPEND MENU ITEM:C411($vt_menu;"Public Queries";$vt_publicMenu)

$0:=$vt_menu
