import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';

import 'groceryCard.dart';

class GroceryCardList extends StatelessWidget {
  const GroceryCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding:  EdgeInsets.only(left: 20,right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroceryCard(
                cardName: 'QKO Asian',
                cardTime: '25',
                cardType: 'Grocery',
                cardSubType: 'Supermarket',
                rating: 'Very good',
                deliveryCharge: 'AED 4.00',
                bannerName: 'https://png.pngtree.com/thumb_back/fh260/back_our/20190620/ourmid/pngtree-food-seasoning-food-banner-image_169169.jpg',
                discount: '34% off',
                press: (){
                  Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                },
              ),
              GroceryCard(
                cardName: 'foodzer mart',
                cardTime: '20',
                cardType: 'Grocery',
                cardSubType: 'Convenience store',
                rating: 'Amazing',
                deliveryCharge: 'AED 5.00',
                bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
                discount: '45% off',
                press: (){
                  Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                },
              ),
              GroceryCard(
                cardName: 'Lella, Downtown Burj Khalifa',
                cardTime: '20',
                cardType: 'Grocery',
                cardSubType: 'Convenience store',
                rating: 'Amazing',
                deliveryCharge: 'AED 5.00',
                bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
                discount: '30% off',
                press: (){
                  Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                },
              ),
              GroceryCard(
                cardName: 'foodzer mart',
                cardTime: '20',
                cardType: 'Grocery',
                cardSubType: 'Convenience store',
                rating: 'Amazing',
                deliveryCharge: 'AED 5.00',
                bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
                discount: '30% off',
                press: (){
                  Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                },
              ),
              GroceryCard(
                cardName: 'foodzer mart',
                cardTime: '20',
                cardType: 'Grocery',
                cardSubType: 'Convenience store',
                rating: 'Amazing',
                deliveryCharge: 'AED 5.00',
                bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
                discount: '40% off',
                press: (){
                  Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                },
              ),
              GroceryCard(
                cardName: 'foodzer mart',
                cardTime: '20',
                cardType: 'Grocery',
                cardSubType: 'Convenience store',
                rating: 'Amazing',
                deliveryCharge: 'AED 5.00',
                bannerName: 'https://files.muzli.space/30890e1b85267b0ed9a75ff0eb2b2a90.jpeg',
                discount: '50% off',
                press: (){
                  Navigator.of(context).pushNamed(RestaurantDetailsScreen.routeName);
                },
              ),
            ],
          ),
        ),
      );

  }
}