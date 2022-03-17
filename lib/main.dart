

import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/CuisinesSection/cuisineshome.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
// import 'package:foodzer_customer_app/Menu/Microfiles/splash.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/AppProvider.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/allgroceries/AllGroceries.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/allRestaurants.dart';
// import 'package:foodzer_customer_app/screens/basket/itemBasket.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantInfo.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/foodzerPay.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/userOrders.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/userSettings.dart';
import 'package:foodzer_customer_app/screens/otpValidation.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';

import './screens/splashScreen.dart';
import './screens/googleMapScreen.dart';
import './screens/landingScreen.dart';
import './screens/loginScreen.dart';
import './screens/registerScreen.dart';
import './screens/forgotPassword.dart';
import 'Menu/Microfiles/FiltterSection/filtterhome.dart';
import 'Menu/Microfiles/PaymentSection/payment_home.dart';
import 'Menu/Microfiles/ReviewSection/review.dart';
// import 'Menu/Microfiles/splash.dart';
import 'screens/home/homeScreen.dart';
import 'screens/search/mainSearch.dart';
import './screens/innerdetails/restaurantDetails.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider<ApplicationProvider>(
//         create: (context) => ApplicationProvider())
//   ], child: MyApp()));
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//
//   String? userMobile;
//
// getUserDetails() {
//   UserPreference().getUserData().then((value)=> {
//     if(null!= value.userMobie && value.userMobie!.isNotEmpty){
//       setState(() {
//         userMobile = value.userMobie!;
//       })
//     }
//   });
// }
//   @override
//   void initState() {
//     getUserDetails();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Foodzer',
//       theme: ThemeData(
//           fontFamily: 'Metropolis',
//           scaffoldBackgroundColor: Colors.white,
//           textTheme: TextTheme(
//             bodyText2: TextStyle(color: Colors.black),
//           )),
//       home: null!=userMobile?HomeScreen():SplashScreen(),
//       routes:{
//         LandingScreen.routeName: (context) => LandingScreen(),
//         GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
//         LoginScreen.routeName: (context) => LoginScreen(),
//         // OtpScreen.routeName: (context) => OtpScreen(),
//         // RegisterScreen.routeName: (context) => RegisterScreen(toString()),
//         ForgotPaswwordScreen.routeName: (context) => ForgotPaswwordScreen(),
//         // HomeScreen.routeName: (context) => HomeScreen(),
//         MainSearchScreen.routeName: (context) => MainSearchScreen(),
//         // RestaurantDetailsScreen.routeName: (context) => RestaurantDetailsScreen(),
//         // RestaurantInfoScreen.routeName: (context) => RestaurantInfoScreen(),
//         // ItemBaskethome.routeName: (context) => ItemBasketScreen(),
//         AllRestaurantsScreen.routeName: (context) => AllRestaurantsScreen(),
//         AllGroceriesScreen.routeName: (context) => AllGroceriesScreen(),
//         UserSettingsScreen.routeName: (context) => UserSettingsScreen(),
//         AllFlowersScreen.routeName: (context) => AllFlowersScreen(),
//         UserOrdersScreen.routeName: (context) => UserOrdersScreen(),
//         FoodzerPayScreen.routeName: (context) => FoodzerPayScreen(),
//
//
//       }
//     );
//   }
// }


void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  Future<void> navigationPage() async {
    UserPreference().getUserData().then((value) {
      if (value.userMobie != null && value.userMobie!.isNotEmpty) {
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
      body:Container(
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