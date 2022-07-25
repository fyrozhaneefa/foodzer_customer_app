import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class PopularRestNearCard extends StatelessWidget {
  final  cardName,
      cardTime,
      cardType,
      cardSubType,
      rating,
      deliveryCharge,
      bannerName,
      discount;
  final press;
  final isLoading;
  const PopularRestNearCard({
    Key? key,
    // required this.cardBanner,
    this.isLoading =true,
    required this.cardName,
    required this.cardTime,
    required this.cardType,
    required this.cardSubType,
    required this.rating,
    required this.deliveryCharge,
    required this.bannerName,
    required this.discount,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          width: Helper.getScreenWidth(context) * 0.85,
          height: 125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10, right: 10),
                height: 125,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:   CachedNetworkImage(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    imageUrl: bannerName,
                      errorWidget:
                          (context, url, error) =>
                          Image.asset(
                            Helper.getAssetName("blank.jpg", "virtual"),
                          )
                  ),
                  // Image.network(
                  //   bannerName,
                  //   fit: BoxFit.fill,
                  //   loadingBuilder: (BuildContext context, Widget child,
                  //       ImageChunkEvent? loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return Center(
                  //       child: CircularProgressIndicator(
                  //         color: Colors.deepOrangeAccent,
                  //         value: loadingProgress.expectedTotalBytes != null
                  //             ? loadingProgress.cumulativeBytesLoaded /
                  //             loadingProgress.expectedTotalBytes!
                  //             : null,
                  //       ),
                  //
                  //     );
                  //   },
                  //   height: double.infinity,
                  //   width: double.infinity,
                  //   alignment: Alignment.center,
                  // ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Helper.getScreenWidth(context) * 0.45,
                          child: Text(
                            cardName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Within' + ' ' + cardTime + ' ' 'mins',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text(
                    cardType + ',' + ' ' + cardSubType,
                  style: TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis
                  ),

                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(rating == "No reviews yet" || rating =="0"?
                      Icons.sentiment_dissatisfied:
                      Icons.tag_faces_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(rating == "1"?"Bad":
                      rating == "2"?"OK":
                      rating == "3"?"Good":
                      rating == "4"?"Amazing":"No reviews yet",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'Delivery:' + ' ' + deliveryCharge,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),

                  ],)



                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
