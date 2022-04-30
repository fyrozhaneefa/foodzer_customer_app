import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
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
      userName = value.userName!;
      userType = value.userType!;
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
                      GoogleMapScreen(isFromCart, LatLng(0, 0))));
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
        actions: [
          IconButton(
            onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MainSearchScreen()));
            },
            icon: Icon(
              Icons.search,
              size: 24,
              color: Colors.black,
            ),
          )
        ],
      ),
      body:
      isLoading?
      Center(child: CircularProgressIndicator(),):
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
                child: Text("We are not present ath this loaction yet! We will let you know as\n\n                                     soon as we are here ",style: TextStyle(fontSize: 12),),
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


