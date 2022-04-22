import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/allgroceries/AllGroceries.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/allRestaurants.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../../../Api/ApiData.dart';
import '../../../Models/CategoryModel.dart';
import 'categoryCard.dart';
import 'package:shimmer/shimmer.dart';
class CategoryItems extends StatefulWidget {
  const CategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {


  List<CategoryModel> categoryList= [];
  @override
  void initState() {

    getCategoryList();
    super.initState();
  }
  @override


  Widget build(BuildContext context) {
    return
     Container(
        padding: const EdgeInsets.only(left: 20.0,right: 10),
        height: 115,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return CategoryCard(
                          color: categoryList[index].name == "Food"? Colors.deepOrangeAccent
                              :categoryList[index].name == "Groceries"? Colors.teal.shade400:Colors.blue,
                          cardImg: categoryList[index].image,
                          cardName:categoryList[index].name,
                          press: (){
                            if(categoryList[index].name == "Food"){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AllRestaurantsScreen()));
                            } else if(categoryList[index].name == "Groceries"){
                              Fluttertoast.showToast(
                                  msg: "Groceries are currently not available",
                                  toastLength: Toast.LENGTH_LONG,
                                  fontSize: 14,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.grey.shade300,
                                  textColor: Colors.red
                              );
                            }

                          },);
          },
        ),
      );

  }
  Widget loadingShimmer() {
    return Container(
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    child: const Text("zzz"),
                    color: Colors.teal[100],
                  ),
                );
              }),
            ),
          )),
    );
  }
  getCategoryList() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] = prefs.getString('latitude');
    map['lng'] = prefs.getString('longitude');
    var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
    var json = convert.jsonDecode(response.body);
    if(json['error_code'] == 0){

      List dataList = json['main_category'];
      if(null!= dataList && dataList.length >0){
        categoryList =dataList.map((spacecraft) => new CategoryModel.fromJson(spacecraft)).toList();
      }
      setState(() {

      });
    } else{

    print("some error occured!!!");
    }


  }
}

