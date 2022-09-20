import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../layout/appbar/appbar.dart';
import '../../models/insertIntoDataBase.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class DataBaseHelper{
   int? check;
   String ?databaspath ;
   String? path ;
   var toAmount;
   List<Customers>customers=[
     Customers('Ahmed','ahmed@gmail.com','1070'),
     Customers('Alaa','alaa@gmail.com','1130'),
     Customers('Fares','faries@gmail.com','1050'),
     Customers('Nour','nour@gmail.com','8827'),
     Customers('Aya','aya@gmail.com','1116'),
     Customers('Gana','gana@gmail.com','1050'),
     Customers('Maha','maha@gmail.com','1057'),
     Customers('Rana','rana@gmail.com','1100'),
     Customers('Nada','nada@gmail.com','1950'),
     Customers('Eman','eman@gmail.com','1050'),
   ];
   List<Map>db=[];
   List<Map>tr=[];


  Future<Database> CreatDataBase()async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, 'banck.db');
   // await deleteDatabase(path!);
    Database database=await openDatabase(
        path!,
        version: 1,//change it when change
        onCreate: (database,version)async{
          await database.execute('CREATE TABLE Customers (id INTEGER PRIMARY KEY, name TEXT, email TEXT,balance TEXT)');
        },


        onOpen: (database)async{
          check = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Customers'));


        },
 
    );
    return database;
  }
  Future<Database>InsertData(database) async{

    await database!.transaction((txn) async {

      for (var i = 0; i < customers.length; i++){

        await txn.rawInsert('INSERT INTO Customers(name, email, balance) VALUES(?, ?, ?)',[customers[i].name,customers[i].email, customers[i].balance]);

      }

    }).catchError((error){print(" ${error}");});


    return database!;
  }









  Future <List<Map>>GetDataBase(database,String _in,)async{
    List<Map> list;
    if (_in =='*'){
      list = await database.rawQuery('SELECT * FROM Customers');
    }
    else{
     list = await database.rawQuery('SELECT balance FROM Customers WHERE name = ?',[_in]);
    }
    return  await list;
  }
  Future<List<Map>>CheckInsert(_database)async{
    _database??
       await CreatDataBase().then((value1)async{
        (check== 0)?await InsertData(value1).then((value2)async{
          await GetDataBase(value2,'*').then((value3){
            db=value3;
          });}):await GetDataBase(value1,'*').then((value){
          db=value;

        });
      });

    return db;

  }
 Future<String>UpdateDataBase(balance,name,to,)async {
   String ss = '';
   if (to != '') {
     await CreatDataBase().then((value1) async {
       await GetDataBase(value1, to).then((value2) async {
         ss = value2[0]['balance'];
         await value1.rawUpdate(

             'UPDATE Customers SET balance = ? WHERE name = ? ',
             [balance, name]);
       });
     });
   }

   else {
     await CreatDataBase().then((value1) async {
       await value1.rawUpdate(

           'UPDATE Customers SET balance = ? WHERE name = ? ',
           [balance, name]);
     });
   }


   return ss;
 }



  }



