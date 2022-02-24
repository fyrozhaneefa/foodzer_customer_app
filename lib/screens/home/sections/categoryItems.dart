import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/allgroceries/AllGroceries.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/allRestaurants.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../Api/ApiData.dart';
import '../../../Models/CategoryModel.dart';
import 'categoryCard.dart';
class CategoryItems extends StatefulWidget {
  const CategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {

  @override
  void initState() {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    // applicationBloc.getDashboardResult();
    // getDashboardDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return
     Container(
        padding: const EdgeInsets.only(left: 20.0,right: 10),
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: applicationBloc.dashboardResults?.length,
          itemBuilder: (context, index) {
            return CategoryCard(
                          color: applicationBloc.dashboardResults![index].name == "Food"? Colors.deepOrangeAccent
                              :applicationBloc.dashboardResults![index].name == "Groceries"? Colors.teal.shade400:Colors.blue,
                          cardImg: null!=applicationBloc.dashboardResults? applicationBloc.dashboardResults![index].image.toString()
              :'https://www.freepnglogos.com/uploads/food-png/download-food-png-file-png-image-pngimg-1.png',

                          cardName:null!=applicationBloc.dashboardResults? applicationBloc.dashboardResults![index].name.toString():'food',
                          press: (){
                            Navigator.of(context).pushNamed(AllRestaurantsScreen.routeName);
                          },);
          },
        ),
      );
    //   SingleChildScrollView(
    //   physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    //   scrollDirection: Axis.horizontal,
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 20.0,right: 10),
    //     child: Row(
    //       children: [
    //         CategoryCard(
    //           color: Colors.deepOrange,
    //           cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
    //           cardName: 'Food',
    //           press: (){
    //             Navigator.of(context).pushNamed(AllRestaurantsScreen.routeName);
    //           },),
    //         CategoryCard(
    //           color: Colors.teal.shade400,
    //           cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
    //           cardName: 'Groceries',
    //           press: (){
    //             Navigator.of(context).pushNamed(AllGroceriesScreen.routeName);
    //           },),
    //         CategoryCard(
    //           color: Colors.red,
    //           cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
    //           cardName: 'Flowers',
    //           press: (){
    //             Navigator.of(context).pushNamed(AllFlowersScreen.routeName);
    //           },),
    //         CategoryCard(
    //           color: Colors.blue,
    //           cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
    //           cardName: 'Health & wellness',
    //           press: (){
    //             print("Health & wellness printed");
    //           },),
    //         CategoryCard(
    //           color: Colors.indigo,
    //           cardImg: 'https://i.pinimg.com/originals/d4/50/aa/d450aa83e974012cc2444cd25cb96ca1.png',
    //           cardName: 'More',
    //           press: (){
    //             print("more");
    //           },)
    //       ],
    //     ),
    //   ),
    // );
  }
  // getDashboardDetails() async {
  //   // CategoryModel categoryModel = new CategoryModel();
  //   var map = new Map<String, dynamic>();
  //   map['lat'] = '10.9760357';
  //   map['lng'] = '76.22544309999999';
  //   var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
  //   var json = convert.jsonDecode(response.body);
  //     List dataList = json['main_category'];
  //     if(null!= dataList && dataList.length >0){
  //       categoryList =dataList.map((spacecraft) => new CategoryModel.fromJson(spacecraft)).toList();
  //     }
  //
  //   // var jsonResults = json['main_category'] as List;
  //   // return jsonResults.map((category) => CategoryModel.fromJson(category)).toList();
  //
  // }
}