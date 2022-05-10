import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OrderPlaced/orderplaced.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:foodzer_customer_app/utils/paymentUtils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:validators/validators.dart';


class AddNewUpi extends StatefulWidget {
  int delType;
  AddNewUpi(this.delType);
  @override
  State<AddNewUpi> createState() => _AddNewUpiState();
}

class _AddNewUpiState extends State<AddNewUpi> {
  TextEditingController upiController = new TextEditingController();
  bool isLoading = false;
  UserData userModel = new UserData();
  var _selectedApp;

  String? itemOrderId = "";

  @override
  void initState() {

    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        backgroundColor: Colors.white,
        title:Consumer<ApplicationProvider>(builder: (context, provider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Add New UPI ID",
              style: TextStyle(
                  color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3,),
            Text("${provider.cartModelList.length} item . Total: ₹${provider.totalWithoutTax}",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ))
          ]);
        }),
        leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              child: TextFormField(
                controller: upiController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  label: Text("Enter your UPI ID"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: .5),
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
                child:isLoading?Center(
                  child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),
                ):
                ElevatedButton(
                  onPressed: () {
                    if (upiController.text.length > 0 && upiController.text.isNotEmpty) {
                      orderCheckout();
                    }
                  },
                  child: Text(
                    "Verify and pay",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary:upiController.text.length == 0 && upiController.text.isEmpty?
                        Colors.grey:
                    Colors.deepOrangeAccent.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  proceedPayment(String token) {
    isLoading = true;
    setState(() {});

    String orderId = "1154851";
    String stage = "TEST";
    String orderAmount = "500";
    String tokenData = token;
    String customerName = "Customer Name";
    String orderNote = "Test order";
    String orderCurrency = "INR";
    String appId = "712906953878b39c66ddcff9809217";
    String customerPhone = "9688521025";
    String customerEmail = "sample@gmail.com";
    String notifyUrl = "https://test.gocashfree.com/notify";

    Map<String, dynamic> inputParams = {
      "orderId": itemOrderId,
      "orderAmount": Provider.of<ApplicationProvider>(context, listen: false)
          .totalWithoutTax
          .toString(),
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      "paymentOption": "upi",
      "upi_vpa": upiController.text
    };

    CashfreePGSDK.doPayment(inputParams).then((value) {
      isLoading = false;
      setState(() {});

      if (value!['txStatus'] == "SUCCESS") {
        Provider.of<ApplicationProvider>(context, listen: false).clearData();
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) =>
        //         HomeScreen()), (Route<dynamic> route) => false);
        showOrderPlaceDialogue();

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
      //Do something with the result
    });
  }

  orderCheckout() async {
    setState(() {
      isLoading = true;
    });
    ApplicationProvider provider =
    Provider.of<ApplicationProvider>(context, listen: false);
    String itemJson = "";
    for (Item item in provider.cartModelList) {
      if (null != item.addonsList && item.addonsList!.length > 0) {
        for (Addons addon in item.addonsList!) {
          if (null == item.addonIds) {
            item.addonIds = "";
          }
          item.addonIds = item.addonIds! + addon.itemAddonsSubtitleTblid! + ",";
        }
        if (item.addonIds!.length > 0) {
          item.addonIds =
              item.addonIds!.substring(0, item.addonIds!.length - 1);
        }
      }
      itemJson = itemJson + Item.ToJson(item) + ",";
    }
    itemJson = itemJson.substring(0, itemJson.length - 1);
    var map = {
      "lat": provider.selectedAddressModel.addressLat,
      "lng": provider.selectedAddressModel.addressLng,
      "merchant_branch": provider.selectedRestModel.merchantBranchId,
      "payment_mode": "2",
      "delivery_fee": "0",
      "DEL_TYPE": widget.delType == 1?"delivery":"pickup",
      "address_id": provider.selectedAddressModel.addressId,
      "user_id": userModel.userId,
      "coupon_id": "",
      "special_note": "special entry",
      "wallet_amount": "0",
      "item_list": "[" + itemJson + "]"
    };

    String body = json.encode(map);

    print('body is $body');
    var response =
    await http.post(Uri.parse(ApiData.ORDER_CHECKOUT), body: body);

    setState(() {
      isLoading = false;
    });
    print(response.statusCode);
    print('response ${response.body}');
    var jsonData = json.decode(response.body);
    setState(() {
      itemOrderId = jsonData["order_id"];
    });

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
    map['amount'] = Provider.of<ApplicationProvider>(context, listen: false)
        .totalWithoutTax
        .toString();
    map['order_id'] = itemOrderId;

    var response =
    await http.post(Uri.parse(ApiData.GET_PAYMENT_TOKEN), body: map);
    setState(() {
      isLoading = false;
    });
    var json = jsonDecode(response.body);
    if (json['status'] == "OK") {
      proceedPayment(json['cftoken']);
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
                          OrderPlacedHome()), (Route<dynamic> route) => false);
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
