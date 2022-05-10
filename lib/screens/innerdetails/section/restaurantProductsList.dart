import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/singleItemView.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

class RestaurantProductsList extends StatefulWidget {
  bool isSwitched;
  TabController? tabController;

  RestaurantProductsList(this.isSwitched, this.tabController);

  @override
  State<RestaurantProductsList> createState() => _RestaurantProductsListState();
}

class _RestaurantProductsListState extends State<RestaurantProductsList> {
  // List<Addons> addonModelList = [];
  // ScrollController scrollController=new ScrollController();
  @override
  void initState() {
    // scrollController.addListener(() {
    //   print(scrollController.offset.toString()+"offfset"); // <-- This is it.
    // });// <--
    super.initState();
  }

  _scrollListener() {
    // if (_controller.offset >= _controller.position.maxScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     message = "reach the bottom";
    //   });
    // }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     message = "reach the top";
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      return null != provider.filteredLoadedProductModelList
          ? Container(
        color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: VerticalScrollableTabView(
                  tabController: widget.tabController!,
                  listItemData: provider.categoryList,
                  verticalScrollPosition: VerticalScrollPosition.begin,
                  slivers: [
                    // SliverLayoutBuilder(
                    //   builder: (context, constraints) {
                    //     return SliverAppBar(
                    //       shadowColor: Colors.transparent,
                    //       backgroundColor: Colors.white,
                    //       systemOverlayStyle: SystemUiOverlayStyle.dark,
                    //       iconTheme: const IconThemeData(
                    //         color: Colors.black,
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                  eachItemChild: (object, index) {

                    List<Item> filteredList = [];

                    // provider
                    //     .currentSelectedCategory(
                    //     provider
                    //         .categoryList[
                    //     index]
                    //         .categoryId!);
                    // if (provider
                    //     .selectedCategoryId ==
                    //     provider.categoryList[index].categoryId) {
                    if (provider.categoryList[index].categoryId == 0) {
                      filteredList = provider.selectedRestModel.items!;
                      // filteredList.sort(
                      //     (a, b) => a.categoryName!.compareTo(b.categoryName!));
                    } else {
                      filteredList = provider.selectedRestModel.items!
                          .where((product) => (product.categoryId ==
                              provider.categoryList[index].categoryId))
                          .toList();
                      // filteredList.sort(
                      //     (a, b) => a.categoryName!.compareTo(b.categoryName!));
                    }
                    // Provider.of<ApplicationProvider>(context, listen: false).clearItems();
                    // provider
                    //     .setItemLoading(true);
                    // loadedItemCount = 0;
                    // _loadData();

                    // provider.addProductData(
                    //     filteredList,
                    //     true);
                    // }
                    // Provider.of<ApplicationProvider>(context ,listen: false).filterItems(categoryList[index].categoryId!);

                    // provider.setCategoryName(
                    //     provider
                    //         .categoryList[index]
                    //         .categoryName!);

                    return Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Material(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft:Radius.circular(20))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0,
                                      horizontal: 8),
                                      child: Text(provider.categoryList[index].categoryName!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),),
                                    ),
                                  ),
                                ),
                              ),
                              null==filteredList ||
                                  filteredList.length==0?
                                  Center(child: CircularProgressIndicator(),):
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: ListView.builder(

                                    // controller: scrollController,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: filteredList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Item itemModel = filteredList[index];
                                      // Future.delayed(Duration.zero, () async {
                                      //   provider
                                      //       .currentSelectedCategory(itemModel.categoryId!);                });

                                      return Container(
                                        height: 120,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Material(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:index==filteredList.length-1?
                                              BorderRadius.only(
                                                  bottomLeft: Radius.circular(20),
                                              bottomRight:Radius.circular(20)):BorderRadius.zero
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: InkWell(
                                                onTap: () {
                                                  singleItemDetails(context, itemModel);
                                                  // provider.getItemId(itemModel.itemId!);
                                                  // if (itemModel.isAddon == 1) {
                                                  //   getAddons();
                                                  // }
                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        decoration: BoxDecoration(
                                                          border: Border(
                                                            right:
                                                                null != itemModel.enteredQty
                                                                    ? BorderSide(
                                                                        color: Colors
                                                                            .deepOrangeAccent,
                                                                        width: 5)
                                                                    : BorderSide.none,
                                                          ),
                                                          // borderRadius: BorderRadius.only( topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                                                        ),

                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      itemModel.itemVegNonveg ==
                                                                              "1"
                                                                          ? Image.asset(
                                                                              Helper.getAssetName(
                                                                                  "veg.png",
                                                                                  "virtual"),
                                                                              height: 15,
                                                                            )
                                                                          : Image.asset(
                                                                              Helper.getAssetName(
                                                                                  "non-veg.png",
                                                                                  "virtual"),
                                                                              height: 15,
                                                                            ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text(
                                                                        null !=
                                                                                itemModel
                                                                                    .enteredQty
                                                                            ? '${itemModel.enteredQty.toString()}x'
                                                                            : "",
                                                                        style: TextStyle(
                                                                            fontSize: 12,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                            color: Colors
                                                                                .deepOrange),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 3,
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                            itemModel
                                                                                .itemName!,
                                                                            style: TextStyle(
                                                                                fontWeight:
                                                                                    FontWeight
                                                                                        .w600,
                                                                                height: 1.3)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                      itemModel
                                                                          .itemDescription!,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors.grey
                                                                              .shade700)),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                      'INR ${itemModel.itemPrice}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
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
                                                                  height: 80,
                                                                  width: 80,
                                                                  fit: BoxFit.fill,
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) return child;
                                                                    return Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: Colors
                                                                            .deepOrangeAccent,
                                                                        value: loadingProgress
                                                                                    .expectedTotalBytes !=
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
                                                          // SizedBox(height:5),
                                                          // Container(height: 1,color: Colors.grey[400],)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                ),
                              ),
                            ],
                        ),
                    );
                  }),
            )
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
