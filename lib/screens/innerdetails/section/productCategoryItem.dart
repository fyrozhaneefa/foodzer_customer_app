import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/divider.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection/divider.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategory.dart';
import 'package:provider/provider.dart';

import '../../../Api/ApiData.dart';

class ProductCategoryItem extends StatefulWidget {
  String? merchantBranchId, lat, lng;

  ProductCategoryItem(this.merchantBranchId, this.lat, this.lng);

  @override
  State<ProductCategoryItem> createState() => _ProductCategoryItemState();
}

class _ProductCategoryItemState extends State<ProductCategoryItem> {
  int? loadedItemCount;
  List<Category> categoryList = [];
  List<Item> filteredList = [];

// int? selectedIndex;
  @override
  void initState() {
    getItemCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      InkWell(
          child: Icon(Icons.menu, color: Colors.deepOrange),
          onTap: () {
            onButtonpress(context,20);
          }),
      Flexible(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return ProductCategory(
                  title: categoryList[index].categoryName!,
                  // isActive: true,
                  // color:selectedIndex == index ? Colors.deepOrange : null,
                  textColor:
                      Provider.of<ApplicationProvider>(context, listen: false)
                                  .isSelectedIndex ==
                              index
                          ? Colors.white
                          : Colors.black,
                  color:
                      Provider.of<ApplicationProvider>(context, listen: false)
                                  .isSelectedIndex ==
                              index
                          ? Colors.deepOrange
                          : null,
                  press: () {
                    Provider.of<ApplicationProvider>(context, listen: false)
                        .currentSelectedCategory(index);
                    if (Provider.of<ApplicationProvider>(context, listen: false)
                            .isSelectedIndex ==
                        index) {
                      setState(() {
                        if (categoryList[index].categoryId == "0") {
                          filteredList = Provider.of<ApplicationProvider>(
                                  context,
                                  listen: false)
                              .selectedRestModel
                              .items!;
                          filteredList.sort((a, b) =>
                              a.categoryName!.compareTo(b.categoryName!));
                        } else {
                          filteredList = Provider.of<ApplicationProvider>(
                                  context,
                                  listen: false)
                              .selectedRestModel
                              .items!
                              .where((product) => (product.categoryId ==
                                  categoryList[index].categoryId))
                              .toList();
                          filteredList.sort((a, b) =>
                              a.categoryName!.compareTo(b.categoryName!));
                        }
                        // Provider.of<ApplicationProvider>(context, listen: false).clearItems();
                        Provider.of<ApplicationProvider>(context, listen: false)
                            .setItemLoading(true);
                        loadedItemCount = 0;
                        _loadData();
                      });
                      Provider.of<ApplicationProvider>(context, listen: false)
                          .addProductData(filteredList, true, index);
                    }
                    // Provider.of<ApplicationProvider>(context ,listen: false).filterItems(categoryList[index].categoryId!);

                    Provider.of<ApplicationProvider>(context, listen: false)
                        .setCategoryName(categoryList[index].categoryName!);
                  },
                );
              }),
        ),
      )
    ]);
  }

  Future _loadData() async {
    int endIndex = 7;
    // perform fetching data delay
    if (Provider.of<ApplicationProvider>(context, listen: false)
            .isItemLoading &&
        null != filteredList &&
        filteredList.length > 0) {
      await new Future.delayed(new Duration(seconds: 1));

      setState(() {
        if (loadedItemCount! <= filteredList.length) {
          if (loadedItemCount! + endIndex <= filteredList.length) {
            Provider.of<ApplicationProvider>(context, listen: false)
                .filteredLoadedProductModelList
                .addAll(filteredList.getRange(
                    loadedItemCount!, loadedItemCount! + endIndex));
            Provider.of<ApplicationProvider>(context, listen: false)
                .setItemLoading(false);
            loadedItemCount = loadedItemCount! + endIndex;
          } else {
            endIndex = filteredList.length - loadedItemCount!;
            Provider.of<ApplicationProvider>(context, listen: false)
                .filteredLoadedProductModelList
                .addAll(filteredList.getRange(
                    loadedItemCount!, loadedItemCount! + endIndex));
            Provider.of<ApplicationProvider>(context, listen: false)
                .setItemLoading(false);
            loadedItemCount = loadedItemCount! + 7;
          }
        } else {
          Provider.of<ApplicationProvider>(context, listen: false)
              .setItemLoading(false);
        }
      });
    }
  }

  getItemCategory() async {
    var map = new Map<String, dynamic>();
    map['merchant_branch_id'] = widget.merchantBranchId;
    map['lat'] = widget.lat;
    map['lng'] = widget.lng;
    var response = await http.post(Uri.parse(ApiData.SINGLE_REST), body: map);
    var json = convert.jsonDecode(response.body);

    if (json['error_code'] == 0) {
      List dataList = json['categories'];
      if (null != dataList && dataList.length > 0) {
        categoryList = dataList
            .map((spacecraft) => new Category.fromJson(spacecraft))
            .toList();
        categoryList.insert(
            0, new Category(categoryId: "0", categoryName: "All"));
      }
      Provider.of<ApplicationProvider>(context, listen: false)
          .setCategoryName(categoryList.first.categoryName!);
      setState(() {});
    } else {
      print("some error occured!!!");
    }
  }

  void onButtonpress(context ,count) {
    showModalBottomSheet(isScrollControlled: false,
      context: context,
      builder: (context) {
        return Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                      child: Icon(Icons.clear_outlined),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 20),
                  child: Text(
                    "Menu categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Flexible(child:ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Most Selling"),
                    trailing: Text("5"),
                  );
                },
                separatorBuilder: (context, index) {
                  return Dividersection();
                },
                itemCount: count,),
            ),],
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
