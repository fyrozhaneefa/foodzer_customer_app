import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNear.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurantServiceList.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurants.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Menu/Microfiles/CuisinesSection/cuisinesheader.dart';

import '../../Menu/Microfiles/CuisinesSection/cuisinesitems.dart';
import '../../Menu/Microfiles/FiltterSection/filtters.dart';
import '../../Menu/Microfiles/FiltterSection/sortby.dart';

class AllRestaurantsScreen extends StatefulWidget {
  static const routeName = "/allRestaurants";

  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  _AllRestaurantsScreenState createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {
  bool isFromCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        // leadingWidth: 30,
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    GoogleMapScreen(isFromCart,LatLng(0, 0))));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Delivering to",
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Text(
                null != finalAddress ? finalAddress : 'Select a location',
                style: TextStyle(color: Colors.deepOrange, fontSize: 16),
              ))
            ],
          ),
        ),
        bottom: PreferredSize(
          child: Column(
            children: [
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: (){
                            filterSheet();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Filters',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                        child: InkWell(
                          onTap: (){
                            cusinesSheet();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.fastfood_outlined,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Cuisines',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                        child: InkWell(
                          onTap: (){

                          },
                          child: Row(
                            children: [
                              Icon(Icons.search_outlined,
                              size: 18,),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size(0.0, 50.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RestaurantServicesList(),
            PopularRestNearSection(),
            Restaurants()
          ],
        ),
      ),
    );
  }

  cusinesSheet() {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Headersection(),
            Expanded(
              child: CuisinesItems(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Apply",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  fixedSize: Size(Helper.getScreenWidth(context), 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  filterSheet() {
  showModalBottomSheet(isScrollControlled: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: (context),
        builder: (context) {


          return Column(
            children: [


              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.070),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close_sharp),
                          ),
                        ),
                        Center(
                          child: Text("Filters",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "Clear all",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrangeAccent),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      FiltterItems(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Text(
                          "Sort by",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SortBy(),
                    ],
                  ),
                ),
              ),
              ApplyButton(buttonname: "Apply", radius:10)
            ],
          );
        });
  }
}
