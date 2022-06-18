

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzer_customer_app/screens/otpValidation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './forgotPassword.dart';
import './registerScreen.dart';
import '../utils/helper.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'home/homeScreen.dart';
import 'locationGoogle.dart';

class LoginScreen extends StatefulWidget {
  bool isFromCart;
  LoginScreen(this.isFromCart);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileController = new TextEditingController();
bool isLoading = false;


  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              size: 26,
              color: Colors.black),
             onPressed: () {
              Navigator.pop(context);
          },),
          title: Text(
            "Log in",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
    body: isLoading?Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrangeAccent,
      ),
    ):SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:25.0, right:20.0,left:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
                width: Helper.getScreenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Continue with Mobile",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height:5),
                    Text(
                      "Enter your mobile number to proceed",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 50,),

            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,

              controller: mobileController,
              decoration: InputDecoration(
                counterText: "",
                fillColor: Colors.white,
                focusedBorder:UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                ),
               // prefixText: '+91',
                labelText: '10 digit mobile number',
                labelStyle: TextStyle(
                  color: Colors.grey
                )
              ),
            ),

            SizedBox(height: 30,),

            Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext context) =>
                  //         LocationScreen()));
                  if(mobileController.text.isNotEmpty && mobileController.text.length ==10){
                    checkUserAvailable();
                  } else{
                    Fluttertoast.showToast(
                        msg: "Please enter a valid mobile number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }

                },
                child: Container(
                      child:  Text("Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                style: ElevatedButton.styleFrom(
                    primary:Colors.deepOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        // side: BorderSide(color: Colors.grey)
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }



  checkUserAvailable() async {
    setState(() {
      isLoading =true;
    });
    var formData = FormData.fromMap({
      "mobile": mobileController.text
    });
    var response = await Dio().post(ApiData.CHECKMOBILE, data: formData);
    if(response.statusCode == 200){
      setState(() {
        isLoading = false;
      });
      final responsebody = json.decode(response.data.toString());
      if(responsebody['login_status'] == '1'){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                RegisterScreen(mobileController.text,widget.isFromCart)));
      } else {
        final resData = responsebody['data'];
        String userJson = jsonEncode(resData);
        // userData userModel = userData.fromJson(jsonDecode(userJson));
        UserPreference().setUserData(userJson);
        UserPreference().getUserData().then((value)=>{
          if(null!=value.userMobie && value.userMobie!.isNotEmpty){
            Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                OtpScreen(value.userMobie.toString(),widget.isFromCart)))
          } else{
            print("user data is not stored")
          }
        });

      }
    }
  }
}
