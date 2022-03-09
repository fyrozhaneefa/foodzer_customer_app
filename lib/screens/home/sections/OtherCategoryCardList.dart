
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/PopularRestModel.dart';
import 'package:foodzer_customer_app/Models/otherCategoryModel.dart';
import 'package:foodzer_customer_app/screens/home/sections/OtherCategoryCard.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../utils/helper.dart';
import 'groceryCard.dart';

class OtherCategoryCardList extends StatefulWidget {

  OtherCategoryModel categoryItem;
  OtherCategoryCardList(this.categoryItem);



  @override
  State<OtherCategoryCardList> createState() => _OtherCategoryCardListState();
}

class _OtherCategoryCardListState extends State<OtherCategoryCardList> {

  List<PopularRestModel> popularRestList = [];
  @override
  void initState() {
    getPopularRest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.categoryItem.restaurantDetails!.map((item) => OtherCategoryCard(
                cardName: item.merchantBranchName,
                cardTime: item.merchantBranchOrderTime,
                cardType: item.cuisines,
                rating: item.avgReview,
                deliveryCharge: 'AED 4.00',
                bannerName: item.merchantBranchImage,
                discount: '34% off',
                busy: item.merchantBranchBusy,
                press: (){
                  if(item.merchantBranchBusy == "0") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RestaurantDetailsScreen(item.merchantBranchId,item.lat,item.lng)));
                    // Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Restaurant is busy!! Come back later...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.red,
                        fontSize: 16.0
                    );
                  }
                },
              )).toList(),
              // GroceryCard(
              //   cardName: 'foodzer mart',
              //   cardTime: '20',
              //   cardType: 'Grocery',
              //   rating: 'Amazing',
              //   deliveryCharge: 'AED 5.00',
              //   bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
              //   discount: '45% off',
              //   press: (){
              //     Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
              //   },
              // ),
              // GroceryCard(
              //   cardName: 'Lella, Downtown Burj Khalifa',
              //   cardTime: '20',
              //   cardType: 'Grocery',
              //   rating: 'Amazing',
              //   deliveryCharge: 'AED 5.00',
              //   bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
              //   discount: '30% off',
              //   press: (){
              //     Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
              //   },
              // ),
              // GroceryCard(
              //   cardName: 'foodzer mart',
              //   cardTime: '20',
              //   cardType: 'Grocery',
              //   rating: 'Amazing',
              //   deliveryCharge: 'AED 5.00',
              //   bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
              //   discount: '30% off',
              //   press: (){
              //     Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
              //   },
              // ),
              // GroceryCard(
              //   cardName: 'foodzer mart',
              //   cardTime: '20',
              //   cardType: 'Grocery',
              //   rating: 'Amazing',
              //   deliveryCharge: 'AED 5.00',
              //   bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
              //   discount: '40% off',
              //   press: (){
              //     Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
              //   },
              // ),
              // GroceryCard(
              //   cardName: 'foodzer mart',
              //   cardTime: '20',
              //   cardType: 'Grocery',
              //   rating: 'Amazing',
              //   deliveryCharge: 'AED 5.00',
              //   bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
              //   discount: '50% off',
              //   press: (){
              //     Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
              //   },
              // ),
            ],
          ),
        ),
      );

  }

  getPopularRest() async {

    var map = new Map<String, dynamic>();
    map['lat'] = '10.9760357';
    map['lng'] = '76.22544309999999';
    var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
    var json = convert.jsonDecode(response.body);
    if(json['error_code'] == 0){
      List dataList = json['popular_rest'];
      if(null!= dataList && dataList.length >0){
        popularRestList =dataList.map((spacecraft) => new PopularRestModel.fromJson(spacecraft)).toList();
      }
      setState(() {

      });
    } else{
      print("some error occured!!!");
    }


  }
}










