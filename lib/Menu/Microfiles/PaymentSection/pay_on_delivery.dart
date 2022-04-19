import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/utils/helper.dart';


import 'Constants/radiobutton.dart';

class PayonDelivery extends StatefulWidget {
  final child;
  PayonDelivery({Key? key, this.child}) : super(key: key);

  @override
  _PayonDeliveryState createState() => _PayonDeliveryState();
}

class _PayonDeliveryState extends State<PayonDelivery> {
  int value =2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: 100,
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
                  child: Text("Cash",style: TextStyle(fontWeight: FontWeight.w600,
                  color: Colors.grey),),
                ),
                subtitle: Text(
                  // "Pay cash at the time of delivery.We\n"
                  // "reccomended you use online payments for"
                  // "\ncontacless delivery",
                  "Cash on delivery is not available",
                  style: TextStyle(fontSize: 11,color: Colors.grey),
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: Card(
                      child: Image(
                          image: NetworkImage(
                              "https://static.vecteezy.com/system/resources/previews/003/718/271/non_2x/hand-with-money-free-vector.jpg"),
                        color: Colors.grey,
                        colorBlendMode: BlendMode.color,)),
                ),


             trailing: Radio<int>(
               value: 3,
               groupValue: value,
               onChanged: (newvalue) {
                final snackBar= SnackBar(
                   content: Text('Cash on delivery is not available'),
                 );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                 // setState(
                 //       () {
                 //     value = newvalue!;
                 //
                 //   },
                 // );
               },
               activeColor: Colors.green,
             ),

              ),
              // Container(child: ElevatedButton(onPressed: (){},child: Text("hao")),)
            ],
          ),
        ),
      ),
    );
  }
}
