import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class DrinkItemsCard extends StatelessWidget {
  final String? itemName, itemPrice, itemImage;
  const DrinkItemsCard({
    Key? key, this.itemName, this.itemPrice, this.itemImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        width: Helper.getScreenWidth(context) * 0.7,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName!,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        itemPrice!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              flex: 3,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  height: 70,
                  width: 70,
                  child: Image.network(
                    itemImage!,
                    fit: BoxFit.fill,
                  )),
            )
          ],
        )
    );
  }
}
