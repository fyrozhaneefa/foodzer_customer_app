import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/payment_home.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class AddNewCard extends StatelessWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        backgroundColor: Colors.white,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Add New Card",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text("1 item . Total: ₹125",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ))
        ]),
        leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
      ),
      body:SingleChildScrollView(child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text("Card Number"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 30),
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Valid Through (MM/YY)"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("CVV"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text("Name on Card"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text("Card Nickname (for easy indentification"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20,top: 20),
            child: Container(width: Helper.getScreenWidth(context),height: 55,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent..shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
