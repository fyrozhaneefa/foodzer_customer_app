import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:foodzer_customer_app/utils/helper.dart';

class ItemCard extends StatelessWidget {
  ItemCard({Key? key,required this.itemName,required this.itemImage}) : super(key: key);

  String itemImage;
  String itemName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 30, left: 20, bottom: 30, right: 10),
              child: Container(
                height: 120,
                width: Helper.getScreenWidth(context) * .28,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    child: Image(
                        image: NetworkImage(
                          itemImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 30,
              right: 20,
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.white,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "50% OFF",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ". UPTO ₹80 .",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    itemName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.star_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 5),
                  child: Text(
                    "3.8",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 5),
                  child: Text(
                    ". 35 mins .",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 5),
                  child: Text(
                    "₹400 for two",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 5),
              child: Text(
                "American,Snacks,Biriyani",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 5),
              child: Text(
                "Rp Mall Calicut",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),

          ],
        ),

      ],
    );
  }
}
