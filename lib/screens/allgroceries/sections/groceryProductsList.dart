import 'package:flutter/material.dart';

import 'groceryProductDesc.dart';

class GroceryProductsList extends StatelessWidget {
  const GroceryProductsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top:10,bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12)),
                    width: 90,
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: Image.network(
                        'https://images.deliveryhero.io/image/talabat/restaurants/Monoprix_Logo_637418379384574132.jpg?',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(child: GroceryProductDesc())
                ],
              ),
            );
          }),
    );
  }
}