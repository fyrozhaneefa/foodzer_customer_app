import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/pay_on_delivery.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/recommented_payment.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/upi.dart';
import 'Constants/sizedbox.dart';
import 'appbarwidget.dart';
import 'credit_and_debit.dart';
import 'header.dart';
import 'more_payment_options.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.white,actions: [
        
        Expanded(child: AppBarWidget())
        
      ],
      elevation: 1,),
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
