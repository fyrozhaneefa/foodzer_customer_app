import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../Api/ApiData.dart';
import '../../../Models/CategoryModel.dart';


class CategoryCard extends StatefulWidget {
  final String cardImg, cardName;
  final press, color;
  const CategoryCard({
    Key? key, required this.cardImg, required this.cardName, this.press, this.color,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
         Material(
            child: InkWell(
              onTap: widget.press,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: Helper.getScreenWidth(context) * 0.4,

                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child:Image.network(
                          widget.cardImg
                      ),
                      flex: 3,
                    ),
                    Expanded(child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Text(
                          widget.cardName,
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