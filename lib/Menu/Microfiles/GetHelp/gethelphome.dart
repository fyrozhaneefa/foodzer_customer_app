import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';

class GetHelp extends StatefulWidget {
  const GetHelp({Key? key}) : super(key: key);

  @override
  State<GetHelp> createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> {
  bool isLoggedIn = false;
  UserData userModel = new UserData();

  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      if (null != value.userId && value.userId!.isNotEmpty) {
        userModel = value;
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Help",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: !isLoggedIn
          ? guestUser()
          : Center(
              child: Text(
                "Coming Soon!!!",
                style: TextStyle(color: Colors.red),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
          child: ApplyButton(
        buttonname: !isLoggedIn?"Login":"Back to home",
        radius: 5,
      )),
    );
  }
}

Widget guestUser() {
  return Column(children: [
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
      padding: EdgeInsets.only(top: 20, left: 20, right: 10),
      child: Container(
        child: Text(
          "We noticed that you are a guest user, and as much as we are happy with your visit and order, we need you to register to create your own account with Talabat so we can serve you better.\n\n\nIf you create your own account with Foodzer using the same phone number you placed your guest order with, our systems will automatically connect all your current and previous orders you placed using that phone number, and we will be able to help and support you instantly.\n\n\nAfter few easy registration steps, you will be able to unlock the full potential of your account by benefiting from all the discounts and promotions we offer, enjoy our loyality and subscription programs, as well as enjoying the best experience we can offer you!",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    ),
  ]);
}
