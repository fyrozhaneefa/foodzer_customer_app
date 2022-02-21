import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/images.dart';


class HeaderContainer extends StatelessWidget {
  const HeaderContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Container(
    height: height / 8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListTile(leading: Image(image: AssetImage(bank)),title: Text("Hotel Sarover",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
      subtitle: Text("Home ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black)),),
    );

  }
}
