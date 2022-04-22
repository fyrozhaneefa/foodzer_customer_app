import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class OrderPlacedHome extends StatelessWidget {
  const OrderPlacedHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height:  Helper.getScreenHeight(context) / 2,
                  width: Helper.getScreenWidth(context),
                  color: Colors.orange,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClipRRect(
                      child: Image(
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/742/742923.png"),
                          width: 150),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Your order has been confirmed",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white.withOpacity(.8),
                          fontWeight: FontWeight.w500),
                    )
                  ]),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image(
                            image: AssetImage(
                                "lib/Menu/Microfiles/assets/images/deliveryboy.png"),
                            width: 220),
                      ),
                      Text(
                        "Thank you...We are reviewing your\n                        order",
                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Helper.getScreenWidth(context),
                padding: EdgeInsets.all(20),child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>
                          HomeScreen()), (Route<dynamic> route) => false);
                },
                child: Text(
                  // "Track Your Order",
                  "Back to home",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.orange,
                  fixedSize: Size(155, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
// side: BorderSide(color: Colors.black.withOpacity(.3)),
                  ),
                ),
              ),),
            )
          ],
        )
    );
  }
}