import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Models/addressAdditonModel.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: GetAddress().getAddress(),
        builder: (context, AsyncSnapshot <List<AddressList>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);

          else if (snapshot.hasData) {
            return ListView.separated(scrollDirection: Axis.vertical,shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  AddressList datas = snapshot.data!.elementAt(index);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.home_outlined,
                          size: 25,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "Home",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child:
                            Text(
                                datas.addressStreetName!,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.6), fontSize: 12),
                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text("Phone Number:"+ datas.addressMobNo!, style: TextStyle(
                                color: Colors.black.withOpacity(.6), fontSize: 12)),
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
                                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
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
                                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
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
                }, separatorBuilder: (context, index) {
              return Divider();
            }, itemCount: snapshot.data!.length);
          }

          else{
           return Text("Some error occurred!!");
          }
        }

    );


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
  }
}

class GetAddress {
  Future <List<AddressList>?> getAddress() async {
    final response = await http.post(
        Uri.parse(
            "https://opine.cloud/foodzer_test/Mob_food_new/get_user_adress"),
        body: {
          "user_id": "967"
        },
        headers: {
          'Cookie': "ci_session=ae71284507eaddda353c456bb3dbb8719082959a"
        });

    final jsonData = jsonDecode(response.body);
    var data = DisplayAddressModel
        .fromJson(jsonData)
        .addressList;
    return data;
  }
}
