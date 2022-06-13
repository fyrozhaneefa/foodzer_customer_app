

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/screens/loginScreen.dart';
import '../utils/helper.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "/landingScreen";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isFromCart = false;

  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            size: 26,
            color: Colors.black,)
          , onPressed: () {  },),
        title: Text(
          "Log in",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Helper.getScreenWidth(context),
              height: Helper.getScreenHeight(context) *0.3,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(Helper.getAssetName("template.png", "virtual")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0, left:20.0, right: 20.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                        child: Text(
                          "Login or create an account",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top:15.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Login or create an account to receive rewards and save your details for a faster checkout experience",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // UserModel userModel = new UserModel();
                          // userModel.userType = "GUEST";
                          // UserPreference().setUserData(userModel);
                          // setState(() {
                          //
                          // });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GoogleMapScreen(new AddressModel(),isFromCart, LatLng(0, 0))));

                        },
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {

                                },
                                icon: Icon(Icons.person,
                                size: 30,
                                color: Colors.deepOrangeAccent,),
                              ),
                            ),
                        Container(
                          alignment: Alignment.center,
                                child:  Text("Continue as a Guest",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600
                                  ),),
                              )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary:Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(isFromCart)));
                        },
                        child: Stack(
                          children: [
                          Container(
                            alignment: Alignment.centerLeft,
                              child:IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.phone_iphone,
                                  size: 30,
                                color: Colors.deepOrangeAccent,),
                              )
                          ),
                            Container(
                              alignment: Alignment.center,
                              child:  Text("Continue with Mobile",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600
                                ),),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary:Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

}
