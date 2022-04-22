import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/popularBrandModel.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/home/sections/popularBrandCardList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PopularBrandSection extends StatefulWidget {
  const PopularBrandSection({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularBrandSection> createState() => _PopularBrandSectionState();
}

class _PopularBrandSectionState extends State<PopularBrandSection> {

  List<PopularBrandsModel> popularBrandList =[];

  @override
  void initState() {
    getPopularBrands();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount:popularBrandList.length ,
          itemBuilder: (context, index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: 10.0, right: 20.0, bottom: 5.0, left: 20.0),
                    child: Text(
                    popularBrandList[index].categoryName.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                    )),
                SizedBox(height: 20),
                PopularBrandCardList(popularBrandList[index]),
              ],
            );
          })
    );
  }

  getPopularBrands() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] = prefs.getString('latitude');
    map['lng'] = prefs.getString('longitude');
    var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
    var jsonData = json.decode(response.body);
    if(jsonData['error_code'] == 0){
      List dataList = jsonData['popular_barands'];
      if(null!= dataList && dataList.length >0){
        popularBrandList =dataList.map((spacecraft) => new PopularBrandsModel.fromJson(spacecraft)).toList();
      }
      setState(() {

      });
    } else{
      print("some error occured!!!");
    }


  }
}