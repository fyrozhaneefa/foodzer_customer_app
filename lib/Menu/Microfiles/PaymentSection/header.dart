import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/Swidth.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/images.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sizedbox.dart';


class HeaderContainer extends StatelessWidget {
  const HeaderContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height:100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          ListTile(leading: Container(child: Image(image: AssetImage(Track))),title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text("Hotel Sarover",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          ),
          subtitle: Text("Home ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
          ),
          ),
          Row(children: [
            SizedWidth(),
            Text("Delivery in:", style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500),),
            Text("25 mins", style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),)
          ],)
        ],
      ),


      );

  }
}
