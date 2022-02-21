import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/AppProvider.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/allgroceries/AllGroceries.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/allRestaurants.dart';
import 'package:foodzer_customer_app/screens/basket/itemBasket.dart';
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
import 'screens/home/homeScreen.dart';
import 'screens/search/mainSearch.dart';
import './screens/innerdetails/restaurantDetails.dart';



void main() {
  runApp(

      MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foodzer',
        theme: ThemeData(
          fontFamily: 'Metropolis',
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText2: TextStyle(color:Colors.black),
          )
        ),
        home: SplashScreen(),
        routes:{
          LandingScreen.routeName: (context) => LandingScreen(),
          GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          // OtpScreen.routeName: (context) => OtpScreen(),
          // RegisterScreen.routeName: (context) => RegisterScreen(),
          ForgotPaswwordScreen.routeName: (context) => ForgotPaswwordScreen(),
          // HomeScreen.routeName: (context) => HomeScreen(),
          MainSearchScreen.routeName: (context) => MainSearchScreen(),
          RestaurantDetailsScreen.routeName: (context) => RestaurantDetailsScreen(),
          RestaurantInfoScreen.routeName: (context) => RestaurantInfoScreen(),
          ItemBasketScreen.routeName: (context) => ItemBasketScreen(),
          AllRestaurantsScreen.routeName: (context) => AllRestaurantsScreen(),
          AllGroceriesScreen.routeName: (context) => AllGroceriesScreen(),
          UserSettingsScreen.routeName: (context) => UserSettingsScreen(),
          AllFlowersScreen.routeName: (context) => AllFlowersScreen(),
          UserOrdersScreen.routeName: (context) => UserOrdersScreen(),
          FoodzerPayScreen.routeName: (context) => FoodzerPayScreen(),


        }
      ),
    );
  }
}


