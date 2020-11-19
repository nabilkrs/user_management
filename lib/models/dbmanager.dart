import 'package:crudapp/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DBManager{
static final DBManager dbmgr = DBManager.internal();
factory DBManager()=>dbmgr;
DBManager.internal();
static Database db;

createDatabase()async{
if(db!=null)
{
  return db;
}
String path = join(await getDatabasesPath(),'users.db');
db = await openDatabase(path,version:1,onCreate: (Database _db,int v){
_db.execute("CREATE TABLE user (id integer primary key autoincrement,name varchar(20),email varchar(50),phone varchar(15))");



});
return db;
}
Future<int> adduser(User user)async{
Database db = await createDatabase();
return db.insert('user', user.toMap());


}

Future<List> allusers()async{
Database db = await createDatabase();
return db.query('user');

}
Future<int> deleteuser (int i)async{
Database db = await createDatabase();
return db.delete('user',where:'id = ?',whereArgs: [i]);



}
Future<int> updateuser(User user)async{
Database db = await createDatabase();
return db.update('user', user.toMap(),where: 'id = ?',whereArgs: [user.id]);

 
}

Future<int> query() {
    return Future.value(1);
  }
}


