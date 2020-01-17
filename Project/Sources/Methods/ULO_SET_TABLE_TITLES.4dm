//%attributes = {"shared":true}
ARRAY TEXT:C222($at_tableName;0)
ARRAY LONGINT:C221($al_tableNum;0)
GET TABLE TITLES:C803($at_tableName;$al_tableNum)  //Not threadsafe
Use (Storage:C1525)
	Storage:C1525.tableTitles:=New shared collection:C1527
	Use (Storage:C1525.tableTitles)
		ARRAY TO COLLECTION:C1563(Storage:C1525.tableTitles;$at_tableName;"name"\
			;$al_tableNum;"id")
	End use 
End use 

