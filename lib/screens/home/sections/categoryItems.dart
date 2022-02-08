import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/allgroceries/AllGroceries.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/allRestaurants.dart';

import 'categoryCard.dart';
class CategoryItems extends StatelessWidget {
  const CategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 10),
        child: Row(
          children: [
            CategoryCard(
              color: Colors.deepOrange,
              cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
              cardName: 'Food',
              press: (){
                Navigator.of(context).pushNamed(AllRestaurantsScreen.routeName);
              },),
            CategoryCard(
              color: Colors.teal.shade400,
              cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
              cardName: 'Groceries',
              press: (){
                Navigator.of(context).pushNamed(AllGroceriesScreen.routeName);
              },),
            CategoryCard(
              color: Colors.red,
              cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
              cardName: 'Flowers',
              press: (){
                Navigator.of(context).pushNamed(AllFlowersScreen.routeName);
              },),
            CategoryCard(
              color: Colors.blue,
              cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
              cardName: 'Health & wellness',
              press: (){
                print("Health & wellness printed");
              },),
            CategoryCard(
              color: Colors.indigo,
              cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
              cardName: 'More',
              press: (){
                print("more");
              },)
          ],
        ),
      ),
    );
  }
}