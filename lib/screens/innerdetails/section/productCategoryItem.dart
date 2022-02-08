import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategory.dart';

class ProductCategoryItem extends StatelessWidget {
  const ProductCategoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.menu,
                color: Colors.deepOrange),
            ProductCategory(
              title:'Fresh and Frozen',
              isActive: true,
              press: (){
                print('asdha');
              },
            ),
            ProductCategory(
              title:'Dairy And Beverages',
              press: (){
                print('asdha');
              },
            ),
            ProductCategory(
              title:'Fruits And Vegetables',
              press: (){
                print('asdha');
              },
            ),
          ]
      ),
    );
  }
}
