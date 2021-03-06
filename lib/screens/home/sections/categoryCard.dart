import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
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
          width: Helper.getScreenWidth(context) * 0.28,
          // padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 115,
                  child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: CachedNetworkImage(
                        fit:BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                        filterQuality: FilterQuality.high,
                        imageUrl:widget.cardImg!,
                        errorWidget:
                            (context, url, error) =>
                            Image.asset(
                              Helper.getAssetName("blank.jpg", "virtual"),
                            )
                        ),
                    // Image.network(widget.cardImg!,
                    //   width: double.infinity,
                    //   fit:BoxFit.cover,
                    //   height: double.infinity,
                    //   loadingBuilder: (BuildContext context, Widget child,
                    //       ImageChunkEvent? loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return
                    //     ShimmerWidget.rectangular(height: 150,value: loadingProgress.expectedTotalBytes != null
                    //         ? loadingProgress.cumulativeBytesLoaded /
                    //         loadingProgress.expectedTotalBytes!
                    //         : null,);
                    //   },
                    // ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black.withOpacity(0.1),
                          backgroundBlendMode: BlendMode.darken
                      ),
                    padding: EdgeInsets.only(left: 15,bottom: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.cardName!,
                        style: TextStyle(
                            color: Colors.white,
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
