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
      padding: const EdgeInsets.only(left:20,top: 10),
      child:isLoading ? ShimmerWidget.rectangular(height: 100): Container(
        width: Helper.getScreenWidth(context)*0.22,
         decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              alignment: Alignment.topCenter,
                child: Image.network(serviceImage!,
                    fit: BoxFit.fill,
                  height: 40,
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                 serviceName!,
                  style: TextStyle(
                    fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.2
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}