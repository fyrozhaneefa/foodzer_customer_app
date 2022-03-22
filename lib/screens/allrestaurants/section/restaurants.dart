import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Api/ApiData.dart';
import '../../../Models/restaurentmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  bool isSwitchView = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All restaurants',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 5, bottom: 5),
                        child: GestureDetector(
                          onTap: () {
                            isSwitchView = true;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.list,
                            size: 20,
                            color:
                                isSwitchView ? Colors.deepOrange : Colors.black,
                          ),
                        ),
                      ),
                      VerticalDivider(
                          thickness: 1, color: Colors.grey.shade300),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 5, bottom: 5),
                        child: GestureDetector(
                            onTap: () {
                              isSwitchView = false;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.view_agenda_outlined,
                              size: 20,
                              color: isSwitchView
                                  ? Colors.black
                                  : Colors.deepOrange,
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          FutureBuilder(
              future: AllRestaurent().getRestaurent(),
              builder: (context, AsyncSnapshot<List<Results>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ));
                else if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          null != snapshot.data ? snapshot.data!.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        Results user = snapshot.data!.elementAt(index);
                        return InkWell(
                          onTap: () {
                            if (user.openStatus == "Open") {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RestaurantDetailsScreen(
                                          user.merchantBranchId,
                                          user.lat,
                                          user.lng)));
                            } else if (user.openStatus == "Closed") {
                              Fluttertoast.showToast(
                                  msg: "Closed",
                                  toastLength: Toast.LENGTH_LONG,
                                  fontSize: 14,
                                  backgroundColor: Colors.grey.shade300,
                                  textColor: Colors.red);
                            } else if (user.openStatus == "No-Service") {
                              Fluttertoast.showToast(
                                  msg: "No Service",
                                  toastLength: Toast.LENGTH_LONG,
                                  fontSize: 14,
                                  backgroundColor: Colors.greenAccent,
                                  textColor: Colors.black);
                            } else if (user.merchantBranchBusy == "1") {
                              Fluttertoast.showToast(
                                  msg: "Busy",
                                  toastLength: Toast.LENGTH_LONG,
                                  fontSize: 14,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black);
                            }
                          },
                          child: isSwitchView
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            width: 70,
                                            height: 60,
                                            child: Padding(
                                              padding: const EdgeInsets.only(),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  user.merchantBranchImage!,
                                                  fit: BoxFit.fill,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          user.openStatus == "Closed"
                                              ? Container(
                                                  width: 70,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  )),
                                                )
                                              : user.openStatus == "No-Service"
                                                  ? Container(
                                                      width: 70,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "    No\nservice",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 11),
                                                      )),
                                                    )
                                                  : user.merchantBranchBusy ==
                                                          "1"
                                                      ? Container(
                                                          width: 70,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Busy",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        )
                                                      : Container()
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: ProductDesc(
                                          user: user,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(children: [
                                    Stack(children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        width: Helper.getScreenWidth(context),
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            (user.merchantBranchImage!),
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      Colors.deepOrangeAccent,
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      user.openStatus == "Closed"
                                          ? Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Closed",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              )),
                                            )
                                          : user.openStatus == "No-Service"
                                              ? Container(
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "No Service",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  )),
                                                )
                                              : user.merchantBranchBusy == "1"
                                                  ? Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "Busy",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20),
                                                      )),
                                                    )
                                                  : Container()
                                    ]),
                                    ProductDesc(user: user),
                                  ])),
                        );
                      });
                } else {
                  return Center(child: Text('some error occured!!'));
                }
              })
        ],
      ),
    );
  }
}

class ProductDesc extends StatelessWidget {
  Results user;

  ProductDesc({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              user.merchantBranchName.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),

            Padding(padding: EdgeInsets.only(left: 10),child:
            Container(
              height: 22,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(.1), borderRadius: BorderRadius.circular(5)),
              child:Center(child: Text("New",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w600),),),
            )
            ),


          ],
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          null != user.cuisines ? user.cuisines.toString() : "",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.tag_faces,
              color: Colors.orangeAccent,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(user.avgReview!.toString()),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
               user.merchantBranchOrderTime.toString() + " mins" + " | " + user.distance.toString() + " km",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: CircleAvatar(
                radius: 2,
                backgroundColor: Colors.grey.shade400,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.delivery_dining,
              color: Colors.grey.shade900,
              size: 20,
            ),
            Text(
              'BD 0.400',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    );
  }
}

class AllRestaurent {
  Future<List<Results>?> getRestaurent() async {
    final response = await http.post(Uri.parse(ApiData.All_Restaurent), body: {
      'lat': '10.9760357',
      'lng': '76.22544309999999',
      'delivery_type': 'delivery'
    }, headers: {
      'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
    });

    final jsonData = jsonDecode(response.body);
    var data = RestaurentModel.fromJson(jsonData).results;
    return data;
  }
}
