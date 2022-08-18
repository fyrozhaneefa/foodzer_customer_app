import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNearCard.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/SingleRestModel.dart';
import '../../../Models/popularrestaurentNearmodel.dart';
import '../../../blocs/application_bloc.dart';
import '../../../utils/helper.dart';
import '../../home/sections/groceryCard.dart';

class PopularRestNearList extends StatefulWidget {


  @override
  State<PopularRestNearList> createState() => _PopularRestNearListState();
}

class _PopularRestNearListState extends State<PopularRestNearList> {
  bool isLoading = false;
  List<PopularRest> popularRest =[];

  @override
  void initState() {
    getPopularRestaurent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: isLoading?   Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        Padding(
          padding: EdgeInsets.only(bottom: 10,right: 10),
          child: ShimmerWidget.rectangular(
            height: 150,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Padding(padding: EdgeInsets.all(1),child: ShimmerWidget.rectangular(height: 20,width: 160),),
          Padding(padding: EdgeInsets.only(bottom: 10,right: 10),child: ShimmerWidget.rectangular(height: 20,width: 100),)
        ],),
        Padding(padding: EdgeInsets.only(bottom: 30,top: 5),child: ShimmerWidget.rectangular(height: 20,width: 100),),




      ],):
       Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Helper.getScreenWidth(context)*.68 ,
            width: Helper.getScreenWidth(context)*.92  ,
            child: ListView.builder(clipBehavior: Clip.none,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: popularRest.length,
                itemBuilder: (BuildContext context, int index) {
                  PopularRest nearrestaurent =
                  popularRest.elementAt(index);

                  return PopularRestNearCard(
                    cardName: nearrestaurent.merchantBranchName,
                    cardTime:
                    nearrestaurent.deliveryAreaDeliveryTime!,
                    cardType: null!=nearrestaurent.cuisines && nearrestaurent.cuisines!.isNotEmpty? nearrestaurent.cuisines : "",
                    cardSubType: '',
                    rating: nearrestaurent.avgReview,
                    deliveryCharge:
                    nearrestaurent.merchantPackCharge!,
                    bannerName: nearrestaurent.merchantBranchCoverImage,
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
      )
    );
  }
  getPopularRestaurent() async {
    isLoading = true;
    setState(() {

    });
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] =  prefs.getString('latitude');
    map['lng'] =  prefs.getString('longitude');
    map['delivery_type'] = "delivery";
    var response= await http.post(Uri.parse(ApiData.All_Restaurent),body:map);
    var json = convert.jsonDecode(response.body);
    isLoading = false;
    setState(() {

    });
    if(json['error_code'] == 0){
      List dataList = json['popular_rest'];
      if(null!= dataList && dataList.length >0){
        popularRest =dataList.map((spacecraft) => new PopularRest.fromJson(spacecraft)).toList();
      }
      setState(() {

      });
    }
    else{
      print("some error occured!!!");
    }

  }
}

  //
  // Future getPupularRestaurent() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response = await http.post(
  //     Uri.parse(ApiData.All_Restaurent),
  //     body: {
  //       'lat': prefs.getString('latitude'),
  //       'lng': prefs.getString('longitude'),
  //       'delivery_type': 'delivery',
  //     },
  //     headers: {
  //       'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
  //     },
  //   );
  //
  //   final jsonData = jsonDecode(response.body);
  //   var data = PopularrestNearModel.fromJson(jsonData).popularRest;
  //   return data;
  // }


