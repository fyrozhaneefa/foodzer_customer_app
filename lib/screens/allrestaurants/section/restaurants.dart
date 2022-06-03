import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/cuisinesmodel.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Api/ApiData.dart';
import '../../../Models/restaurentmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  bool isSwitchView = true;

  bool isloading=false;

  @override
  void initState() {
    getRestaurent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Consumer<ApplicationProvider>(builder: (context, provider, child) {
        return Column(
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
            isloading ?
            ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ShimmerWidget.rectangular(
                          height: 70,
                          width: 70,
                          shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: ShimmerWidget.rectangular(
                              height: 20,
                              width: 120,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: ShimmerWidget.rectangular(
                              height: 20,
                              width: 180,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: ShimmerWidget.rectangular(
                              height: 20,
                              width: 90,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }) : (null != provider.filteredRestaurantList &&
                provider.filteredRestaurantList.length > 0) ?
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.filteredRestaurantList.length,
                itemBuilder: (BuildContext context, int index) {
                  RestaurentModel restmodel = provider
                      .filteredRestaurantList[index];
                  return InkWell(
                    onTap: () {
                      if (restmodel.openStatus == "Open") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RestaurantDetailsScreen(
                                    restmodel.merchantBranchId,
                                    restmodel.lat,
                                    restmodel.lng)));
                      } else if (restmodel.openStatus == "Closed") {
                        Fluttertoast.showToast(
                            msg: "Closed",
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: 14,
                            backgroundColor: Colors.grey.shade300,
                            textColor: Colors.red);
                      } else if (restmodel.openStatus == "No-Service") {
                        Fluttertoast.showToast(
                            msg: "No Service",
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: 14,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.black);
                      } else if (restmodel.merchantBranchBusy == "1") {
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
                                      BorderRadius.circular(
                                          8.0),
                                      child:
                                      // Image.network(
                                      //   user.merchantBranchImage!,
                                      //   fit: BoxFit.fill,
                                      //   loadingBuilder:
                                      //       (BuildContext context,
                                      //       Widget child,
                                      //       ImageChunkEvent?
                                      //       loadingProgress) {
                                      //     if (loadingProgress == null)
                                      //       return child;
                                      //     return Center(
                                      //
                                      //
                                      //     );
                                      //   },
                                      // ),
                                      CachedNetworkImage(
                                        imageUrl: restmodel
                                            .merchantBranchImage!,
                                        fit: BoxFit.fill,
                                        errorWidget:
                                            (context, url, error) =>
                                            Icon(Icons.error),
                                      )),
                                ),
                              ),
                              restmodel.openStatus == "Closed"
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
                                  : restmodel.openStatus == "No-Service"
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
                                  : restmodel.merchantBranchBusy ==
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
                              restModel: restmodel,
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
                                  child:
                                  CachedNetworkImage(
                                    imageUrl: restmodel
                                        .merchantBranchImage!,
                                    fit: BoxFit.fill,
                                    errorWidget:
                                        (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                // Image.network(
                                //   (user.merchantBranchImage!),
                                //   fit: BoxFit.fill,
                                //   loadingBuilder:
                                //       (BuildContext context,
                                //           Widget child,
                                //           ImageChunkEvent?
                                //               loadingProgress) {
                                //     if (loadingProgress == null)
                                //       return child;
                                //     return Center(
                                //       child:
                                //           CircularProgressIndicator(
                                //         color:
                                //             Colors.deepOrangeAccent,
                                //         value: loadingProgress
                                //                     .expectedTotalBytes !=
                                //                 null
                                //             ? loadingProgress
                                //                     .cumulativeBytesLoaded /
                                //                 loadingProgress
                                //                     .expectedTotalBytes!
                                //             : null,
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            ),
                            restmodel.openStatus == "Closed"
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
                                : restmodel.openStatus == "No-Service"
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
                                : restmodel.merchantBranchBusy == "1"
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
                          ProductDesc(restModel: restmodel, isLoading: false),
                        ])),
                  );
                }) : Center(child: Text("No data found")),

          ],
        );

      }),
    );
  }
  Future getRestaurent() async {
    isloading=true;
    setState(() {

    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(ApiData.All_Restaurent), body: {
      'lat': prefs.getString('latitude'),
      'lng': prefs.getString('longitude'),
      'delivery_type': 'delivery'
    }, headers: {
      'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
    });
    isloading=false;
    setState(() {

    });
    final json = jsonDecode(response.body);
    if (json['results'] != null) {
      List<RestaurentModel> list=[];
      List<CuisinesModel> cuisinesModelList;
      list = List<RestaurentModel>.from(json["results"].map((x) => RestaurentModel.fromJson(x)));
      cuisinesModelList = List<CuisinesModel>.from(json["cuisine_list"].map((x) => CuisinesModel.fromJson(x)));
      Provider.of<ApplicationProvider>(context ,listen: false).setAllRestaurant(list);
      Provider.of<ApplicationProvider>(context ,listen: false).setAllCuisines(cuisinesModelList);


  }

  }
}

class ProductDesc extends StatelessWidget {
  RestaurentModel? restModel;
   bool isLoading;

  ProductDesc({Key? key,  this.restModel, this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              restModel!.merchantBranchName.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            restModel!.newTag == 1
                ? Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      height: 22,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "New",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ))
                : Container(),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          null != restModel!.cuisines ? restModel!.cuisines.toString() : "",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
          overflow: TextOverflow.ellipsis,
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
            restModel!.avgReview == "1"
                ? Text("Amazing")
                : restModel!.avgReview == "2"
                    ? Text("Very Good")
                    : restModel!.avgReview == "3"
                        ? Text("Good")
                        : restModel!.avgReview == "4"
                            ? Text("OK")
                            : restModel!.avgReview == "0"
                                ? Text("Not Yet")
                                : Container(),
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
              restModel!.merchantBranchOrderTime.toString() +
                  " mins" +
                  " | " +
                  restModel!.distance.toString() +
                  " km",
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
              'INR 0.0',
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

