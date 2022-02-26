import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../Api/ApiData.dart';
import '../../../Models/CategoryModel.dart';

class CategoryCard extends StatefulWidget {
  final String? cardImg, cardName;
  final press, color;
  const CategoryCard({
    Key? key,
    this.cardImg,
    this.cardName,
    this.press,
    this.color,
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
    return Material(
      child: InkWell(
        onTap: widget.press,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          width: Helper.getScreenWidth(context) * 0.4,

          // padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                  child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(widget.cardImg!,
                      fit:BoxFit.fill,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          backgroundBlendMode: BlendMode.darken
                      ),
                    padding: EdgeInsets.only(left: 15,bottom: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.cardName!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
