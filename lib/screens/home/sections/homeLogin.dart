import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AppProvider.dart';
import '../../loginScreen.dart';

class loginSection extends StatefulWidget {
  @override
  State<loginSection> createState() => _loginSectionState();
}

class _loginSectionState extends State<loginSection> {

  bool isLoggedIn = false;
  bool isFromCart = false;
  @override
  void initState() {

    super.initState();
    UserPreference().getUserData().then((value) => {
      if(null!= value.userId){
        setState(() {
      isLoggedIn = true;
    })
      }else{
        setState(() {
          isLoggedIn = false;
        })
      }
    });

  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoggedIn?Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.deepOrange.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Colors.grey.shade300
          )
      ),
      child: Column(
        children: [
          Container(
            margin:EdgeInsets.only(left:20,top: 15,bottom: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.deepOrange,
                  child:Icon(Icons.person,color: Colors.white,)
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Text(
                    "Log in or create an account for a faster ordering experience",
                    style: TextStyle(
                      height: 1.5
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Helper.getScreenWidth(context),
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LoginScreen(isFromCart)));
              },
              child: Container(
                child:  Text("Login",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              style: ElevatedButton.styleFrom(
                  primary:Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)
                    ),
                    // side: BorderSide(color: Colors.grey)
                  )
              ),
            ),
          )
        ],
      ),
    )
    :Container(
     margin: EdgeInsets.only(bottom: 15.0),
    );
  }
  // getUserData() async{
  //
  //   SharedPreferences prefs= await SharedPreferences.getInstance();
  //   var user= prefs.getString('userData');
  //   if(null!= user) {
  //
  //     setState(() {
  //       isLoggedIn = true;
  //     });
  //   }else{
  //     setState(() {
  //       isLoggedIn = false;
  //     });
  //   }
  // }

}