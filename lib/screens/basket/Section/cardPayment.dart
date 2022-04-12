import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/utils/paymentUtils.dart';
import 'package:http/http.dart' as http;

import '../../../utils/helper.dart';



class PaymentCardDetailsScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _PaymentCardDetailsScreenState();
  }
}

class _PaymentCardDetailsScreenState extends State<PaymentCardDetailsScreen> {

  TextEditingController cardNoController=new TextEditingController();
  TextEditingController validThroughController=new TextEditingController();
  TextEditingController cvvController=new TextEditingController();
  TextEditingController holderNameController=new TextEditingController();
  FocusNode? cardNumberFocus, cardNameFocus, expiryFocus, cvvFocus;

  String clientSecret="";
  String? cardNumber;
  String? cardHolderName;
  int? month;
  int? year;
  String? cvv;
  CardType? cardtype;
  String? _error;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();




  @override
  void initState() {
    cardNumberFocus = FocusNode();
    cardNameFocus = FocusNode();
    expiryFocus = FocusNode();
    cvvFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: .5,
          backgroundColor: Colors.white,
          title:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Add New Card",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("Card Number"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.grey, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: .5),
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
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: .5),
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
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.grey, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.grey, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  width: Helper.getScreenWidth(context),
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Proceed to Pay",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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



  // void setError(var error) {
  //
  //   EasyLoading.showError(error.message);
  //
  // }
  // String? validateMonthAndYear(String? value) {
  //   {
  //     //print('Updated $value');
  //     List<String> monthAndYear = value!.split("/");
  //     // if (monthAndYear.length > 1){
  //     if (value.length > 0) {
  //       // if (!isNumeric(monthAndYear[0])) {
  //       //   return "Month must be in digit";
  //       // }
  //       int monthValue = int.parse(monthAndYear[0]);
  //       if (monthValue > 12) {
  //         return "Invalid Month";
  //       }
  //       if (monthAndYear.length > 1) {
  //
  //         String value = monthAndYear[1];
  //         if (value.length > 0) {
  //           int yearValue = int.parse(monthAndYear[1]);
  //           Future.delayed(
  //               Duration.zero,
  //                   () => setState(() {
  //                 month = monthValue;
  //                 year = yearValue;
  //               }));
  //           var now = new DateTime.now();
  //           if (yearValue < now.year) {
  //             return "Invalid Year";
  //           }
  //           // print(yearValue);
  //
  //         }
  //       }
  //     }
  //   }
  //   return null;
  // }

}