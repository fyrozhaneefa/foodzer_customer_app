import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'home/homeScreen.dart';

class OtpScreen extends StatefulWidget {
  String mobileNumber;

  OtpScreen(this.mobileNumber);

  // static const routeName = "/otpScreen";
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = new TextEditingController();
bool isLoading = false;


  late Timer _timer;
  int _start = 30;
  bool enableResend = false;
  @override
  initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      enableResend = false;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 30;
            enableResend = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
          icon: Icon(Icons.arrow_back, size: 26, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Verify OTP",
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
          padding: const EdgeInsets.only(top: 25.0, right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Helper.getScreenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VERIFY DETAILS",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "OTP sent to " + widget.mobileNumber.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
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
              Container(
                width: Helper.getScreenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ENTER OTP",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      controller: otpController,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,

                      obscureText: false,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      // validator: (v) {
                      //   if (v!.length < 3) {
                      //     return "Please enter valid code";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      pinTheme: PinTheme(
                        activeColor: Color(0xffDFF0FF),
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        shape: PinCodeFieldShape.underline,
                        activeFillColor: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        // activeFillColor: hasError ? Colors.blue.shade100 : Colors.white,
                      ),
                      cursorColor: Colors.green,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          // currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");

                        return true;
                      },
                    ),
                    // OTPTextField(
                    //     otpFieldStyle: OtpFieldStyle(
                    //         errorBorderColor: Colors.red,
                    //         enabledBorderColor: Colors.deepOrangeAccent,
                    //         focusBorderColor: Colors.green),
                    //     controller: otpController,
                    //     length: 6,
                    //     width: MediaQuery.of(context).size.width,
                    //     style: TextStyle(fontSize: 17),
                    //     textFieldAlignment: MainAxisAlignment.spaceAround,
                    //     fieldStyle: FieldStyle.underline,
                    //     onChanged: (pin) {
                    //       print("Changed: " + pin);
                    //     },
                    //     onCompleted: (pin) {
                    //       print("Completed: " + pin);
                    //     }),
                    SizedBox(
                      height: 30,
                    ),
                    enableResend
                        ? GestureDetector(
                            onTap: () {
                              startTimer();
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Resend OTP',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Text('Resend OTP in $_start seconds'),
                          ),
                    SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          verifyOtp();
                        },
                        child: Container(
                          child: Text(
                            "Continue",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  verifyOtp() async {
    setState(() {
      isLoading=true;
    });
    var formData =
        FormData.fromMap({"otp": otpController.text, "mobile": widget.mobileNumber});
    var response = await Dio().post(ApiData.VERIFY_OTP, data: formData);
    final responsebody = json.decode(response.data.toString());
    if(response.statusCode == 200){
      setState(() {
        isLoading=false;
      });
      if(responsebody['error'] == 0) {
          if(null!= responsebody['result']['register_id']){
            Fluttertoast.showToast(
                msg: "Login Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomeScreen()));
          } else {
            Fluttertoast.showToast(
                msg: "Something happened. Try again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
      } else{
        Fluttertoast.showToast(
            msg: "OTP you entered is wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }
}
