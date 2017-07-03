package utils
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.filesystem.File;

	public class DBHandler
	{
		private var SEL_STR:String = "SELECT * FROM teacherNumberInfo";
		private var INST_STR:String = "INSERT INTO teacherNumberInfo(tName, tPhone, tPrimeNum, tPrivateNum)" + 
			" VALUES(:tName, :tPhone, :tPrimeNum, :tPrivateNum)";
		private var DEL_STR:String="delete from teacherNumberInfo";
		private var myArray:Array=new Array();
		private var conn:SQLConnection;
		private var stmt:SQLStatement;
		public function DBHandler()
		{
			this.connConnect();
		}
		private function connConnect():void {
			conn=new SQLConnection();
			conn.open(File.desktopDirectory.resolvePath("teacherNumberInfo"));
			stmt = new SQLStatement();
			stmt.sqlConnection = conn;
			stmt.text = "CREATE TABLE IF NOT EXISTS teacherNumberInfo (id INTEGER PRIMARY KEY AUTOINCREMENT, tName VARCHAR(20), tPhone VARCHAR(20), tPrimeNum VARCHAR(20), tPrivateNum varchar(20))";
			stmt.execute();
		}
		public function insertMember(tName:String, tPhone:String, tPrimeNum:String,
									 tPrivateNum:String):void{
			stmt.text = INST_STR;
			stmt.parameters[":tName"]=tName;
			stmt.parameters[":tPhone"] = tPhone;
			stmt.parameters[":tPrimeNum"] = tPrimeNum;
			stmt.parameters[":tPrivateNum"] = tPrivateNum;
			stmt.execute();
			stmt.clearParameters();
		}
		public function selAllMember():Array{
			stmt.text = SEL_STR;
			stmt.execute();
			myArray = stmt.getResult().data;
			return myArray;
		}	
		public function delAllData():void {
			stmt.text = this.DEL_STR;
			stmt.execute();
		}
//		public function searchDataHandler(tName:String):Array {
//			var str:String = "SELECT * FROM teacherNumberInfo where tName like '%tName%'";
//			stmt.text = str;
////			stmt.parameters[":tName"]=tName;
//			stmt.execute();
//			myArray = stmt.getResult().data;
//			return myArray;
//		}
	}
}