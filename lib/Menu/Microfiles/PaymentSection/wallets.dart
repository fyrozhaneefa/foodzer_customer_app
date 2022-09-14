import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OrderPlaced/orderplaced.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/orderlistmodel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Wallets extends StatefulWidget {
  int? delType;
  Wallets(this.delType);

  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  bool isLoading= false;
  List walletList =[];
  UserData userModel = new UserData();
  OrderModel orderModel = new OrderModel();
  String? itemOrderId = "";
  String? _selectedWallet ="";
  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
    });
    getWalletList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: .5,
        backgroundColor: Colors.white,
        title:
            Consumer<ApplicationProvider>(builder: (context, provider, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select a wallet",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                    "${provider.cartModelList.length} item . Total: ₹${provider.toPayAmt.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ))
              ]);
        }),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_rounded, color: Colors.black)),
      ),
      body: isLoading?Center(
        child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),
      ):SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: walletList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            walletList[index]['name'],
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        leading: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Card(
                            child: Image(
                              width: 1,
                              image: NetworkImage(
                                  walletList[index]['image']),
                            ),
                          ),
                        ),
                        // leading: Container(
                        // trailing: Icon(
                        //   Icons.arrow_forward_ios_rounded,
                        //   size: 15,
                        // ),
                        trailing: InkWell(
                          onTap: (){
                            setState(() {
                              _selectedWallet = walletList[index]['code'];
                            });
                            orderCheckout();
                          },
                            child: Text("Link Account",
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.w600
                            ),)
                        ),
                      );
                    }),
              ),
            )),
      ),
    );
  }

  getWalletList() async {
    isLoading =true;
    setState(() {

    });
    var response =
    await http.post(Uri.parse(ApiData.GET_WALLET_LIST));
    var json = jsonDecode(response.body);
    print(response.statusCode);
    isLoading = false;
    setState(() {

    });
    List wallet = json['wallet_list'];
    if(response.statusCode == 200){
      walletList = wallet;
      setState(() {

      });
    }
  }
  orderCheckout() async {
    setState(() {
      isLoading = true;
    });
    ApplicationProvider provider =
    Provider.of<ApplicationProvider>(context, listen: false);
    String itemJson = "";
    for (Item item in provider.cartModelList) {
      if(null == item.priceonid){
        item.priceonid = "";
      }
      item.priceonid = null!=item.priceOnId?item.priceOnId:"0";
      if (null != item.addonsList && item.addonsList!.length > 0) {
        for (Addons addon in item.addonsList!) {
          if (null == item.addonIds) {
            item.addonIds = "";
          }
          item.addonIds =
              item.addonIds! + addon.itemAddonsSubtitleSubtitleId! + ",";
        }
        if (item.addonIds!.length > 0) {
          item.addonIds =
              item.addonIds!.substring(0, item.addonIds!.length - 1);
        }
      }
      itemJson = itemJson + Item.ToJson(item) + ",";
    }
    itemJson = itemJson.substring(0, itemJson.length - 1);
    itemJson = itemJson.replaceAll('\\', "");
    var map = {
      "lat": provider.selectedAddressModel.addressLat,
      "lng": provider.selectedAddressModel.addressLng,
      "merchant_branch": provider.selectedRestModel.merchantBranchId,
      "payment_mode": "2",
      "delivery_fee": provider.deliveryFee,
      "DEL_TYPE": widget.delType == 1 ? "delivery" : "pickup",
      "address_id": provider.selectedAddressModel.addressId,
      "user_id": userModel.userId,
      "coupon_id": "",
      "special_note": "special entry",
      "wallet_amount": "0",
      "item_list": "[" + itemJson + "]"
    };

    String body = json.encode(map);

    print('body is $body');
    var response = await http.post(
        Uri.parse(ApiData.ORDER_CHECKOUT), body: body);

    setState(() {
      isLoading = false;
    });
    print(response.statusCode);
    print('response ${response.body}');
    var jsonData = json.decode(response.body);
    setState(() {
      itemOrderId = jsonData["order_id"];
    });
    var dataList = jsonData['order_details'];
    if (null != dataList && dataList.length > 0) {
      orderModel =
      new OrderModel.fromJson(dataList);
      setState(() {});
    }
    orderModel.orderId = itemOrderId;

    if (jsonData['error_code'] == 0) {
      getPaymentToken();
    } else {
      Fluttertoast.showToast(
          msg: jsonData['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }

  getPaymentToken() async {
    setState(() {
      isLoading = true;
    });
    var map = new Map<String, dynamic>();
    map['amount'] = Provider
        .of<ApplicationProvider>(context, listen: false)
        .toPayAmt
        .toStringAsFixed(2);
    map['order_id'] = itemOrderId;

    var response =
    await http.post(Uri.parse(ApiData.GET_PAYMENT_TOKEN), body: map);
    setState(() {
      isLoading = false;
    });
    var json = jsonDecode(response.body);
    if (json['status'] == "OK") {
      proceedPayment(json['cftoken']);
      print("token genrated");
    } else {
      Fluttertoast.showToast(
          msg: json['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }

  Future<void> proceedPayment(String token ) async {
    //Replace with actual values
    String? orderId = itemOrderId;
    String? stage = "PROD";
    String? orderAmount = Provider
        .of<ApplicationProvider>(context, listen: false)
        .toPayAmt
        .toStringAsFixed(2);
    String? tokenData = token;
    String? customerName = userModel.userName;
    String? orderNote = "Test order";
    String? orderCurrency = "INR";
    String? appId = "117476780192ee56b9dad7efbb674711";
    String? customerPhone = userModel.userMobie;
    String? customerEmail = userModel.userEmail;
    // String? notifyUrl = "https://test.gocashfree.com/notify";


    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      // "notifyUrl": notifyUrl,


      // For seamless UPI Intent
     "paymentOption" : "wallet",
     "paymentCode" : _selectedWallet,
  };

    print(inputParams);

    CashfreePGSDK.doPayment(inputParams)
        .then((value){
      print("values of upi is ${value}");
      isLoading = false;
      setState(() {});
      if (value!['txStatus'] == "SUCCESS") {
        UserPreference().clearCartPreference();
        Provider.of<ApplicationProvider>(context, listen: false).clearData();
        Provider.of<ApplicationProvider>(context, listen: false).setOrderId(itemOrderId.toString());
        // onPaymentSuccess(value['orderId'],value['signature'],value['referenceId'],value['paymentMode'],value['orderAmount']);
        Fluttertoast.showToast(
            msg: value['txStatus'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrangeAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: value['txStatus'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

    });
  }
  onPaymentSuccess(String orderId, signature, refNo, paymentMode, orderAmount) async {
    var map = {
      "order_id": orderId,
      "signature": signature,
      "ref_no": refNo,
      "payment_mode": paymentMode,
      "order_status": "1",
      "order_amount": orderAmount,
    };
    String body = json.encode(map);
    print('body is $body');
    var response =
    await http.post(Uri.parse(ApiData.ORDER_SUCCESS), body: body);
    print(response.statusCode);
    if(response.statusCode == 200){
      print('response ${response.body}');
      var resp = json.decode(response.body);
      if(resp['errorcode'] == 0){
        showOrderPlaceDialogue();
      } else{
        print('Something went wrong');
      }
    }
  }

  showOrderPlaceDialogue(){

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: ClipRRect(
                  child: Image(
                      image: AssetImage(
                          "lib/Menu/Microfiles/assets/images/foodzer.jpg"),
                      width: 60),borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("Thank You",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text("Your order placed successfully",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>
                          OrderPlacedHome(orderModel)), (Route<dynamic> route) => false);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.orange,
                  fixedSize: Size(120, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    // side: BorderSide(color: Colors.black.withOpacity(.3)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
            ],
          )
        ],
      ),
    );
  }

}
