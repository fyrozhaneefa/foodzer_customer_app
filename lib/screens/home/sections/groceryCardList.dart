
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/PopularRestModel.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return
      CarouselSlider(carouselController:controller ,
        items: popularRestList.map((item) => GroceryCard(
      cardName: null!=item.merchantBranchName?item.merchantBranchName:"",
      cardTime: null!=item.merchantBranchOrderTime?item.merchantBranchOrderTime:"",
      cardType: null!=item.cuisines?item.cuisines:"",
      rating: null!=item.rating && item.rating!.isNotEmpty?item.rating:"No reviews yet",
      deliveryCharge: '',
      bannerName: null!=item.merchantBranchCoverImage?item.merchantBranchCoverImage:item.merchantBranchImage,
      discount: "",
      busy: null!=item.merchantBranchBusy?item.merchantBranchBusy:"",
      press: (){
        if(item.merchantBranchBusy == "0") {
          Provider.of<ApplicationProvider>(context, listen: false)
              .setCurrentRestModel(new SingleRestModel());
          Provider.of<ApplicationProvider>(context, listen: false)
              .setCategoryList([]);
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
          options: CarouselOptions(enlargeStrategy: CenterPageEnlargeStrategy.scale,
            pageSnapping: true,
            height: 250,
            // enlargeStrategy: CenterPageEnlargeStrategy.scale,
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

  getPopularRest() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] = prefs.getString('latitude');
    map['lng'] = prefs.getString('longitude');
    var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
    var jsonData = convert.jsonDecode(response.body);
    if(jsonData['error_code'] == 0){
      List dataList = jsonData['popular_rest'];
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










