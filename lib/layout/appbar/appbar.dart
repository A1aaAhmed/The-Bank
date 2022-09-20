import 'package:flutter/material.dart';

import '../homeScreen/homepage.dart';

class Bar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<Bar> createState() => _BarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _BarState extends State<Bar> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,


        leading:IconButton(
          icon:const Icon(
            Icons.monetization_on_outlined,
            color: Colors.orange,
            size: 40,
          ) ,
          onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder:(contex)=>HomePage()));
            });
          },
        ),

        title: const Text("The Bank",
          style: TextStyle(
            color: Colors.orange,

            fontSize: 25


          ),
        ),

        // ignore: prefer_const_literals_to_create_immutables

      ),
      //floatingActionButton:FloatingActionButton(
      //onPressed: (){

      //},
      //child: const Icon(
      //Icons.add,
      //),
      //) ,


    );
  }
}
