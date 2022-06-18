import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/popularBrandModel.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:foodzer_customer_app/screens/home/sections/popularBrandCard.dart';

class PopularBrandCardList extends StatefulWidget {
  PopularBrandsModel popularBrandList;
  PopularBrandCardList(this.popularBrandList);



  @override
  State<PopularBrandCardList> createState() => _PopularBrandCardListState();
}

class _PopularBrandCardListState extends State<PopularBrandCardList> {



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding:  EdgeInsets.only(left: 20,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.popularBrandList.restaurantDetails!.map((item)=>PopularBrandCard(
              logo: item.merchantBranchImage,
              brandName: item.merchantBranchName,
              time: item.merchantBranchOrderTime,
              press: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        RestaurantDetailsScreen(item.merchantBranchId,item.lat,item.lng)));
              },
            )).toList()


          ],
        ),
      ),
    );
  }


}


