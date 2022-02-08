import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allgroceries/sections/storeTypesCard.dart';


class StoreTypeSection extends StatelessWidget {

  const StoreTypeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Text(
              'Shop by store type',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 20.0),
            child: Row(
              children: [
                StoreTypesCard(storeTypes: 'Supermarkets',press: (){},),
                StoreTypesCard(storeTypes: 'Convenience Stores'),
                StoreTypesCard(storeTypes: 'Fruits & Vegetables'),
                StoreTypesCard(storeTypes: 'Fresh Meat & Fish'),
                StoreTypesCard(storeTypes: 'Nuts & Dried Fruit'),
                StoreTypesCard(storeTypes: 'Coffee & Tea'),

              ],
            ),
          ),
        )
      ],
    );
  }
}

