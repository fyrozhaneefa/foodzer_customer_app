import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNearCard.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;

import '../../../Models/popularrestaurentNearmodel.dart';
import '../../../utils/helper.dart';

class PopularRestNearList extends StatelessWidget {
  const PopularRestNearList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: FutureBuilder(
            future: PopularRestaurentNear().getPupularRestaurent(),
            builder: (context, AsyncSnapshot<List<PopularRest>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(color: Colors.deepOrange),
                );
              else if (snapshot.hasData) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Helper.getScreenWidth(context) * 0.70,
                      width: Helper.getScreenWidth(context) * 0.85,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            PopularRest nearrestaurent =
                                snapshot.data!.elementAt(index);

                            return PopularRestNearCard(
                              cardName: nearrestaurent.merchantBranchName!,
                              cardTime:
                                  nearrestaurent.deliveryAreaDeliveryTime!,
                              cardType: nearrestaurent.cuisines!,
                              cardSubType: '',
                              rating: nearrestaurent.avgReview!,
                              deliveryCharge:
                                  nearrestaurent.merchantPackCharge!,
                              bannerName: nearrestaurent.merchantBranchImage!,
                              discount: '34% off',
                              press: () {
                                Navigator.of(context).pushNamed(
                                    RestaurantDetailsScreen.routeName);
                              },
                            );
                          }),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text("Some error occcured!!!"),
                );
              }
            })

        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     PopularRestNearCard(
        //       cardName: 'QKO Asian',
        //       cardTime: '25',
        //       cardType: 'Grocery',
        //       cardSubType: 'Supermarket',
        //       rating: 'Very good',
        //       deliveryCharge: 'AED 4.00',
        //       bannerName: 'https://png.pngtree.com/thumb_back/fh260/back_our/20190620/ourmid/pngtree-food-seasoning-food-banner-image_169169.jpg',
        //       discount: '34% off',
        //       press: (){
        //         Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
        //       },
        //     ),
        //     PopularRestNearCard(
        //       cardName: 'foodzer mart',
        //       cardTime: '20',
        //       cardType: 'Grocery',
        //       cardSubType: 'Convenience store',
        //       rating: 'Amazing',
        //       deliveryCharge: 'AED 5.00',
        //       bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
        //       discount: '45% off',
        //       press: (){
        //         Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
        //       },
        //     ),
        //     PopularRestNearCard(
        //       cardName: 'Lella, Downtown Burj Khalifa',
        //       cardTime: '20',
        //       cardType: 'Grocery',
        //       cardSubType: 'Convenience store',
        //       rating: 'Amazing',
        //       deliveryCharge: 'AED 5.00',
        //       bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
        //       discount: '30% off',
        //       press: (){
        //         Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
        //       },
        //     ),
        //     PopularRestNearCard(
        //       cardName: 'foodzer mart',
        //       cardTime: '20',
        //       cardType: 'Grocery',
        //       cardSubType: 'Convenience store',
        //       rating: 'Amazing',
        //       deliveryCharge: 'AED 5.00',
        //       bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
        //       discount: '30% off',
        //       press: (){
        //         Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
        //       },
        //     ),
        //     PopularRestNearCard(
        //       cardName: 'foodzer mart',
        //       cardTime: '20',
        //       cardType: 'Grocery',
        //       cardSubType: 'Convenience store',
        //       rating: 'Amazing',
        //       deliveryCharge: 'AED 5.00',
        //       bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
        //       discount: '40% off',
        //       press: (){
        //         Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
        //       },
        //     ),
        //     PopularRestNearCard(
        //       cardName: 'foodzer mart',
        //       cardTime: '20',
        //       cardType: 'Grocery',
        //       cardSubType: 'Convenience store',
        //       rating: 'Amazing',
        //       deliveryCharge: 'AED 5.00',
        //       bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
        //       discount: '50% off',
        //       press: (){
        //         Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
        //       },
        //     ),
        //   ],
        // ),
        );
  }
}

class PopularRestaurentNear {
  Future<List<PopularRest>?> getPupularRestaurent() async {
    final response = await http.post(
      Uri.parse("https://opine.cloud/foodzer_test/mob_food_new/restaurants"),
      body: {
        'lat': '10.9760357',
        'lng': '76.22544309999999',
        'delivery_type': 'delivery',
      },
      headers: {
        'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
      },
    );

    final jsonData = jsonDecode(response.body);
    var data = PopularrestNearModel.fromJson(jsonData).popularRest;
    return data;
  }
}
