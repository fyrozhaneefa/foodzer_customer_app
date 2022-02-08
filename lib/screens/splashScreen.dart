import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import './landingScreen.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // Timer _timer = Timer(Duration(milliseconds: 4000), () {
    //   Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
    // });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
                Navigator.of(context).pushReplacementNamed(LandingScreen.routeName));
    return Scaffold(
      body: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  Helper.getAssetName('splashIcon.png', 'virtual'),
                  fit: BoxFit.fill,
                  color: Colors.deepOrange,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  Helper.getAssetName("foodzer-logo.png", "virtual"),
                  fit: BoxFit.cover,
                )
              ),
            ],
          )),
    );
  }
}
