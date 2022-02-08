import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:foodzer_customer_app/widget/navigationDrawer.dart';

class UserOrdersScreen extends StatefulWidget {
  static const routeName = "/userOrders";
  const UserOrdersScreen({Key? key}) : super(key: key);

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
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
          'My orders',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 20
          ),
        ),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Image.network('https://www.fiverr.com/support/article_attachments/360020057898',
              fit: BoxFit.fill,),
            ),
            SizedBox(height: 10,),
            Text(
              'Orders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Login to see your orders',
              style: TextStyle(
                color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 20,right: 20),
              width: Helper.getScreenWidth(context),
              child: ElevatedButton(
                onPressed: (){

                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange.shade600,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),),
              ),
            )
          ],
        ),
      )
    );
  }
}
