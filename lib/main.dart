import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:flutter/services.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/screens/landingScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([

    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ApplicationProvider>(
        create: (context) => ApplicationProvider())
  ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Foodzer',
    home: SignInDemo(),
    theme: ThemeData(
        fontFamily: 'Metropolis',
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(

          bodyText2: TextStyle(color: Colors.black),
        )),
  )));
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  var _visible = true;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }
  Future<void> navigationPage() async {
    UserPreference().getUserData().then((value) {
      if (null!=value.userType && value.userType!.isNotEmpty) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LandingScreen()));
      }
    });
  }


  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.bounceIn);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(
            width: Helper.getScreenWidth(context),
            height: Helper.getScreenHeight(context),
            color:  Color(0xFFF15E22),
          ),
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                Helper.getAssetName("foodz.png", "virtual"),
                width: Helper.getScreenWidth(context)*.5,
                fit: BoxFit.cover,
              )
          ),
        ],
      ),
    );
  }
}