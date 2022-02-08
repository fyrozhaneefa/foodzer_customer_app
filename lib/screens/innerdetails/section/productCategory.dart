import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final String title;
  final bool isActive;
  final  press;
  const ProductCategory({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(title,
                    style:TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    )),
                if(isActive)
                  Container(
                  margin: EdgeInsets.symmetric(vertical:10 ),
                  height:3,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange
                  ),
                )
              ],
            ),
          ),
        );

  }
}