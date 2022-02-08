import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:foodzer_customer_app/screens/home/sections/groceryCard.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

import 'groceryCardList.dart';

class GroceriesSection extends StatelessWidget {
  const GroceriesSection({
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
              child: Row(
                children: [
                  Text(
                    "Groceries and more",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.deepOrange,
                  ),
                ],
              )),
          SizedBox(height: 20),
          GroceryCardList()

        ],
      ),
    );
  }
}
