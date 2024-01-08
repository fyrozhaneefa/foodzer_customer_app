import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class RestaurantServices extends StatelessWidget {
  final String? serviceImage, serviceName;
  final bool isLoading;
  const RestaurantServices({
    Key? key, this.serviceImage, this.serviceName,this.isLoading=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,),
      child:isLoading ? ShimmerWidget.rectangular(height: 100): Container(


        child: Padding(
          padding: const EdgeInsets.only(left: 10,right:4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                        imageUrl:serviceImage!,
                        height: 110,width: 90,
                        errorWidget:
                            (context, url, error) =>
                            Image.asset(
                              Helper.getAssetName("blank.jpg", "virtual"),
                            )
                    ),
                    // Image.network(serviceImage!,
                    //     fit: BoxFit.fill,
                    //   height: 110,width: 90,
                    // ),
                    SizedBox(height: 10,),
                    Positioned(bottom: 10,left: 5,right: 5,
                      child: Center(
                        child: Text(
                          serviceName!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.2
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}