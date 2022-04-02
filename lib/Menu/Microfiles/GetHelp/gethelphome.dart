
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/GetHelp/gethelptext.dart';
import 'package:foodzer_customer_app/Models/searchModel.dart';
import 'package:foodzer_customer_app/screens/search/mainSearch.dart';

class GetHelp extends StatelessWidget {
  const GetHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:InkWell(child: Icon(
          Icons.keyboard_backspace_outlined,
          color: Colors.black,
        ),
        onTap: (){
          Navigator.pop(context);
        },),
        title: Text(
          "Help",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body:SingleChildScrollView(child:  Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Container(
            child: Text(
              "You need a Foodzer aacount so we can help",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20,right: 10),
          child: Container(
            child: Text(
              Test().test,
              style: TextStyle(fontWeight: FontWeight.w500,
                  color: Colors.black,

                  ),
            ),
          ),
        ),


      ]),),
    bottomNavigationBar: BottomAppBar(child: ApplyButton(buttonname: "Login",radius: 5,)),);
  }
}
