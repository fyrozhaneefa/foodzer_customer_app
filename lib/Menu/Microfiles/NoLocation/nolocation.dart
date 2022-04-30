import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class ChangeLocation extends StatelessWidget {
  const ChangeLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Deira",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            )
          ],
        ),
        actions: [
          ClipRRect(
            child: Image(
              image: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/879/879757.png"),
              width: 18,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 22, left: 5, right: 10),
            child: Text(
              "Offers",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          )
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
          child: Container(
            width: Helper.getScreenWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/real/nolocation1.jpg"),
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text("We are not present ath this loaction yet! We will let you know as\n\n                                     soon as we are here ",style: TextStyle(fontSize: 12),),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "CHANGE LOCATION",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  fixedSize: Size(200, 40),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
