import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '/screens/loginScreen.dart';
import '../utils/helper.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "/landingScreen";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isFromCart = false;

  String? userName;

  @override
  void initState() {
    checkUpdate();
    super.initState();
  }
  checkUpdate() async {
    final newVersion = NewVersionPlus();
    var status = await newVersion.getVersionStatus();
    if(status!.canUpdate){
      showUpdateDialog(context: context, versionStatus: status,
          allowDismissal: false);
    }

  }
  static void showUpdateDialog({
    required BuildContext context,
    required VersionStatus versionStatus,
    String dialogTitle = 'Update Available',
    String? dialogText,
    String updateButtonText = 'Update',
    bool allowDismissal = true,
    String dismissButtonText = 'Maybe Later',
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(dialogTitle);
    final dialogTextWidget = Text(
      dialogText ??
          'You can now update this app from ${versionStatus.localVersion} to ${versionStatus.storeVersion}',
    );
    final updateButtonTextWidget = Text(updateButtonText);

    List<Widget> actions = [
      Platform.isAndroid
          ? TextButton(
        onPressed: () async {
          await launchUrl(Uri.parse(versionStatus.appStoreLink),
              mode: LaunchMode.externalApplication);
        },
        child: updateButtonTextWidget,
      )
          : CupertinoDialogAction(
        onPressed: () async {
          await launchUrl(Uri.parse(versionStatus.appStoreLink),
              mode: LaunchMode.externalApplication);
        },
        child: updateButtonTextWidget,
      ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText);
      dismissAction = dismissAction ??
              () => Navigator.of(context, rootNavigator: true).pop();
      actions.add(
        Platform.isAndroid
            ? TextButton(
          onPressed: dismissAction,
          child: dismissButtonTextWidget,
        )
            : CupertinoDialogAction(
          onPressed: dismissAction,
          child: dismissButtonTextWidget,
        ),
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: allowDismissal,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            )
                : CupertinoAlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(allowDismissal));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            size: 26,
            color: Colors.black,)
          , onPressed: () {  },),
        title: Text(
          "Log in",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Helper.getScreenWidth(context),
              height: Helper.getScreenHeight(context) *0.3,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(Helper.getAssetName("template.png", "virtual")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0, left:20.0, right: 20.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                        child: Text(
                          "Login or create an account",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top:15.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Login or create an account to receive rewards and save your details for a faster checkout experience",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // UserModel userModel = new UserModel();
                          // userModel.userType = "GUEST";
                          // UserPreference().setUserData(userModel);
                          // setState(() {
                          //
                          // });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GoogleMapScreen(new AddressModel(),isFromCart, LatLng(0, 0))));

                        },
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {

                                },
                                icon: Icon(Icons.person,
                                size: 30,
                                color: Colors.deepOrangeAccent,),
                              ),
                            ),
                        Container(
                          alignment: Alignment.center,
                                child:  Text("Continue as a Guest",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600
                                  ),),
                              )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary:Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(isFromCart)));
                        },
                        child: Stack(
                          children: [
                          Container(
                            alignment: Alignment.centerLeft,
                              child:IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.phone_iphone,
                                  size: 30,
                                color: Colors.deepOrangeAccent,),
                              )
                          ),
                            Container(
                              alignment: Alignment.center,
                              child:  Text("Continue with Mobile",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600
                                ),),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary:Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

}
