import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OrderPlaced/orderplaced.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Constants/radiobutton.dart';

class PayOnDelivery extends StatefulWidget {
  int? delType;
  PayOnDelivery(this.delType);

  @override
  _PayOnDeliveryState createState() => _PayOnDeliveryState();
}

class _PayOnDeliveryState extends State<PayOnDelivery> {
  bool _value = false;
  UserData userModel = new UserData();
  bool isLoading = false;
  String? itemOrderId = "";
  @override
  void initState() {
    super.initState();
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
    });
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
          padding: const EdgeInsets.only(top: 15,bottom: 10),
          child: Column(
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Cash",style: TextStyle(fontWeight: FontWeight.w600,
                  color: Colors.deepOrange),),
                ),
                subtitle: Text(
                  "Pay cash at the time of delivery.We\n"
                  "reccomended you use online payments for"
                  "\ncontacless delivery",
                  style: TextStyle(fontSize: 11,color: Colors.grey),
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: Card(
                      child: Image(
                          image: NetworkImage(
                              "https://static.vecteezy.com/system/resources/previews/003/718/271/non_2x/hand-with-money-free-vector.jpg"),
                      )),
                ),


             trailing:  Checkbox(
               checkColor: Colors.white,
               activeColor: Colors.green.shade700,
               value: _value,
               shape: CircleBorder(),
               onChanged: (bool? value) {
                 setState(() {
                   _value = value!;
                 });
               },
             ),

              ),
              Visibility(
                visible: _value,
                child: Container(
                  width: Helper.getScreenWidth(context),
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: (){
                      orderCheckout();
                    },
                    child: isLoading?Center(
                      child: CircularProgressIndicator(),
                    ):Text('PAY VIA CASH',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),),
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
              // Container(child: ElevatedButton(onPressed: (){},child: Text("hao")),)
            ],
          ),
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
    itemJson = itemJson.replaceAll('\\', "");
    var map = {
      "lat": provider.selectedAddressModel.addressLat,
      "lng": provider.selectedAddressModel.addressLng,
      "merchant_branch": provider.selectedRestModel.merchantBranchId,
      "payment_mode": "1",
      "delivery_fee": provider.deliveryFee,
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
      Provider.of<ApplicationProvider>(context, listen: false).clearData();
      Provider.of<ApplicationProvider>(context, listen: false).setOrderId(itemOrderId.toString());
      showOrderPlaceDialogue();
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
