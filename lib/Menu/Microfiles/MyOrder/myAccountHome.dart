import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/divider.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrder/myoders.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY ORDER",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      leading: InkWell(child: Icon(Icons.keyboard_backspace_outlined),onTap: (){

        Navigator.pop(context);
      },)),
      body: ListView(children: [

        MyOrders(),
        MyOrders(),
        MyOrders(),
        MyOrders(),
        MyOrders(),
        MyOrders(),

      ]
      ),
    );
  }
}
