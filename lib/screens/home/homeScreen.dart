import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/screens/home/sections/body.dart';
import 'package:foodzer_customer_app/screens/search/mainSearch.dart';
import 'package:foodzer_customer_app/widget/navigationDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
 void initState()  {
    super.initState();
UserPreference().getUserData();
print(UserPreference().getUserData());
  }

  @override
  void dispose() async {
   UserPreference().removeUser();
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
        title:Column(
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
                  "Salwa Road Al Miqab",
                  style: TextStyle(
                      color:Colors.deepOrange,
                      fontSize: 16
                  ),
                )
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed:(){
              Navigator.of(context).pushNamed(MainSearchScreen.routeName);
            },
            icon: Icon(
              Icons.search,
              size: 24,
              color: Colors.black,
            ),
          )
        ],
      ),
      body:Body()
    );
  }
}


