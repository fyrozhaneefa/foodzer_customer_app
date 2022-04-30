import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;

import '../../../Api/ApiData.dart';
import '../../../Models/AddressModel.dart';
import '../../../Models/UserModel.dart';

import '../../../Preferences/Preferences.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  int? deliveryType = 1;
  bool isFromCart = true;
  bool isLoading = false;
  UserData userModel = new UserData();
  List<AddressModel> getAddressList = [];
  double taxPercentage = 0;
  double toPayAmt = 0;

  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {

      });
      getUserAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  getAddressList[index].addressTitle == "HOME" ?
                  Icons.home :
                  getAddressList[index].addressTitle == "WORK" ?
                  Icons.work :

                  getAddressList[index].addressTitle == "FRIENDS" ?
                  Icons.person_pin :
                  Icons.person_pin,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child:
                    Text("Home",

                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),


                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Container(
                        width: Helper.getScreenWidth(context) * .8,
                        child: Text(
                          getAddressList[index].addressStreetName!,
                          style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontSize: 12),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                        "Phone Number : " + getAddressList[index].addressMobNo!,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontSize: 12)),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: InkWell(
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                                color: Colors.orange.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 20, bottom: 20),
                        child: InkWell(
                          child: Text(
                            "DELETE",
                            style: TextStyle(
                                color: Colors.orange.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 20, bottom: 20),
                        child: InkWell(
                          child: Text(
                            "SHARE",
                            style: TextStyle(
                                color: Colors.orange.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: getAddressList.length);
  }

  //   Row(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Padding(
  //       padding: EdgeInsets.all(10),
  //       child: Icon(
  //         Icons.home_outlined,
  //         size: 25,
  //       ),
  //     ),
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.only(top: 15),
  //           child: Text(
  //             "Home",
  //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 15),
  //           child: Text(
  //               "Kottarakkara,Mavoor Road,Calicut ,kerala,\n673004,india",
  //               style: TextStyle(
  //                   color: Colors.black.withOpacity(.6), fontSize: 12)),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 15),
  //           child: Text("Phone Number:8943123253", style: TextStyle(
  //               color: Colors.black.withOpacity(.6), fontSize: 12)),
  //         ),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, bottom: 20),
  //               child: InkWell(
  //                 child: Text(
  //                   "EDIT",
  //                   style: TextStyle(
  //                       color: Colors.orange.shade600,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
  //               child: InkWell(
  //                 child: Text(
  //                   "DELETE",
  //                   style: TextStyle(
  //                       color: Colors.orange.shade600,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
  //               child: InkWell(
  //                 child: Text(
  //                   "SHARE",
  //                   style: TextStyle(
  //                       color: Colors.orange.shade600,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   ],
  // );


  getUserAddress() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['user_id'] = userModel.userId;

    var response =
    await http.post(Uri.parse(ApiData.GET_USER_ADDRESS), body: map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['address_list'];
    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      if (null != dataList && dataList.length > 0) {
        getAddressList = dataList
            .map((address) => new AddressModel.fromJson(address))
            .toList();
        setState(() {});
      }
    }
  }
}

