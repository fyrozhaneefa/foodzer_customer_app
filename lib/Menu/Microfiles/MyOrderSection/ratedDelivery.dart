import 'package:flutter/material.dart';

class RateDelivery extends StatelessWidget {
  const RateDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
            "RATE DELIVERY",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.black, width: 1.5),
            fixedSize: Size(160, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Your Food Rating",
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
       Row(children: [
         Padding(
           padding: EdgeInsets.only(top: 10),
           child: Icon(
             Icons.star_outlined,
             size: 15,
             color: Colors.orangeAccent.shade700,
           ),
         ),
         Padding(
           padding: EdgeInsets.only(top: 12,left: 3),
           child: Text(
             "5   |  Loved it",
             style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w600,),
           ),
         ),


       ],)

      ],
    );
  }
}
