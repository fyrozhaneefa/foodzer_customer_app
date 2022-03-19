import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/pay_on_delivery.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/recommented_payment.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/upi.dart';
import 'Constants/sizedbox.dart';

import 'credit_and_debit.dart';
import 'header.dart';
import 'more_payment_options.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: InkWell(child:Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.black.withOpacity(.5),
            size: 30,
          ),
          onTap: (){
            Navigator.pop(context);
          },),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Option",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    "1 item ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    ".",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "Total:₹212",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.white,
          actions: [],
          elevation: .5,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              HeaderContainer(),
              SizedWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Pay on Delivery ",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              PayonDelivery(),
              SizedWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Credit & Debit cards ",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              CreditDebit(),
              SizedWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "UPI",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              UpiSection(),
              SizedWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "More Payment Options",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              MorePayment(),
              SizedWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Recommended Payments",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              RecommededPayments(),
            ],
          ),
        ),
        backgroundColor: Colors.blueGrey[50]);
  }
}
