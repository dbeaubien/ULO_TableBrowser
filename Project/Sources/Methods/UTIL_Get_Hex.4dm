//%attributes = {}
  //PROJECT METHOD:           BRW_Get_Hex
  //MODULE::                  BRW
  //REQUIRED:                 CORE
  //COMPILER:                 COMPILER_BRW
  //CREATED:                  31/03/12, 00:25:08 / Mehdi Shariatzadeh
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //DESCRIPTION:
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //CHANGES:
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //© Halare and Telekinetix 2008 - 2011
  //For example and details see Comments in the 4D Explorer
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  // Modified by: Tom (17/01/2020)
  // Removed dependancy on CORE


  // DECLARE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
C_LONGINT:C283($1)
C_TEXT:C284($0)
C_LONGINT:C283($vl_num;$vl_Number1;$vl_Number2;$vl_Number3;$vl_Number4;$vl_Number5;$vl_Number6)
C_TEXT:C284($vt_Text;$vt_Chars)

  //INIT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$vl_num:=$1

  //METHOD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$vt_Chars:="0123456789ABCDEF"

$vl_Number6:=((Num:C11($vl_num ?? 3))*8)+((Num:C11($vl_num ?? 2))*4)+((Num:C11($vl_num ?? 1))*2)+((Num:C11($vl_num ?? 0))*1)+1
$vl_Number5:=((Num:C11($vl_num ?? 7))*8)+((Num:C11($vl_num ?? 6))*4)+((Num:C11($vl_num ?? 5))*2)+((Num:C11($vl_num ?? 4))*1)+1
$vl_Number4:=((Num:C11($vl_num ?? 11))*8)+((Num:C11($vl_num ?? 10))*4)+((Num:C11($vl_num ?? 9))*2)+((Num:C11($vl_num ?? 8))*1)+1
$vl_Number3:=((Num:C11($vl_num ?? 15))*8)+((Num:C11($vl_num ?? 14))*4)+((Num:C11($vl_num ?? 13))*2)+((Num:C11($vl_num ?? 12))*1)+1
$vl_Number2:=((Num:C11($vl_num ?? 19))*8)+((Num:C11($vl_num ?? 18))*4)+((Num:C11($vl_num ?? 17))*2)+((Num:C11($vl_num ?? 16))*1)+1
$vl_Number1:=((Num:C11($vl_num ?? 23))*8)+((Num:C11($vl_num ?? 22))*4)+((Num:C11($vl_num ?? 21))*2)+((Num:C11($vl_num ?? 20))*1)+1

$vt_Text:=$vt_Chars[[$vl_Number1]]+$vt_Chars[[$vl_Number2]]+$vt_Chars[[$vl_Number3]]+$vt_Chars[[$vl_Number4]]+$vt_Chars[[$vl_Number5]]+$vt_Chars[[$vl_Number6]]

$0:=$vt_Text
