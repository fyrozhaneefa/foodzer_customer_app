import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/home/sections/popularBrandCard.dart';

class PopularBrandCardList extends StatelessWidget {
  const PopularBrandCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding:  EdgeInsets.only(left: 20,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://www.byswhk.com/uae/wp-content/uploads/sites/2/2020/05/Amigovio.png',
              brandName: 'AMIGOVIO - Mexican',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://www.byswhk.com/uae/wp-content/uploads/sites/2/2020/05/Amigovio.png',
              brandName: 'AMIGOVIO - Mexican',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
          ],
        ),
      ),
    );
  }
}


