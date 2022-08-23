import 'dart:convert';
import 'dart:typed_data';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OrderPlaced/orderplaced.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/addNewUpi.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/orderlistmodel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'Constants/sapperator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UpiSection extends StatefulWidget {
  int? delType;
  UpiSection(this.delType);

  @override
  State<UpiSection> createState() => _UpiSectionState();
}

class _UpiSectionState extends State<UpiSection> {
  List<bool>? isChecked;
  var _selectedApp;
  bool isLoading = false;
  UserData userModel = new UserData();
  OrderModel orderModel = new OrderModel();
  List allUpiApps = [];
  Uint8List? _imageBytesDecoded;
  String? itemOrderId = "";
  String? jftToken = "";

  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
    });
    getUPIApps();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
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
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allUpiApps.length,
                  itemBuilder: (BuildContext context, int index) {
                    base64encode(allUpiApps[index]["icon"]);
                    return Column(
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              allUpiApps[index]["displayName"],
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
                                child: this._imageBytesDecoded != null
                                    ? Image.memory(
                                  _imageBytesDecoded!, fit: BoxFit.cover,)
                                    : Icon(Icons.image)
                            ),
                          ),
                          trailing: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.green.shade700,
                            value: isChecked![index],
                            shape: CircleBorder(),
                            onChanged: (checked) {
                              setState(() {
                                isChecked![index] = checked!;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: isChecked![index],
                          child: Container(
                            width: Helper.getScreenWidth(context),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                              onPressed: () {

                                setState(() {
                                  _selectedApp=allUpiApps[index];
                                });
                                orderCheckout();
                              },
                              child: isLoading? Center(
                                child: CircularProgressIndicator(),
                              ):Text(
                                'Pay via ${allUpiApps[index]["displayName"]}'
                                    .toUpperCase(),
                                style:
                                TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade700,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),

                                    // side: BorderSide(color: Colors.grey)
                                  )),
                            ),
                          ),
                        ),
                        MySeparator(),
                      ],
                    );
                  }),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNewUpi(widget.delType!)));
                },
                child: ListTile(
                  subtitle: Text(
                    "You need to have a registered UPI ID.",
                    style: TextStyle(fontSize: 11),
                  ),
                  title: Text(
                    "Add New UPI ID",
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
            ],
          ),
        ),
      ),
    );
  }

  getUPIApps() async {
    await CashfreePGSDK.getUPIApps().then((value) =>
    {
      if (value != null && value.length > 0){
        setState(() {
          allUpiApps = value;
          isChecked = List<bool>.generate(allUpiApps.length, (index) => false);
        })
      },
    });
  }

  base64encode(String imagePath) async {
    _imageBytesDecoded = Base64Codec().decode(imagePath);
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
    print(_selectedApp["id"]);
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
      "appName": _selectedApp["id"]
    };

    CashfreePGSDK.doUPIPayment(inputParams)
        .then((value){
     print("values of upi is ${value}");
     isLoading = false;
     setState(() {});
     if (value!['txStatus'] == "SUCCESS") {
       UserPreference().clearCartPreference();
       Provider.of<ApplicationProvider>(context, listen: false).clearData();
       Provider.of<ApplicationProvider>(context, listen: false).setOrderId(itemOrderId.toString());
       onPaymentSuccess(value['orderId'],value['signature'],value['referenceId'],value['paymentMode'],value['orderAmount']);
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
