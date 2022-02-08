import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class CategoryCard extends StatelessWidget {
  final String cardImg, cardName;
  final press, color;
  const CategoryCard({
    Key? key, required this.cardImg, required this.cardName, this.press, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
         Material(
            child: InkWell(
              onTap: press,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: Helper.getScreenWidth(context) * 0.4,
                height: 160,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child:Image.network(
                          cardImg
                      ),
                      flex: 3,
                    ),
                    Expanded(child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Text(
                          cardName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                          ),
                        )
                    )

                    )
                  ],
                ),
              ),
            ),
          );
  }
}