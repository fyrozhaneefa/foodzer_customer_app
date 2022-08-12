import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OrderPlaced/orderplaced.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/orderlistmodel.dart';
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
  OrderModel orderModel=new OrderModel();

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
            Text("${provider.cartModelList.length} item . Total: ₹${provider.toPayAmt.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ))
          ]);
        }),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_rounded, color: Colors.black)),
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
    var dataList = jsonData['order_details'];
    if (null != dataList && dataList.length > 0) {
      orderModel =
      new OrderModel.fromJson(dataList);
      setState(() {});
    }
    orderModel.orderId = itemOrderId;
    // orderModel.merchantLat=double.parse(provider.selectedRestModel.branchDetails!.lat!);
    // orderModel.merchantLng=double.parse(provider.selectedRestModel.branchDetails!.lng!);
    // orderModel.userLat=double.parse(provider.selectedAddressModel.addressLat!);
    // orderModel.userLng=double.parse(provider.selectedAddressModel.addressLng!);
    // orderModel.orderAddress=provider.selectedAddressModel.addressUser!;
    // orderModel.orderId=itemOrderId;
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
  proceedPayment(String token) {
    isLoading = true;
    setState(() {});

    String? orderId = itemOrderId;
    String? orderAmount = Provider.of<ApplicationProvider>(context, listen: false)
        .toPayAmt.toString();
    String? stage = "PROD";
    String? tokenData = token;
    String? customerName = userModel.userName;
    String? orderNote = "Test order";
    String? orderCurrency = "INR";
    String? appId = "117476780192ee56b9dad7efbb674711";
    String? customerPhone = userModel.userMobie;
    String? customerEmail = userModel.userEmail;

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "tokenData": tokenData,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "paymentOption": "upi",
      "upi_vpa": upiController.text
    };

    CashfreePGSDK.doPayment(inputParams).then((value) {
      isLoading = false;
      setState(() {});
      if (value!['txStatus'] == "SUCCESS") {
        UserPreference().clearCartPreference();
        Provider.of<ApplicationProvider>(context, listen: false).clearData();
        Provider.of<ApplicationProvider>(context, listen: false).setOrderId(itemOrderId.toString());
        onPaymentSuccess(value['orderId'],value['signature'],value['referenceId'],value['paymentMode'],value['orderAmount']);
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) =>
        //         HomeScreen()), (Route<dynamic> route) => false);
        // showOrderPlaceDialogue();

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
