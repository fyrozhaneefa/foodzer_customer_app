import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection/reorder.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/orderlistmodel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/screens/loginScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'divider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool isLoading = false;
  List<OrderList> orderList = [];
  UserData userModel = new UserData();

  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
  if(null!=userModel.userId && userModel.userId!.isNotEmpty){
    getOrderList();
  }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "MY ORDER",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 0,
          leading: InkWell(
            child: Icon(Icons.keyboard_backspace_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      body: null!=userModel.userId && userModel.userId!.isNotEmpty?
     ListView(
        children: [
          ListView.separated(
              itemCount: orderList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: Text(
                              orderList[index].merchantBranchName.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, right: 5),
                          child: RichText(
                            text: TextSpan(
                                text: orderList[index].orderStatus == "0"?"New order":
                                orderList[index].orderStatus == "1"?"Restaurant Accepted":
                                orderList[index].orderStatus == "3"?"Dispatch":
                                orderList[index].orderStatus == "4"?"Declined":
                                orderList[index].orderStatus == "5"?"Delivered":"",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  WidgetSpan(
                                      child: Icon(orderList[index].orderStatus == "0"?
                                    Icons.star:
                                      orderList[index].orderStatus == "1"?Icons.restaurant:
                                      orderList[index].orderStatus == "3"?Icons.delivery_dining:
                                      orderList[index].orderStatus == "4"?Icons.new_releases:
                                      orderList[index].orderStatus == "5"?Icons.check_circle:
                                        Icons.navigate_next,
                                    size: 15,
                                    color: Colors.deepOrange,
                                  ))
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(orderList[index].orderAddress.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            orderList[index].orderTotalAmount.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.grey, size: 12),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: DividingSection(),
                    ),
                    ListView.builder(
                        itemCount: orderList[index].itemDetails!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int position) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              orderList[index]
                                  .itemDetails![position]
                                  .itemName
                                  .toString() + "  x" + orderList[index]
                                  .itemDetails![position]
                                  .orderDetailsQty
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade700),
                            ),
                          );
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        orderList[index]
                            .orderDate
                            .toString(),
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "REORDER",
                                  style: TextStyle(color:  Colors.orange.shade800, fontWeight: FontWeight.w600),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color:Colors.orange.shade300, width: 1.5),
                                  fixedSize: Size(160, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only( top: 10),
                                child: Text(
                                  "You haven't rated",
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only( top: 10),
                                child: Text(
                                  "this delivery yet",
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                ),
                              ),
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "RATE DELIVERY",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  fixedSize: Size(160, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Your Food Rating",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Icon(
                                      Icons.star_outlined,
                                      size: 15,
                                      color: Colors.orangeAccent.shade700,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12, left: 3),
                                    child: Text(
                                      "5   |  Loved it",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Divider(color: Colors.black, thickness: 2),
                );
              }),
        ],
      )
          :notLoggedIn(BuildContext,context),
    );
  }

  getOrderList() async {
    setState(() {
      isLoading = true;
    });
    var map = {
      "register_id": userModel.userId,
    };
    var response =
        await http.post(Uri.parse(ApiData.GET_ORDER_LIST), body: map);
    setState(() {
      isLoading = false;
    });
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      List dataList = jsonData['order_list'];
      if (null != dataList && dataList.length > 0) {
        orderList =
            dataList.map((items) => new OrderList.fromJson(items)).toList();
        setState(() {});
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please retry",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }
}
Widget? notLoggedIn(BuildContext, context){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: Image.asset( Helper.getAssetName('vector1.png', 'virtual'),
            fit: BoxFit.fill,),
        ),
        SizedBox(height: 20,),
        Text(
          'Login to view your orders',
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30,),
        Container(
          height: 50,
          width: Helper.getScreenWidth(context)*0.45,
          child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      LoginScreen()));
                      // (Route<dynamic> route) => false);
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange.shade600,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),),
          ),
        )
      ],
    ),
  );
}
