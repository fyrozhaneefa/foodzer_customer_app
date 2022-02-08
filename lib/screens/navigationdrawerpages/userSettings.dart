import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/widget/navigationDrawer.dart';

class UserSettingsScreen extends StatefulWidget {
  static const routeName = "/userSettings";
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool isSwitched  = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade600),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20
          ),
        ),
        bottom:PreferredSize(
        preferredSize: Size(0.0, 40.0),
          child: Padding(
            padding: const EdgeInsets.only(left:20.0,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Colors.deepOrange.shade100,
                  activeColor: Colors.deepOrange.shade300,
                ),
              ],
            ),
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'English',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 30,thickness: 1,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'India',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
