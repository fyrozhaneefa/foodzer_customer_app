import 'package:flutter/material.dart';


import 'Constants/radiobutton.dart';

class PayonDelivery extends StatefulWidget {
  final child;
  PayonDelivery({Key? key, this.child}) : super(key: key);

  @override
  _PayonDeliveryState createState() => _PayonDeliveryState();
}

class _PayonDeliveryState extends State<PayonDelivery> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: size.height / 8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Cash",style: TextStyle(fontWeight: FontWeight.w600),),
                ),
                subtitle: Text(
                  "Pay cash at the time of delivery.We\n"
                  "reccomended you use online payments for"
                  "\ncontacless delivery",
                  style: TextStyle(fontSize: 11),
                ),
                leading: Container(
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: Card(
                      child: Image(
                          image: NetworkImage(
                              "https://static.vecteezy.com/system/resources/previews/003/718/271/non_2x/hand-with-money-free-vector.jpg"))),
                ),


             trailing: Padding(
               padding: const EdgeInsets.only(bottom:110),
               child: RadioSection(),
             ), ),
            ],
          ),
        ),
      ),
    );
  }
}
