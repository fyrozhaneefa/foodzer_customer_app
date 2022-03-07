import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/popularBrandModel.dart';
import 'package:foodzer_customer_app/screens/home/sections/OtherCategoryCardList.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class OtherCategoriesSection extends StatefulWidget {
  const OtherCategoriesSection({
    Key? key,
  }) : super(key: key);

  @override
  State<OtherCategoriesSection> createState() => _OtherCategoriesSectionState();
}

class _OtherCategoriesSectionState extends State<OtherCategoriesSection> {

  List<PopularBrandsModel> popularBrandModelList = [];


  @override
  void initState() {
    getOtherCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: popularBrandModelList.length,
          itemBuilder: (context, index) {
            PopularBrandsModel categoryItem= popularBrandModelList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: 10.0, right: 20.0, bottom: 5.0, left: 20.0),
                    child: Text(
                      // "Popular restaurants near you",
                      categoryItem.categoryName!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                    )),
                SizedBox(height: 20),

                OtherCategoryCardList(categoryItem)

              ],
            );
          })
    );
  }
getOtherCategories() async {

  var map = new Map<String, dynamic>();
  map['lat'] = '10.9760357';
  map['lng'] = '76.22544309999999';
  var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
  var json = convert.jsonDecode(response.body);
  if(json['error_code'] == 0){
    List dataList = json['other_categories'];
    if(null!= dataList && dataList.length >0){
      popularBrandModelList =dataList.map((spacecraft) => new PopularBrandsModel.fromJson(spacecraft)).toList();
    }
    setState(() {

    });
  } else{
    print("some error occured!!!");
  }


}
}
