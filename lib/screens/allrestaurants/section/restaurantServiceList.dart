import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurantServicesCard.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/specialcategorymode.dart';
import '../../../utils/helper.dart';

class RestaurantServicesList extends StatelessWidget {
  const RestaurantServicesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 25.0),
        child: FutureBuilder(
            future: SpecialCategory().getSpecialCategory(),
            builder:
                (context, AsyncSnapshot<List<SpecialCategories>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: ShimmerWidget.rectangular(
                          height: 130,
                          width: 80,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 20,top: 10),
                      child: ShimmerWidget.rectangular(
                          height: 130,
                          width: 80,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: ShimmerWidget.rectangular(
                          height: 130,
                          width: 80,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),

                  ],
                );
              else if (snapshot.hasData) {
                return Row(children: [
                  Container(
                      height: 140,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: (snapshot.data!.length),
                          itemBuilder: (BuildContext context, int index) {
                            SpecialCategories restaurentdata =
                                snapshot.data!.elementAt(index);
                            return RestaurantServices(
                              serviceImage: restaurentdata.categoryImage,
                              serviceName: restaurentdata.categoryName,
                            );
                          }))
                ]);
              } else {
                return Center(child: Text("no data"));
              }
            }));
  }
}

class SpecialCategory {
  Future<List<SpecialCategories>?> getSpecialCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse(ApiData.All_Restaurent), headers: {
      'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
    }, body: {
      'lat': prefs.getString('latitude'),
      'lng': prefs.getString('longitude'),
      'delivery_type': 'delivery',
    });

    final jsonData = jsonDecode(response.body);
    var data = SpecialCategoryModel.fromJson(jsonData).specialCategories;
    return data;
  }
}
