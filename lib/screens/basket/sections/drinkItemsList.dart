import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/basket/sections/drinkItemsCard.dart';


class DrinkItemsList extends StatelessWidget {
  const DrinkItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding:  EdgeInsets.only(left: 20,right: 10),
        child: Row(
          children: [
            DrinkItemsCard(
              itemName: 'Red Bull Energy Drink',
              itemPrice: 'QR 27.00',
              itemImage: 'https://assets.stickpng.com/images/580b57fcd9996e24bc43c1e9.png',
            ),
            DrinkItemsCard(
              itemName: 'Red Bull Tropical',
              itemPrice: 'QR 25.00',
              itemImage: 'https://i.pinimg.com/originals/2a/d4/06/2ad40660a9dbeb80aa543ba61637b53a.png',
            ),
            DrinkItemsCard(
              itemName: 'Red Bull Zero 250 Ml',
              itemPrice: 'QR 23.00',
              itemImage: 'https://www.pngitem.com/pimgs/m/281-2819490_red-bull-energy-total-zero-hd-png-download.png',
            )
          ],
        ),
      ),
    );
  }
}