import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
// import 'package:foodzer_customer_app/Menu/Microfiles/paymentkey.dart';
import 'package:http/http.dart' as http;

class CreditDebit extends StatefulWidget {
  const CreditDebit({Key? key}) : super(key: key);

  @override
  State<CreditDebit> createState() => _CreditDebitState();
}

class _CreditDebitState extends State<CreditDebit> {

  var response ="";
  var didReceiveResponse =false;

  responseReceived (){

    setState(() {


      this.didReceiveResponse = true;
    });
  }
  buttonClick(){
    Map<String,String > inputParams ={

      "orderId" :"Order111",
      "orderAmount" : "1",
      "appId" :"7051d9675fae9ae886f9de1b1507",
      "message":"Token ganerate",
      "orderCurrency":"INR",
      "customerName":"jithin",
      "customerPhone":"9807654321",
      "customerEmail":"jithin@gmail.com",
      "stage":"TEST",
      "tokenData":"699JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.C90nIlN2MmJDNzYWN4QjM2IiOiQHbhN3XiwiMzEjMwUTM1YTM6ICc4VmIsIiUOlkI6ISej5WZyJXdDJXZkJ3biwSM6ICduV3btFkclRmcvJCLiETMxIXZkJ3TiojIklkclRmcvJye.4lZHTpR5luin0X2T2JNomHAq-4vIbixkGgRBUxYGgSeBItl98UmM0Ze7JFdPGhwuZU",
      "orderNote" : "this is an optional",
      "notifyUrl" :"",

    };

    CashfreePGSDK.doPayment(inputParams).then((value) => value?.forEach((key, value){
      this.responseReceived();
      print("$key : $value");
      response +=  "\"$key\":\"$value\"\n";
    }));
    //
    // CashfreePGSDK.doUPIPayment(inputParams).then((value) => value?.forEach((key, value){
    //   this.responseReceived();
    //   print("$key : $value");
    //   response +=  "\"$key\":\"$value\"\n";
    // }));




  }

  // Payment()async{
  //
  //   http.Response response =await http.post(Uri.parse("https://test.cashfree.com/api/v2/cftoken/order"),body:jsonEncode( {
  //     "orderId": "Order100",
  //     "orderAmount":"1",
  //     "orderCurrency":"INR"
  //   }),
  //   headers: {
  //
  //     "x-client-id" :"7051d9675fae9ae886f9de1b1507",
  //     "x-client-secret":"90c0919f5f4b31a06eb8ba3042f57272166ccdfb",
  //
  //   });
  //   if(response.statusCode == 200){
  //
  //     Map<String,dynamic>map=json.decode(response.body);
  //
  //     String token = map['cftoken'].toString();
  //
  //     Map <String,dynamic> param={
  //
  //       'tokenData':map['cftoken'],
  //       "orderId" :"Order114",
  //       "orderAmount" : "1",
  //       "appId" :"7051d9675fae9ae886f9de1b1507",
  //       "message":"Token ganerate",
  //       "orderCurrency":"INR",
  //       "customerName":"jithin",
  //       "customerPhone":"9807654321",
  //       "customerEmail":"jithin@gmail.com",
  //       "stage":"TEST",
  //       "orderNote" : "this is an optional",
  //       "notifyUrl" :"",
  //
  //     };
  //
  //     CashfreePGSDK.doPayment(param).then((value) => value?.forEach((key, value) {
  //       print("$key : $value");
  //     }));
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child:InkWell(onTap: (){

         buttonClick();
        // Payment();

      },child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: ListTile(subtitle: Text("Save and Pay via Cards.",style: TextStyle(fontSize:11),),
          title: Text(
            "Add New Card",
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.w600),
          ),
          leading: Container(
            height: 24,
            width: 35,
            child: Icon(
              Icons.add,
              size: 15,
              color: Colors.deepOrange,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade300)),
          ),
        ),
      ),
    ));
  }
}

