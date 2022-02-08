import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurantServicesCard.dart';

class RestaurantServicesList extends StatelessWidget {
  const RestaurantServicesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0,bottom: 25.0),
        child: Row(
          children: [
            RestaurantServices(
              serviceImage: 'https://seeklogo.com/images/F/free-delivery-logo-3F8F5B428D-seeklogo.com.png',
              serviceName: 'Free -3 delivery',
            ),
            RestaurantServices(
              serviceImage: 'https://seeklogo.com/images/C/cream-for-dessert-logo-ED8864E8F2-seeklogo.com.png',
              serviceName: 'Desserts',
            ),
            RestaurantServices(
              serviceImage: 'https://seeklogo.com/images/F/free-delivery-logo-3F8F5B428D-seeklogo.com.png',
              serviceName: '+974',
            ),
            RestaurantServices(
              serviceImage: 'https://seeklogo.com/images/F/free-delivery-logo-3F8F5B428D-seeklogo.com.png',
              serviceName: 'Newly Added',
            ),
            RestaurantServices(
              serviceImage: 'https://seeklogo.com/images/F/free-delivery-logo-3F8F5B428D-seeklogo.com.png',
              serviceName: 'Tiktok dishes',
            ),
          ],
        ),
      ),
    );
  }
}