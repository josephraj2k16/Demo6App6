import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:MediAssist/Models/account.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String accountTable ='account_table';
  String accountname='accountname';
  String password='password';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper==null)
    _databaseHelper=DatabaseHelper._createInstance();

    return _databaseHelper;
  }
  Future<Database> get database async{
    if(_database==null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    print("Initialized db");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'account.db';

    var accountsDatabase=await openDatabase(path,version: 1,onCreate: _createDB);
    print("Created DB");
    return accountsDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    print("Inside _createDB");
    await db.execute('CREATE TABLE IF NOT EXISTS $accountTable($accountname TEXT,$password TEXT)');
    print("Table Created");
  }
// get all
  Future<List<Map<String,dynamic>>>getAccountMapList() async {
    Database db = await this.database;

    var result = await db.query(accountTable);
    return result;

  }
  //Insert one
  Future<int> insertAccount(Account acc) async{

    Database db = await this.database;
     var result = await db.insert(accountTable,acc.toMap());
     return result;
  }
  //Delete one
  Future<int> deleteNote(String name) async {
    var db = await this.database;
    int result = await db.delete("$accountTable", where: "$accountname = ?", whereArgs: [name]);
    return result;
  }

  //Update One
  Future<int> updateAccount(Account acc) async{

    Database db = await this.database;
    var result = await db.update(accountTable,acc.toMap(),where: '$accountname = ?',whereArgs: [acc.accountame]);
    return result;
  }
  //get Login
  Future<Account> getLogin(String user, String pass) async {
    var dbClient = await this.database;
    var res = await dbClient.rawQuery("SELECT * FROM $accountTable WHERE $accountname = '$user' and $password = '$pass'");

    if (res.length > 0) {
      print("inside db helper getlogin: "+new Account.fromMapObject(res.first).toString());
      //return true;
      return new Account.fromMapObject(res.first);
    }
    return null;
  }

  Future<List<Account>> getAllAccounts() async {

    var accMapList = await getAccountMapList();
    int count = accMapList.length;

    List<Account> accountlist = List<Account>();

    for(int i=0;i<count;i++){
      accountlist.add(Account.fromMapObject(accMapList[i]));
    }

      return accountlist;
  }

  //delete Table
  Future<int> deleteDb() async {
    var dbClient = await this.database;
    int res = await dbClient.rawDelete("DELETE FROM $accountTable");
    return res;
  }


}