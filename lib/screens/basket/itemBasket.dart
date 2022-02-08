import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/basket/sections/basketItemsList.dart';
import 'package:foodzer_customer_app/screens/basket/sections/drinkItems.dart';
import 'package:foodzer_customer_app/screens/basket/sections/paymentSummery.dart';
import 'package:foodzer_customer_app/screens/basket/sections/specialRequest.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class ItemBasketScreen extends StatefulWidget {
  static const routeName = "/itemBasket";

  @override
  State<ItemBasketScreen> createState() => _ItemBasketScreenState();
}

class _ItemBasketScreenState extends State<ItemBasketScreen> {
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Basket',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Snacky (Al Hilal West)',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Helper.getScreenHeight(context)*0.75,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasketItemsList(),
                  DrinkItems(),
                  SpecialRequest(),
                  PaymentSummery(),
                ],
              ),
            ),
          ),
          Container(
            height: Helper.getScreenHeight(context)*0.12,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade400)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed:(){

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Add items',
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(6), // <-- Radius
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed:(){

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // <-- Radius
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

