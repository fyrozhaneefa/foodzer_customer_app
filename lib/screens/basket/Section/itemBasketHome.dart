import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/basket/Section/proceedToPay.dart';

import 'package:foodzer_customer_app/screens/basket/Section/savedcontainer.dart';
import 'package:foodzer_customer_app/screens/basket/Section/tipyourHungerSavior.dart';

import 'billDetails.dart';
import 'deliveryInstructions.dart';
import 'headerCard.dart';

class ItemBaskethome extends StatefulWidget {
  const ItemBaskethome({Key? key}) : super(key: key);

  @override
  _ItemBaskethomeState createState() => _ItemBaskethomeState();
}

class _ItemBaskethomeState extends State<ItemBaskethome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){

          Navigator.of(context).pop();
        },icon:Icon(Icons.keyboard_backspace_outlined,
            color: Colors.black.withOpacity(.5), size: 30)),
        title: Text("Kuttichira Biriyani",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 15),
                      child: BasketHeader()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                        child: Text(
                          "Offers & Benefits",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: SavedContainer(
                      child: ListTile(
                        title: Text(
                          "Apply Coupon",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_rounded, size: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Text(
                      "Tip Your hunger saviour",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: TipYourHungerSecond(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Text(
                      "Delivery instructions",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DeliveryInstructions(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Text(
                      "Bill Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 50),
                      child: BillDetails()),
                ],
              ),
            ),
            ProceedToPay(),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
