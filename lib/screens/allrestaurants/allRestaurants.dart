import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/popularfilters.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/cuisinesmodel.dart';
import 'package:foodzer_customer_app/Models/specialcategorymode.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNear.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurantServiceList.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurants.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/changeAddressFromHome.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Menu/Microfiles/CuisinesSection/cuisinesheader.dart';

import '../../Menu/Microfiles/FiltterSection/dealsandoffers.dart';
import '../../Menu/Microfiles/FiltterSection/sortby.dart';

class AllRestaurantsScreen extends StatefulWidget {
  static const routeName = "/allRestaurants";

  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  _AllRestaurantsScreenState createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {
  bool isFromCart = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loggedInStatus();
    UserPreference().getCurrentAddress().then((value) {
      finalAddress = value!;
      setState(() {});
    });
  }

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
            if (isLoggedIn) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeAddressFromHome(false)));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => GoogleMapScreen(
                      new AddressModel(), isFromCart, LatLng(0, 0))));
            }
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
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 35.0,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (Provider.of<ApplicationProvider>(context, listen: false)
                          .cartModelList
                          .length >
                      0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ItemBasketHome()));
                  }
                },
                child: Consumer<ApplicationProvider>(
                    builder: (context, provider, child) {
                  return Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.shopping_basket_sharp,
                          color: Colors.black,
                        ),
                        onPressed: null,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  provider.cartModelList.length > 0
                                      ? provider.cartModelList.length.toString()
                                      : "0",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                filterSheet();
                              },
                              child: Text(
                                'Filters',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.fastfood_outlined,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                cusinesSheet();
                              },
                              child: Text(
                                'Cuisines',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      InkWell(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.search_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
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
        return Consumer<ApplicationProvider>(
            builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Headersection(),
              Expanded(
                child: ListView.separated(
                    itemCount: provider.cuisinesModelList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return ListTile(
                        title: Text(provider.cuisinesModelList[index].cuisineName!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                        trailing: Checkbox(
                          value: provider.cuisinesModelList[index].isChecked,
                          onChanged: (value) {
                            setState(() {
                              provider.setCuisineChecked(index,value!);
                              String selectVal = "SelectedValues";
                            });
                          },
                          activeColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          side: BorderSide(width: 1, color: Colors.grey),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider()),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    List<String> checkedList=[];
                    for(CuisinesModel tuple in provider.cuisinesModelList){
                      if(tuple.isChecked!){
                        checkedList.add(tuple.cuisineId!);
                      }
                    }
                    Provider.of<ApplicationProvider>(context ,listen: false).filterRestaurants(checkedList);
                    Navigator.of(context).pop();
                  },
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
        });
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
    showModalBottomSheet(
        isScrollControlled: false,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        InkWell(
                          onTap: (){


                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "Clear all",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrangeAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      PopularFilter(),
                      FiltterItems(),
                      SortBy(),
                    ],
                  ),
                ),
              ),
              ApplyButton(buttonname: "Apply", radius: 10)
            ],
          );
        });
  }

  Future loggedInStatus() async {
    UserPreference().getUserData().then((value) {
      if (null != value.userMobie && value.userMobie!.isNotEmpty) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
  }
}
