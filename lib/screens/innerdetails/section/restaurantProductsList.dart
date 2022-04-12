import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/singleItemView.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RestaurantProductsList extends StatefulWidget {
  bool isSwitched;
   RestaurantProductsList(this.isSwitched);

  @override
  State<RestaurantProductsList> createState() => _RestaurantProductsListState();
}

class _RestaurantProductsListState extends State<RestaurantProductsList> {
  // List<Addons> addonModelList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      return null != provider.filteredLoadedProductModelList
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.filteredLoadedProductModelList.length,
              itemBuilder: (BuildContext context, int index) {
                Item itemModel = provider.filteredLoadedProductModelList[index];
                return InkWell(
                  onTap: () {
                    singleItemDetails(context, itemModel);
                    // provider.getItemId(itemModel.itemId!);
                    // if (itemModel.isAddon == 1) {
                    //   getAddons();
                    // }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: null != itemModel.enteredQty
                              ? BorderSide(
                                  color: Colors.deepOrangeAccent, width: 5)
                              : BorderSide.none,
                        ),
                        // borderRadius: BorderRadius.only( topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                      ),
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    itemModel.itemVegNonveg == "1"
                                        ? Image.asset(
                                            Helper.getAssetName(
                                                "veg.png", "virtual"),
                                            height: 15,
                                          )
                                        : Image.asset(
                                            Helper.getAssetName(
                                                "non-veg.png", "virtual"),
                                            height: 15,
                                          ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(null != itemModel.enteredQty
                                        ? '${itemModel.enteredQty.toString()}x'
                                        : "",
                                      style:TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepOrange
                                      ),),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Text(itemModel.itemName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              height: 1.3)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(itemModel.itemDescription!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('INR ${itemModel.itemPrice}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ],
                            ),
                            flex: 9,
                          ),
                          Expanded(
                            child: Container(
                              child: Image.network(
                                // 'https://i5.peapod.com/c/NY/NYO1E.png',
                                itemModel.itemImage!,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.deepOrangeAccent,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            flex: 4,
                          )
                        ],
                      )),
                );
              })
          : Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            );
    });
  }

  void singleItemDetails(context, Item itemModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleItemView(itemModel);
        });
  }

}
