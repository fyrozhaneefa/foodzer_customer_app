import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/basket/sections/drinkItemsCard.dart';
import 'package:foodzer_customer_app/screens/basket/sections/drinkItemsList.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class DrinkItems extends StatefulWidget {
  const DrinkItems({Key? key}) : super(key: key);

  @override
  _DrinkItemsState createState() => _DrinkItemsState();
}

class _DrinkItemsState extends State<DrinkItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:20.0,right:20.0,bottom: 10.0),
          child: Row(
            children: [
               Container(
                  width: 60,
                  child: Image.network('https://logos-world.net/wp-content/uploads/2020/11/Red-Bull-Emblem.png',
                  fit: BoxFit.fill,
                  ),
                ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Text(
                    'Need a boost? We have the solution',
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        DrinkItemsList(),
        SizedBox(height:25),
        Divider(),
      ],
    );
  }
}


