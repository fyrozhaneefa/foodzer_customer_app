import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/basket/Section/moneycard.dart';

import '../../../utils/helper.dart';
class TipYourHungerSecond extends StatelessWidget {
  const TipYourHungerSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: Helper.getScreenWidth(context) * 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(),
              child: Text(
                "Thank your delivery partner by leaving them a tip.\n"
                    "100% of the tip will go to your delivery partner ",
                style: TextStyle(
                    fontSize: 13, color: Colors.grey[700]),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MoneyCard(
                  text: "₹20",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MoneyCard(
                  text: "₹30",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MoneyCard(
                  text: "₹50",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MoneyCard(
                  text: "₹Other",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
