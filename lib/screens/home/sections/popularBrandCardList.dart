import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/popularBrandModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:foodzer_customer_app/screens/home/sections/popularBrandCard.dart';

class PopularBrandCardList extends StatefulWidget {
  const PopularBrandCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularBrandCardList> createState() => _PopularBrandCardListState();
}

class _PopularBrandCardListState extends State<PopularBrandCardList> {

  List<PopularBrandsModel> popularBrandList =[];

  @override
  void initState() {
    // getPopularBrands();
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
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://www.byswhk.com/uae/wp-content/uploads/sites/2/2020/05/Amigovio.png',
              brandName: 'AMIGOVIO - Mexican',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://www.byswhk.com/uae/wp-content/uploads/sites/2/2020/05/Amigovio.png',
              brandName: 'AMIGOVIO - Mexican',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
            PopularBrandCard(
              logo: 'https://download.logo.wine/logo/IHOP/IHOP-Logo.wine.png',
              brandName: 'IHOP',
              time: '37 mins',
              press: (){
                print('item printed');
              },
            ),
          ],
        ),
      ),
    );
  }

  // getPopularBrands() async {
  //
  //   var map = new Map<String, dynamic>();
  //   map['lat'] = '10.9760357';
  //   map['lng'] = '76.22544309999999';
  //   var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
  //   var json = convert.jsonDecode(response.body);
  //   if(json['error_code'] == 0){
  //     // List dataList = json['other_categories'];
  //     var data = convert.jsonDecode(json['other_categories']);
  //     List dataList = data['restaurant_details'];
  //     // List BrandList = dataList['restaurant_details'];
  //     if(null!= dataList && dataList.length >0){
  //       popularBrandList =dataList.map((spacecraft) => new PopularBrandsModel.fromJson(spacecraft)).toList();
  //     }
  //     setState(() {
  //
  //     });
  //   } else{
  //     print("some error occured!!!");
  //   }
  //
  //
  // }
}


