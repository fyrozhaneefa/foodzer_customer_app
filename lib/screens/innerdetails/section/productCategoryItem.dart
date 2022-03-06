import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategory.dart';
import 'package:provider/provider.dart';

import '../../../Api/ApiData.dart';

class ProductCategoryItem extends StatefulWidget {
  String? merchantBranchId,lat,lng;
  ProductCategoryItem(this.merchantBranchId, this.lat, this.lng);



  @override
  State<ProductCategoryItem> createState() => _ProductCategoryItemState();
}

class _ProductCategoryItemState extends State<ProductCategoryItem> {

  List<Category> categoryList=[];
// int? selectedIndex;
  @override
  void initState() {
    getItemCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu,
              color: Colors.deepOrange),
          Flexible(
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                itemCount: categoryList.length,
                  itemBuilder:(context, index) {
                    return ProductCategory(
                      title:categoryList[index].categoryName!,
                      // isActive: true,
                      // color:selectedIndex == index ? Colors.deepOrange : null,
                      color: Provider.of<ApplicationProvider>(context ,listen: false).isSelected == index?Colors.deepOrange:null,
                      press: (){
                        Provider.of<ApplicationProvider>(context ,listen: false).filterItems(categoryList[index].categoryId!);
                        setState(() {
                          Provider.of<ApplicationProvider>(context ,listen: false).currentSelectedCategory(index);
                          Provider.of<ApplicationProvider>(context ,listen: false).setCategoryName(categoryList[index].categoryName!);
                        });
                        
                      },
                    );
                  }),
            ),
          )
          // ...categoryList.map((item)=> ProductCategory(
          //   title:item.categoryName!,
          //   // isActive: true,
          //   color: item.,
          //   press: (){
          //     Provider.of<ApplicationProvider>(context ,listen: false).filterItems(item.categoryId!);
          //
          //       Provider.of<ApplicationProvider>(context ,listen: false).currentSelectedCategory(true);
          //
          //   },
          // )).toList(),

          // ProductCategory(
          //   title:'Dairy And Beverages',
          //   press: (){
          //     print('2');
          //   },
          // ),
          // ProductCategory(
          //   title:'Fruits And Vegetables',
          //   press: (){
          //     print('3');
          //   },
          // ),
        ]
    );
  }
  getItemCategory() async{
    var map = new Map<String, dynamic>();
    map['merchant_branch_id'] = widget.merchantBranchId;
    map['lat'] = widget.lat;
    map['lng'] = widget.lng;
    var response= await http.post(Uri.parse(ApiData.SINGLE_REST),body:map);
    var json = convert.jsonDecode(response.body);

    if(json['error_code'] == 0){
      List dataList = json['categories'];
      if(null!= dataList && dataList.length >0){
        categoryList =dataList.map((spacecraft) => new Category.fromJson(spacecraft)).toList();
      }
      setState(() {

      });
    }else{
      print("some error occured!!!");
    }

  }
}
