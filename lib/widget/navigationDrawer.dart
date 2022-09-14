import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/EditAccountSection/editaccount.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/GetHelp/gethelphome.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/GetHelp/gethelptext.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection//myAccountHome.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection/myoders.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OfferSection/offerHome.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
// import 'package:foodzer_customer_app/screens/home/components/test.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/foodzerPay.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/userOrders.dart';
import 'package:foodzer_customer_app/screens/navigationdrawerpages/userSettings.dart';

class NavigationDrawerWidget extends StatefulWidget {
  // String? userName;
  // NavigationDrawerWidget(this.userName);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  String userName= "";

  @override
  void initState() {
    getUserName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 80,
              child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(children: [
                    Positioned(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)
                          ),
                          child: Icon(Icons.person,
                          size: 20,),
                        )),
                    Positioned(
                      left: 65.0,
                      child:InkWell(onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAccount()));

                      }


                      ,child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(userName== ""?
                              'HI GUEST':'Hi $userName',
                            // 'Hi ${{widget.userName!}}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                child:ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Flag_of_India.png',
                                    fit: BoxFit.fill,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8,),
                              Container(
                                child: Text(
                                    'INDIA',
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right:0,
                      child: Container(
                        child: IconButton(
                           icon: Icon(Icons.settings_outlined,
                           color: Colors.black,
                           size:30),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserSettingsScreen()));
                          },
                        ),
                      ),
                    )
                  ]),
              ),
            ),
            buildMenuItem(
                text: 'Home',
                icon: Icons.home_outlined,
                onClicked:() => selectedItem(context, 0)
            ),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'Your orders',
                icon: Icons.article_outlined,
                // onClicked:() => selectedItem(context, 1)
                onClicked:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrders())),

            ),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'Offers',
                icon: Icons.local_offer_outlined,
                // onClicked:() => selectedItem(context, 2)
              onClicked:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferSection())),

            ),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'Notifications',
                icon: Icons.notifications_none_outlined,
                onClicked:() => selectedItem(context, 3)
            ),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'Foodzer pay',
                icon: Icons.payment_outlined,
                onClicked:() => selectedItem(context, 4)
            ),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'Get help',
                icon: Icons.help_outline_outlined,
                // onClicked:() => selectedItem(context, 5)
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetHelp()))
            ),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'About',
                icon: Icons.perm_device_information_rounded,
                onClicked:() => selectedItem(context, 6)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final iconColor = Colors.grey.shade700;
    final color = Colors.black;
    final hoverColor = Colors.deepOrange.shade50;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text,
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserOrdersScreen()));
        break;
      case 2:
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 3:
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodzerPayScreen()));
        break;
      case 5:
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 6:
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 7:
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
    }
  }
  getUserName(){
    UserPreference().getUserData().then((value)=>{
      userName = null!=value?value.userName!:"",
      setState(() {

      })
    });
}
}
