import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home/homeScreen.dart';
import '../utils/helper.dart';
import 'otpValidation.dart';import 'package:http/http.dart' as http;


class RegisterScreen extends StatefulWidget {
  static const routeName = "/registerScreen";
  String mobileNumber;
  RegisterScreen(this.mobileNumber);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 26, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrangeAccent,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, right: 20.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Helper.getScreenWidth(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Create an account with the new phone number",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.mobileNumber.toString(),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.lightGreen,
                              size: 15,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2.0),
                            ),
                            labelText: '10 digit mobile number',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            counterText: "",
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2.0),
                            ),
                            labelText: 'Email address',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            counterText: "",
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2.0),
                            ),
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            registerUser();
                            // if(emailController.text.isNotEmpty &&
                            //     emailController.text.length > 0){
                            //   if ( nameController.text.isNotEmpty && nameController.text.length > 0) {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             OtpScreen(widget.mobileNumber)));
                            //   } else {
                            //     Fluttertoast.showToast(
                            //         msg: "Please enter name ",
                            //         toastLength: Toast.LENGTH_SHORT,
                            //         gravity: ToastGravity.CENTER,
                            //         timeInSecForIosWeb: 1,
                            //         backgroundColor: Colors.red,
                            //         textColor: Colors.white,
                            //         fontSize: 16.0);
                            //   }
                            // } else {
                            //   Fluttertoast.showToast(
                            //       msg: "Please enter email address",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.CENTER,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.red,
                            //       textColor: Colors.white,
                            //       fontSize: 16.0);
                            // }
                          },
                          child: Container(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                // side: BorderSide(color: Colors.grey)
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  registerUser() async {
    setState(() {
      isLoading = true;
    });
    if (emailController.text.isNotEmpty && emailController.text.length > 0) {
      if (nameController.text.isNotEmpty && nameController.text.length > 0) {
        var formData = {
          "firstname": nameController.text,
          "email": emailController.text,
          "mob_no": widget.mobileNumber,
          "password": '123456'
        };
        var response = await http.post(Uri.parse(ApiData.REGISTER_USER),
            body: formData);
        String responseData=response.body.toString();

        final responsebody = json.decode(responseData);
        if (responsebody['error_code'] == 0) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  OtpScreen(widget.mobileNumber)));
        } else {
          Fluttertoast.showToast(
              msg: "Failed to register",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please enter name ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter email address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
