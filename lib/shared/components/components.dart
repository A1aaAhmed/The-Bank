import 'package:flutter/material.dart';
import 'package:the_sparks_apps/modules/oneCustomer/oneCustomer.dart';
Widget ImageCard({
  required String text,
  required String img,
  Function ? navigat,


})=>InkWell(

onTap: (){
  navigat!();
},
splashColor: Colors.cyan,

borderRadius: BorderRadius.circular(10),
child: Ink.image(
  width:200,
  height: 200,

  padding: EdgeInsetsDirectional.all(10),
  image:AssetImage(img),
  child: Container(
    alignment: Alignment.bottomCenter,
    child: Text(
        text,
        style:const TextStyle(
          fontSize: 15,
          color: Colors.blue,



    ),
    ),
  ),

),

);
Widget ListTable(
{

  required List<Map> list,


}
    )=>ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      itemBuilder:(context,index){

        return ListTile(
          contentPadding: EdgeInsets.only(left: 5,right: 5,top:5),
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => OneCustomer(

                name:list[index]['name'],
                Email:list[index]['email'],
                Bal:list[index]['balance'])));
                // OneCustomer(name:list[1]['name'],
                // String
                // ,list[1]['name'].toString()),list[1]['name'].toString())));
          },
          hoverColor: Colors.grey[100],
          leading: CircleAvatar(
            backgroundColor: Colors.amber[100],
            child: Text((index+1).toString(),
              style: const TextStyle(
                  color: Colors.brown,
              ),),
          ),//number
          title:Text(list[index]['name']),
          subtitle:Text( list[index]['email']),
          trailing: Text(list[index]['balance']),


        );
      },
      itemCount: list.length,

    );
