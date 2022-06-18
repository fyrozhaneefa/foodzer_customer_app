import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class OtherCategoryCard extends StatefulWidget {
  final String? cardName,cardTime,cardType,rating,deliveryCharge,bannerName,discount,busy;
  final press;
  const OtherCategoryCard({
    Key? key,
    // required this.cardBanner,
    this.cardName,
    this.cardTime,
    this.cardType,
    this.rating,
    this.deliveryCharge,
    this.bannerName,
    this.discount,
    this.press,
    this.busy
  }) : super(key: key);

  @override
  State<OtherCategoryCard> createState() => _OtherCategoryCardState();
}

class _OtherCategoryCardState extends State<OtherCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: widget.press,
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          width: Helper.getScreenWidth(context)*0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10,right:10),
                height: 125,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,

                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                        imageUrl:widget.bannerName!,
                          errorWidget:
                              (context, url, error) =>
                              Image.asset(
                                Helper.getAssetName("blank.jpg", "virtual"),
                              )
                      ),
                      // Image.network(
                      //   widget.bannerName!,
                      //   fit: BoxFit.fill,
                      //   height: double.infinity,
                      //   width: double.infinity,
                      //   alignment: Alignment.center,
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
                      //     );
                      //   },
                      // ),
                      widget.busy =="1" ?Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'BUSY',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            backgroundBlendMode: BlendMode.darken
                        ),
                      ): SizedBox()
                    ],
                  ),
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
                          width: Helper.getScreenWidth(context)*0.45,
                          child: Text(
                            widget.cardName!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
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
                          Icon(Icons.access_time_outlined,
                            color: Colors.deepOrange,
                            size: 20,),
                          SizedBox(width: 5,),
                          Text(
                            'Within'+' '+widget.cardTime!+' ''mins',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                child:   Text(null!=widget.cardType?
                    widget.cardType.toString():"",
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Container(
                  child:  Row(
                    children: [
                      Icon(widget.rating == "No reviews yet" || widget.rating =="0"?
                      Icons.sentiment_dissatisfied:
                      Icons.tag_faces_outlined),
                      SizedBox(width: 5,),
                      Text(widget.rating! == "1"?"Bad":
                      widget.rating! == "2"?"OK":
                      widget.rating! == "3"?"Good":
                      widget.rating! == "4"?"Amazing":"No reviews yet",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(width: 25,),
                      Text(widget.deliveryCharge!.isNotEmpty?'Delivery:'+' '+widget.deliveryCharge!:"Delivery : ₹0",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),),
                    ],
                  )
              ),
              SizedBox(height: 5,),
              widget.discount!.isNotEmpty?Container(
                child: Row(
                  children: [
                    Icon(Icons.local_offer_outlined,
                      size: 20,
                      color: Colors.pinkAccent,),
                    SizedBox(width: 5,),
                    Text(widget.discount! +' '+'selected items',
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w600
                      ),),
                  ],
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}