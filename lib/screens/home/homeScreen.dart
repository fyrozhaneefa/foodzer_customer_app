import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/changeAddressFromHome.dart';
import 'package:foodzer_customer_app/screens/home/sections/body.dart';
import 'package:foodzer_customer_app/screens/search/mainSearch.dart';
import 'package:foodzer_customer_app/widget/navigationDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../blocs/application_bloc.dart';
import '../../utils/helper.dart';



class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFromCart = false;
  String? userName;
  String? userType;
  bool isLoggedIn = false;
  bool isLoading = false;
  int? delNotDel;
  @override
  void initState()  {

    UserPreference().getCurrentAddress().then((value) {

      finalAddress = value!;
      setState(() {

      });
    });
    getDeliverableArea();
    UserPreference().getUserData().then((value) {
      userName = value.userName;
      userType = value.userType;
      print("value is $userName");
      if(null!= value.userId){
        setState(() {
          isLoggedIn = true;
        });

      }else{
        setState(() {
          isLoggedIn = false;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose()  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title:InkWell(
          onTap: (){
            if(isLoggedIn){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeAddressFromHome()));
            }else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      GoogleMapScreen(new AddressModel(),isFromCart, LatLng(0, 0))));
            }
          },
          child: Column(
            children: [
              Container(
                child:Text(
                  "Delivering to",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                  child:Text(
                   null!=finalAddress? finalAddress:'Select a location',
                    style: TextStyle(
                        color:Colors.deepOrange,
                        fontSize: 16
                    ),
                  )
              )
            ],
          ),
        ),
        actions:
        [
          Padding(
            padding:  EdgeInsets.all(10.0),
            child: Container(
              width: 35.0,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                 if( Provider.of<ApplicationProvider>(context, listen: false).cartModelList.length > 0) {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (BuildContext context) =>
                           ItemBasketHome()));
                 } else {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (BuildContext context) =>
                           MainSearchScreen()));
                 }


                },
                child:Consumer<ApplicationProvider>(builder: (context, provider, child) {
              return Stack
                (
                  children: <Widget>[
                     IconButton(
                      icon: Icon(
                        null!= provider.cartModelList &&
                            provider.cartModelList.length > 0?
                        Icons.shopping_basket_sharp:Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: null,
                    ),
                    provider.cartModelList.length == 0
                        ? Container()
                        : Positioned(
                      top: 0,
                      right: 0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 20.0,
                            width: 20.0,
                            decoration:  BoxDecoration(
                              color: Colors.deepOrange,
                              shape: BoxShape.circle,
                            ),
                            child:  Center(
                              child: Text(
                                provider.cartModelList.length.toString(),
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
        // [
        //  Stack(
        //    alignment: Alignment.center,
        //    children: [
        //      IconButton(
        //        onPressed:(){
        //          Navigator.of(context).push(MaterialPageRoute(
        //              builder: (BuildContext context) =>
        //                  MainSearchScreen()));
        //        },
        //        icon: Icon(
        //          null!= Provider.of<ApplicationProvider>(context, listen: false).cartModelList
        //              && Provider.of<ApplicationProvider>(context, listen: false).cartModelList.length>0?
        //          Icons.shopping_basket_sharp:Icons.search,
        //          size: 30,
        //          color: Colors.black,
        //        ),
        //      ),
        //      Positioned(
        //        right: 0,
        //        bottom: 0,
        //        child: Container(
        //          padding: EdgeInsets.all(4),
        //          decoration: BoxDecoration(
        //              color: Colors.deepOrange,
        //            shape: BoxShape.circle
        //          ),
        //          child: Text(
        //            "2",
        //            style: TextStyle(
        //              fontSize: 11,
        //              color: Colors.white
        //            ),
        //          ),
        //        ),
        //      )
        //    ],
        //  )
        // ],
      ),
      body:
      isLoading?
     Center(child: CircularProgressIndicator(),

      ):

      delNotDel == 0 ?Body():Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
          child: Container(
            width: Helper.getScreenWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/real/nolocation1.jpg"),
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text("We are not present at this location yet! We will let you know as\n\n                                     soon as we are here ",style: TextStyle(fontSize: 12),),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "CHANGE LOCATION",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  fixedSize: Size(200, 40),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }

  getDeliverableArea() async {
    isLoading = true;
    setState(() {

    });
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] = prefs.getString("latitude");
    map['lng'] = prefs.getString("longitude");

    var response =
    await http.post(Uri.parse(ApiData.GET_DELIVERABLE_AREA), body: map);
    var jsonData = convert.jsonDecode(response.body);
    isLoading =false;
    setState(() {
      delNotDel = jsonData;
    });
  }


}


