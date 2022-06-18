import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNearCard.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/popularrestaurentNearmodel.dart';
import '../../../utils/helper.dart';

class PopularRestNearList extends StatefulWidget {

  @override
  State<PopularRestNearList> createState() => _PopularRestNearListState();
}

class _PopularRestNearListState extends State<PopularRestNearList> {
  bool isLoading =false;
List<PopularRest> popularRest = [];

  @override
  void initState() {
    getPopularRestaurent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading?
                Padding(
                  padding: const EdgeInsets.only(left:20.0,right:10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  Padding(
                  padding: EdgeInsets.only(bottom: 10),
            child: ShimmerWidget.rectangular(
            height: 150,
            shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
            ),
            ),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      Padding(padding: EdgeInsets.all(1),child: ShimmerWidget.rectangular(height: 20,width: 160),),
                      Padding(padding: EdgeInsets.only(bottom: 10),child: ShimmerWidget.rectangular(height: 20,width: 100),)
                    ],),
                    Padding(padding: EdgeInsets.only(bottom: 30,top: 5),child: ShimmerWidget.rectangular(height: 20,width: 100),),



                  ],),
                )
        : Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Helper.getScreenWidth(context) * 0.70,
            width: Helper.getScreenWidth(context) * 0.85,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: popularRest.length,
                itemBuilder: (BuildContext context, int index) {
                  PopularRest nearrestaurent =
                      popularRest[index];

                  return PopularRestNearCard(
                    cardName: nearrestaurent.merchantBranchName!,
                    cardTime: null!=nearrestaurent.merchantBranchOrderTime?nearrestaurent.merchantBranchOrderTime:"0",
                    cardType: null!=nearrestaurent.cuisines && nearrestaurent.cuisines!.isNotEmpty? nearrestaurent.cuisines : "",
                    cardSubType: '',
                    rating: null!=nearrestaurent.rating?nearrestaurent.rating:"No reviews yet",
                    deliveryCharge: null!=nearrestaurent.merchantPackCharge?nearrestaurent.merchantPackCharge:"0",
                    bannerName:null!=nearrestaurent.merchantBranchCoverImage? nearrestaurent.merchantBranchCoverImage:nearrestaurent.merchantBranchImage,
                    discount: '34% off',
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RestaurantDetailsScreen(
                                  nearrestaurent.merchantBranchId,
                                  nearrestaurent.lat,
                                  nearrestaurent.lng)));
                    },
                  );
                }),
          )
        ],
      ),
    );
      // Padding(
      //   padding: EdgeInsets.only(left: 20, right: 10),
      //   child: FutureBuilder(
      //       future: PopularRestaurentNear().getPupularRestaurent(),
      //       builder: (context, AsyncSnapshot<List<PopularRest>?> snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting)
      //           return
      //             Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      //
      //             Padding(
      //             padding: EdgeInsets.only(bottom: 10),
      //         child: ShimmerWidget.rectangular(
      //         height: 150,
      //         shapeBorder: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10)),
      //         ),
      //         ),
      //
      //               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      //                 Padding(padding: EdgeInsets.all(1),child: ShimmerWidget.rectangular(height: 20,width: 160),),
      //                 Padding(padding: EdgeInsets.only(bottom: 10),child: ShimmerWidget.rectangular(height: 20,width: 100),)
      //               ],),
      //               Padding(padding: EdgeInsets.only(bottom: 30,top: 5),child: ShimmerWidget.rectangular(height: 20,width: 100),),
      //
      //
      //
      //             ],);
      //         else if (snapshot.hasData) {
      //           return
      //             Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Container(
      //                 height: Helper.getScreenWidth(context) * 0.70,
      //                 width: Helper.getScreenWidth(context) * 0.85,
      //                 child: ListView.builder(
      //                     shrinkWrap: true,
      //                     scrollDirection: Axis.horizontal,
      //                     itemCount: snapshot.data!.length,
      //                     itemBuilder: (BuildContext context, int index) {
      //                       PopularRest nearrestaurent =
      //                           snapshot.data!.elementAt(index);
      //
      //                       return PopularRestNearCard(
      //                         cardName: nearrestaurent.merchantBranchName!,
      //                         cardTime:
      //                             nearrestaurent.deliveryAreaDeliveryTime!,
      //                         cardType: null!=nearrestaurent.cuisines && nearrestaurent.cuisines!.isNotEmpty? nearrestaurent.cuisines : "",
      //                         cardSubType: '',
      //                         rating: nearrestaurent.avgReview!,
      //                         deliveryCharge:
      //                             nearrestaurent.merchantPackCharge!,
      //                         bannerName: nearrestaurent.merchantBranchImage!,
      //                         discount: '34% off',
      //                         press: () {
      //                           Navigator.of(context).push(MaterialPageRoute(
      //                               builder: (BuildContext context) =>
      //                                   RestaurantDetailsScreen(
      //                                       nearrestaurent.merchantBranchId,
      //                                       nearrestaurent.lat,
      //                                       nearrestaurent.lng)));
      //                         },
      //                       );
      //                     }),
      //               )
      //             ],
      //           );
      //         } else {
      //           return Center(
      //             child: Text("Some error occcured!!!"),
      //           );
      //         }
      //       })
      //   );
  }
  getPopularRestaurent() async {
    isLoading=true;
    setState(() {

    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse("https://www.foodzer.com/Mob_food_new/restaurants"),
      body: {
        'lat': prefs.getString('latitude'),
        'lng': prefs.getString('longitude'),
        'delivery_type': 'delivery',
      },
      headers: {
        'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
      },
    );

    final jsonData = jsonDecode(response.body);
    isLoading = false;
    setState(() {

    });
    List dataList = jsonData['popular_rest_near_you'];
        if (null != dataList && dataList.length > 0) {
          popularRest = dataList
              .map((spacecraft) => new PopularRest.fromJson(spacecraft))
              .toList();
        }
  }
}

// class PopularRestaurentNear {
//   Future<List<PopularRest>?> getPupularRestaurent() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.post(
//       Uri.parse("https://www.foodzer.com/Mob_food_new/restaurants"),
//       body: {
//         'lat': prefs.getString('latitude'),
//         'lng': prefs.getString('longitude'),
//         'delivery_type': 'delivery',
//       },
//       headers: {
//         'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
//       },
//     );
//
//     final jsonData = jsonDecode(response.body);
//     var data = PopularrestNearModel.fromJson(jsonData).popularRest;
//     return data;
//   }
// }
