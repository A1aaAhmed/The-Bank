import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_sparks_apps/modules/newCustomers/newCustomers.dart';

import '../../layout/appbar/appbar.dart';
import '../../models/dataBaseHelper.dart';

class OneCustomer extends StatefulWidget {
  final String name,Email;
  String Bal;


    OneCustomer({Key? key,required this.name,required this.Email,required this.Bal}) : super(key: key,);

  @override
  State<OneCustomer> createState() => _OneCustomerState();
}

class _OneCustomerState extends State<OneCustomer> {







  static Database ?database;




  int() async{

    database=await DataBaseHelper().CreatDataBase();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int();



  }

  final scaffoldKey=GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>formKey=GlobalKey<FormState>();
  double ?balance;
  String ?tempEmail;
  String ?tempName;
  String?tempBal;
  bool x=false;
  final transfer = TextEditingController();
  final transferTo = TextEditingController();
  var amountTransfer;
  bool validator (){

    if (formKey.currentState!= null && formKey.currentState!.validate()){
      Navigator.pop(context);
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Bar(),
      body:  SingleChildScrollView(
        child: Column(

          children: [
            const Padding(
              padding: EdgeInsets.only(left:10,top: 10,bottom: 20 ),
              child: Image(
                  height: 300,
                  width: 300,
                  image:AssetImage(

                    "assets/images/customers.png",
                  ) ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 20),
              child: Wrap(

                children: [
                  Row(

                    children: [
                      const Icon(
                  Icons.person,
                  color: Colors.blue,
                  size:40 ,

              ),
                      Text(widget.name,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,

                      ),),
                    ],
                  ),
                  Row(


                    children: [
                      const Icon(Icons.money,
                      color:Colors.green ,
                      size: 40,),
                      FutureBuilder(
                        future:newbalance(),
                          builder:(context,snapshot){
                            if ( snapshot.connectionState == ConnectionState.done && snapshot.hasData){

                              return Text(

                                '${snapshot.data.toString()}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),);
                            }
                            else {
                              return  Text(

                                widget.Bal,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),);
                            }
                          },

                      )
                      ]
                    ),
                  Row(


                      children: [
                        const Icon(Icons.alternate_email,
                          color:Colors.blue,
                          size: 40,),
                        Text(
                         widget.Email,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),),]
                  ),
                    ],
                  ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: MaterialButton(
                minWidth: 130,
                color: Colors.orange,
                child: const Text("Transfer",
                  style: TextStyle(color: Colors.white),),


                onPressed: (){
                  scaffoldKey.currentState?.showBottomSheet((context) =>Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[100],

                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const Text("who to transfer to ?"),
                            TextFormField(
                              controller: transferTo,
                              keyboardType: TextInputType.text,
                              validator: (String? value){
                                tempName=value;
                                if (value==null || value.trim().isEmpty ){
                                  return"please enter a value ";

                                }

                                return null;
                              },
                            ),
                            const Text("How much ?"),
                            TextFormField(
                              controller: transfer,
                              keyboardType: TextInputType.number,

                              validator: (String ?value){
                                if (value== null || value.isEmpty){
                                  return"please enter a value ";
                                }
                                amountTransfer= double.parse(value);
                                assert(amountTransfer is double);
                                balance=  double.parse(widget.Bal);
                                assert(balance is double);
                                if (amountTransfer > balance) {
                                  return 'out of range';}
                                return null;
                              },onFieldSubmitted: (value){
                                balance=double.parse(value);
                                assert(balance is double);
                            },
                            ),
                            IconButton(
                                onPressed:(){

                                setState(() {
                                 x = validator();


                                });
                                x?  newbalance():null;

                                  },

                                icon:const Icon(
                                    Icons.check_outlined,
                                    color: Colors.green,
                                    size: 40,)
    ),

                          ],

                        ),
                      ),
                    ),
                  )
                  );
                },


              ),
            ),
            MaterialButton(
              minWidth: 130,

              color: Colors.orange,
              child: const Text("All Customers",
                style: TextStyle(color: Colors.white),),


              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>newCustomers()));

              },


            ),

          ],
        ),
      ),

    );

  }
 Future<double>TransferMoney(balance,amountTransfer)async {
   amountTransfer= double.parse(transfer.text);
   assert(amountTransfer is double);
   balance=  double.parse(widget.Bal);
   assert(balance is double);

   balance =  balance- amountTransfer;





  String q= await DataBaseHelper().UpdateDataBase(balance.toString(), widget.name,transferTo.text);

            double b=  double.parse(q);
           assert(b is double);
           await DataBaseHelper().UpdateDataBase((amountTransfer+b).toString(),transferTo.text,'');

         return balance;




 }



newbalance()async{

 return await TransferMoney(balance,transfer.text);
}
}

