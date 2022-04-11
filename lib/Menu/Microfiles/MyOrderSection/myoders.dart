import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection/reorder.dart';
import 'package:foodzer_customer_app/Models/orderlistmodel.dart';
import 'package:http/http.dart' as http;

import 'divider.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: GetOrderList().getOrderList(),
        builder: (context, AsyncSnapshot <List<OrderList>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(color: Colors.green),);

          else if (snapshot.hasData) {
            return ListView.separated(shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  OrderList items = snapshot.data!.elementAt(index);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 20),
                            child: Text(items.merchantBranchName!,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, right: 5),
                            child: RichText(
                              text: TextSpan(
                                  text: "Delivered",
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    WidgetSpan(
                                        child: Icon(
                                          Icons.check_circle,
                                          size: 15,
                                          color: Colors.green,
                                        ))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Text(items.orderAddress!,
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "230 ",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey),
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
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Fish Pothichoru x 1",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "February 24, 1:30 PM",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: ReorderButton(),
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
                                    style:
                                    TextStyle(fontSize: 11,
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
                                      padding: EdgeInsets.only(
                                          top: 12, left: 3),
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
                }, separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Divider(color: Colors.black, thickness: 2),
              );
            }, itemCount: snapshot.data!.length);
          }
          else {

            return Text("Some error occured!!");
          }
        }
        );
    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(left: 10, top: 20),
    //           child: Text("Thalassery Restaurant",
    //               style: TextStyle(fontWeight: FontWeight.w500)),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: 20, right: 5),
    //           child: RichText(
    //             text: TextSpan(
    //                 text: "Delivered",
    //                 style: TextStyle(color: Colors.black),
    //                 children: [
    //                   WidgetSpan(
    //                       child: Icon(
    //                     Icons.check_circle,
    //                     size: 15,
    //                     color: Colors.green,
    //                   ))
    //                 ]),
    //           ),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(left: 10, top: 5),
    //       child: Text("Kozhikode",
    //           style: TextStyle(fontSize: 12, color: Colors.grey)),
    //     ),
    //     Row(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(left: 10, top: 10),
    //           child: Text(
    //             "230 ",
    //             style: TextStyle(fontSize: 14, color: Colors.grey),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: 10),
    //           child: Icon(Icons.arrow_forward_ios_rounded,
    //               color: Colors.grey, size: 12),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(top: 20, left: 10),
    //       child: DividingSection(),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(left: 10, top: 10),
    //       child: Text(
    //         "Fish Pothichoru x 1",
    //         style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(left: 10, top: 10),
    //       child: Text(
    //         "February 24, 1:30 PM",
    //         style: TextStyle(fontSize: 11, color: Colors.grey),
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(left: 10, top: 10),
    //           child: ReorderButton(),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: 10, right: 10),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               OutlinedButton(
    //                 onPressed: () {},
    //                 child: Text(
    //                   "RATE DELIVERY",
    //                   style: TextStyle(
    //                       color: Colors.black, fontWeight: FontWeight.w600),
    //                 ),
    //                 style: OutlinedButton.styleFrom(
    //                   side: BorderSide(color: Colors.black, width: 1.5),
    //                   fixedSize: Size(160, 40),
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(0),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(top: 10),
    //                 child: Text(
    //                   "Your Food Rating",
    //                   style:
    //                       TextStyle(fontSize: 11, color: Colors.grey.shade600),
    //                 ),
    //               ),
    //               Row(
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.only(top: 10),
    //                     child: Icon(
    //                       Icons.star_outlined,
    //                       size: 15,
    //                       color: Colors.orangeAccent.shade700,
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: EdgeInsets.only(top: 12, left: 3),
    //                     child: Text(
    //                       "5   |  Loved it",
    //                       style: TextStyle(
    //                         fontSize: 14,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: EdgeInsets.all(10),
    //       child: Divider(color: Colors.black, thickness: 2),
    //     )
    //   ],
    // );
  }
}

class GetOrderList {
  Future <List<OrderList>?> getOrderList() async {
    final response = await http.post(
        Uri.parse("https://opine.cloud/foodzer_test/Mob_food_new/order_list"),
        headers: {
          "Cookie": "ci_session=258bf7450daeb85638ba070dc925917df1070f15",
        },
        body: {
          'register_id': '967',
        });


    final jsonData = jsonDecode(response.body);
    var data = OrderListModel
        .fromJson(jsonData)
        .orderList;

    return data;
  }
}
