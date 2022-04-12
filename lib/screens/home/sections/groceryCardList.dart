
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/PopularRestModel.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../utils/helper.dart';
import 'groceryCard.dart';

class GroceryCardList extends StatefulWidget {
  const GroceryCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<GroceryCardList> createState() => _GroceryCardListState();
}

class _GroceryCardListState extends State<GroceryCardList> {

  List<PopularRestModel> popularRestList = [];
  @override
  void initState() {
    getPopularRest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      CarouselSlider(
        items: popularRestList.map((item) => GroceryCard(
      cardName: null!=item.merchantBranchName?item.merchantBranchName:"",
      cardTime: null!=item.merchantBranchOrderTime?item.merchantBranchOrderTime:"",
      cardType: null!=item.cuisines?item.cuisines:"",
      rating: null!=item.avgReview?item.avgReview:"",
      deliveryCharge: 'AED 4.00',
      bannerName: null!=item.merchantBranchImage?item.merchantBranchImage:"",
      discount: '34% off',
      busy: null!=item.merchantBranchBusy?item.merchantBranchBusy:"",
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
          options: CarouselOptions(
            pageSnapping: true,
            height: 300,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            // aspectRatio: 16 / 9,
            // viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: false,
            onPageChanged: (int index, CarouselPageChangedReason reason) {},
            scrollDirection: Axis.horizontal,
          ),
      );
      // ...popularRestList.map((item) => GroceryCard(
      //   cardName: item.merchantBranchName,
      //   cardTime: item.merchantBranchOrderTime,
      //   cardType: item.cuisines,
      //   rating: item.avgReview,
      //   deliveryCharge: 'AED 4.00',
      //   bannerName: item.merchantBranchImage,
      //   discount: '34% off',
      //   busy: item.merchantBranchBusy,
      //   press: (){
      //     if(item.merchantBranchBusy == "0") {
      //       Navigator.of(context).push(MaterialPageRoute(
      //           builder: (BuildContext context) =>
      //               RestaurantDetailsScreen(item.merchantBranchId,item.lat,item.lng)));
      //       // Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
      //     } else {
      //       Fluttertoast.showToast(
      //           msg: "Restaurant is busy!! Come back later...",
      //           toastLength: Toast.LENGTH_SHORT,
      //           gravity: ToastGravity.SNACKBAR,
      //           timeInSecForIosWeb: 1,
      //           backgroundColor: Colors.red,
      //           textColor: Colors.red,
      //           fontSize: 16.0
      //       );
      //     }
      //   },
      // )).toList();

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










