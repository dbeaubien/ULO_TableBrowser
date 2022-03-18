//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 12/02/20, 12:51:16
  // ----------------------------------------------------
  // Method: UTIL_Open_Window_Centre
  // Description
  // Opens window using form's size settings and optional 
  // window type
  // Parameters
  // $0 - Longint - Window ID
  // $1 - String  - Form name
  // $2 - Longint - Window Type
  // ----------------------------------------------------

C_LONGINT:C283($0;$2;$vl_w;$vl_h;$vl_l;$vl_r;$vl_t;$vl_b;$cp)
C_TEXT:C284($1;$3)
$cp:=Count parameters:C259
FORM GET PROPERTIES:C674($1;$vl_w;$vl_h)
$vl_l:=(Screen width:C187/2)-($vl_w/2)
$vl_t:=(Screen height:C188/2)-($vl_h/2)
$vl_r:=$vl_l+$vl_w
$vl_b:=$vl_t+$vl_h

If ($cp>1)
	$0:=Open window:C153($vl_l;$vl_t;$vl_r;$vl_b;$2)
Else 
	$0:=Open window:C153($vl_l;$vl_t;$vl_r;$vl_b)
End if 
If ($cp>2)
	SET WINDOW TITLE:C213($3;$0)
End if 