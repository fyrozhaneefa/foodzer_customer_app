import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNearList.dart';


class PopularRestNearSection extends StatelessWidget {
  const PopularRestNearSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: 10.0, right: 20.0, bottom: 5.0, left: 20.0),
              child: Text(
                "Popular restaurants near you",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(height: 20),
          PopularRestNearList(),

        ],
      ),
    );
  }
}
