
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/PopularRestModel.dart';
import 'package:foodzer_customer_app/Models/otherCategoryModel.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/home/sections/OtherCategoryCard.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../../../blocs/application_bloc.dart';
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

      Consumer<ApplicationProvider>(builder: (context, provider, _) {

        return CarouselSlider(
        items: widget.categoryItem.restaurantDetails!.map((item) => OtherCategoryCard(
          cardName: null!=item.merchantBranchName?item.merchantBranchName:"",
          cardTime: null!=item.merchantBranchOrderTime?item.merchantBranchOrderTime:"",
          cardType: null!=item.cuisines?item.cuisines:"",
          rating:null!=item.avgReview && item.avgReview =="0"?"No reviews yet":item.avgReview,
          deliveryCharge: '',
          bannerName: null!=item.merchantBranchCoverImage ? item.merchantBranchCoverImage :
          // "https://media.cntraveler.com/photos/5b22bfea9a9e466ba59f567a/master/w_4000,h_2857,c_limit/Pukka_Catherine-Hendry_2018_overhead-hands.jpg",
          item.merchantBranchImage ,
          discount: '',
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

        options: CarouselOptions(
          pageSnapping: true,
          height: 250,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          // aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 600),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: false,
          onPageChanged: (int index, CarouselPageChangedReason reason) {},
          scrollDirection: Axis.horizontal,
        ),
      );
    }



      );}

  getPopularRest() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] =  prefs.getString('latitude');
    map['lng'] =  prefs.getString('longitude');
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










