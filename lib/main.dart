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
import 'package:foodzer_customer_app/screens/basket/section/itemBasketHome.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantInfo.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/foodzerPay.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/userOrders.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/userSettings.dart';
import 'package:foodzer_customer_app/screens/otpValidation.dart';
import 'package:provider/provider.dart';

import './screens/splashScreen.dart';
import './screens/googleMapScreen.dart';
import './screens/landingScreen.dart';
import './screens/loginScreen.dart';
import './screens/registerScreen.dart';
import './screens/forgotPassword.dart';
import 'Menu/Microfiles/EditAccountSection/editaccount.dart';
import 'Menu/Microfiles/FiltterSection/filtterhome.dart';
import 'Menu/Microfiles/PaymentSection/payment_home.dart';
import 'Menu/Microfiles/ReviewSection/review.dart';
import 'screens/home/homeScreen.dart';
import 'screens/search/mainSearch.dart';
import './screens/innerdetails/restaurantDetails.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ApplicationProvider>(
        create: (context) => ApplicationProvider())
  ], child: MyApp()));
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String? userMobile;

  @override
  void initState() {
    UserPreference().getUserData().then((value)=> {
      if(null!= value.userMobie && value.userMobie!.isNotEmpty){
        userMobile = value.userMobie,
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodzer',
      theme: ThemeData(
          fontFamily: 'Metropolis',
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.black),
          )),

      home: null!=userMobile && userMobile!.isNotEmpty?HomeScreen():SplashScreen(),
      routes:{
        LandingScreen.routeName: (context) => LandingScreen(),
        GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        // OtpScreen.routeName: (context) => OtpScreen(),
        // RegisterScreen.routeName: (context) => RegisterScreen(toString()),
        ForgotPaswwordScreen.routeName: (context) => ForgotPaswwordScreen(),
        // HomeScreen.routeName: (context) => HomeScreen(),
        MainSearchScreen.routeName: (context) => MainSearchScreen(),
        // RestaurantDetailsScreen.routeName: (context) => RestaurantDetailsScreen(),
        // RestaurantInfoScreen.routeName: (context) => RestaurantInfoScreen(),
        AllRestaurantsScreen.routeName: (context) => AllRestaurantsScreen(),
        AllGroceriesScreen.routeName: (context) => AllGroceriesScreen(),
        UserSettingsScreen.routeName: (context) => UserSettingsScreen(),
        AllFlowersScreen.routeName: (context) => AllFlowersScreen(),
        UserOrdersScreen.routeName: (context) => UserOrdersScreen(),
        FoodzerPayScreen.routeName: (context) => FoodzerPayScreen(),


      }
    );
  }
}
