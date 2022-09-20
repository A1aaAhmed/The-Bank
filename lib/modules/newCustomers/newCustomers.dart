import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_sparks_apps/shared/components/components.dart';
import '../../layout/appbar/appbar.dart';
import '../../models/dataBaseHelper.dart';

class newCustomers extends StatefulWidget {


  @override
  State<newCustomers> createState() => _newCustomersState();
}


class _newCustomersState extends State<newCustomers> {
  static Database ?database;

  List<Map>db=[];



int() async{
  db=await DataBaseHelper().CheckInsert(database) ;
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int();


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Bar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  const [
                Icon(
                  CupertinoIcons.person_3_fill,
                  color: Colors.red,
                  size: 35,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.brown,
                    ),
                    child:Text("All Customers",),

                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: DataBaseHelper().CheckInsert(database),
              builder: (context,snapshot) {
              if ( db.isNotEmpty){
                print(db);
                return ListTable(list:db );
              }
              else {

                //print(db);
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange[300],),
                );
              }
              },

            ),
          ],
        ),
      ),
    );


  }

}


