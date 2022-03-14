import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final String? title;
  final  press;
 final dynamic color;
 final dynamic textColor;
  const ProductCategory({
    Key? key,
   this.title,
    // this.isActive = false,
   this.press,
  this.color,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        GestureDetector(
          onTap: press,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10) ,
                decoration: BoxDecoration(
                  color:color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(title.toString(),
                    style:TextStyle(
                        color:textColor,
                        fontWeight: FontWeight.w600
                    )),
              ),
              // if(isActive)
              //   Container(
              //   margin: EdgeInsets.symmetric(vertical:10 ),
              //   height:3,
              //   width: 100,
              //   decoration: BoxDecoration(
              //       color:color
              //   ),
              // )
            ],
          ),
        );

  }
}