// ignore_for_file: prefer_const_constructors


import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../appbar/appbar.dart';
import '../../shared/components/components.dart';
import '../../modules/newCustomers/newCustomers.dart';




//emulator -list-avds
//emulator @NameOfAvd
// alt + enter mix the icon in icon button

class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: Bar(),
    body: SingleChildScrollView(
      child: Column(
        children: [
          const Image(
            height: 300,
              width: 300,
              image:AssetImage(

                "assets/images/home_page3.png",
              ) ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.monetization_on_outlined,
                color: Colors.orange,
                size: 40,
              ),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.orange,
                ),
                child:Text("The Bank",),

              ),//the bank
            ],
          ),

          DefaultTextStyle(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black
            ),
            child: AnimatedTextKit(
              repeatForever: false,
              totalRepeatCount: 1,
              animatedTexts: [
                TypewriterAnimatedText(
                  "A Safe Place For Your Money To Grow",
                  textAlign: TextAlign.center,
                  curve: Curves.easeIn,
                  speed:Duration(milliseconds:80,),
                ),


              ],

            ),
          ),//a safe place......
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ImageCard(
                    text:"All Customers",
                    img: "assets/images/all_customers_card.png",
                    navigat: (){
                      Navigator.push(context, MaterialPageRoute(builder:(contex)=>newCustomers()));
                    }
                ),//all customer

                ImageCard(
                    text:"Customers Services",
                    img: "assets/images/customers2.png"
                ),//customers services
                ImageCard(
                    text:"About Us",
                    img: "assets/images/contact_us.png"
                ),//all customer//about us
              ],


            ),
          )

        ],
      ),
    ),
    );
  }
}
