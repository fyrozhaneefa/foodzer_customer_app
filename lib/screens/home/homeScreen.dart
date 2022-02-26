import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/sections/body.dart';
import 'package:foodzer_customer_app/screens/search/mainSearch.dart';
import 'package:foodzer_customer_app/widget/navigationDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/application_bloc.dart';



class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
void initState()  {
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    //   applicationBloc.getDashboardResult();    });

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
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            GoogleMapScreen()));
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
                  finalAddress,
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


