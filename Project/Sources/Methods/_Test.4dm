//%attributes = {}
$vl_err:=0
EXECUTE METHOD:C1007("ULO_SET_SIDEBAR_ITEM";$vl_err;"INIT")
EXECUTE METHOD:C1007("ULO_SET_SIDEBAR_ITEM";$vl_err;"HEADER";"Group 1";"HEADER1";"";Bold:K14:2)
EXECUTE METHOD:C1007("ULO_SET_SIDEBAR_ITEM";$vl_err;"DATA";"Member";"MEMBER";"";Plain:K14:1;Table:C252(->[test:1]);"HEADER1";$vc_findFields;$vc_actionMethods)
EXECUTE METHOD:C1007("ULO_SET_SIDEBAR_ITEM";$vl_err;"HEADER";"Group 2";"HEADER2";"";Bold:K14:2)
EXECUTE METHOD:C1007("ULO_SET_SIDEBAR_ITEM";$vl_err;"DATA";"JT Form";"JTFORM";"";Plain:K14:1;Table:C252(->[test:1]);"HEADER2";$vc_findFields;$vc_actionMethods)
EXECUTE METHOD:C1007("ULO_SET_SIDEBAR_ITEM";$vl_err;"DATA";"Profile";"PROFILE";"";Plain:K14:1;Table:C252(->[test:1]);"JTFORM";$vc_findFields;$vc_actionMethods)
