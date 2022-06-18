import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/cartAddons.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/singleItemView.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:cached_network_image/cached_network_image.dart';

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

  // _scrollListener() {
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
  // }

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


                    if (provider.categoryList[index].categoryId == 0) {
                      filteredList = provider.selectedRestModel.items!;

                    } else {
                      filteredList = provider.selectedRestModel.items!
                          .where((product) => (product.categoryId ==
                              provider.categoryList[index].categoryId))
                          .toList();


                    }


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
                                    color: Colors.white,
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
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                                  return Divider(height: 1,thickness: 1,color: Colors.grey[300],);
                                                },
                                  // scrollDirection: Axis.vertical,
                                    // controller: scrollController,
                                    physics:NeverScrollableScrollPhysics(),
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
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Material(
                                            color: Colors.white,
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

                                                  if (null==itemModel.enteredQty ||
                                                      itemModel.enteredQty == 0 || (itemModel.enteredQty! > 0 &&
                                                      itemModel.isAddon == 0)) {
                                                    singleItemDetails(context, itemModel);


                                                  }  else {
                                                    addDuplicateItem(itemModel);
                                                  }
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
                                                                // child: Image.network(
                                                                //   // 'https://i5.peapod.com/c/NY/NYO1E.png',
                                                                //   itemModel.itemImage!,
                                                                //   height: 80,
                                                                //   width: 80,
                                                                //   fit: BoxFit.fill,
                                                                //   loadingBuilder: (BuildContext
                                                                //           context,
                                                                //       Widget child,
                                                                //       ImageChunkEvent?
                                                                //           loadingProgress) {
                                                                //     if (loadingProgress ==
                                                                //         null) return child;
                                                                //     return Center(
                                                                //       child:
                                                                //           CircularProgressIndicator(
                                                                //         color: Colors
                                                                //             .deepOrangeAccent,
                                                                //         value: loadingProgress
                                                                //                     .expectedTotalBytes !=
                                                                //                 null
                                                                //             ? loadingProgress
                                                                //                     .cumulativeBytesLoaded /
                                                                //                 loadingProgress
                                                                //                     .expectedTotalBytes!
                                                                //             : null,
                                                                //       ),
                                                                //     );
                                                                //   },
                                                                // ),
                                                                child: CachedNetworkImage(
                                                                    width: 80,
                                                                    height: 80,
                                                                    imageUrl: itemModel.itemImage!,
                                                                    fit: BoxFit.fill,
                                                                    errorWidget:
                                                                        (context, url, error) =>
                                                                        Image.asset(
                                                                          Helper.getAssetName("blank.jpg", "virtual"),
                                                                        )),
                                                                
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
  void addDuplicateItem( Item itemModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (_context) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: itemModel.itemVegNonveg == "1"
                        ? Image.asset(
                      Helper.getAssetName("veg.png", "virtual"),
                      height: 15,
                    )
                        : Image.asset(
                      Helper.getAssetName("non-veg.png", "virtual"),
                      height: 15,
                    ),
                    minLeadingWidth: 2,
                    title: Text(
                      itemModel.itemName.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("₹${itemModel.itemPrice.toString()}"),
                    trailing: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close)),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 15, right: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              itemModel.enteredQty=1;
                              singleItemDetails(context, itemModel);

                              // showModalBottomSheet(
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.only(
                              //         topLeft: Radius.circular(14),
                              //         topRight: Radius.circular(14),
                              //       ),
                              //     ),
                              //     isScrollControlled: true,
                              //     context: context,
                              //     builder: (context) {
                              //       return CartAddons(itemModel, true);
                              //     }).then((value) {});
                            },
                            child: Text(
                              "I'll Choose",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 15, left: 10),
                          child: ElevatedButton(
                            onPressed: () {
                            //   totalQty++;
                            //   // widget.itemModel.enteredQty = itemCount;
                            //   if (Provider.of<ApplicationProvider>(context,
                            //       listen: false)
                            //       .cartModelList
                            //       .isEmpty ||
                            //       Provider.of<ApplicationProvider>(context,
                            //           listen: false)
                            //           .cartModelList
                            //           .first
                            //           .itemMerchantBranch ==
                            //           Provider.of<ApplicationProvider>(context,
                            //               listen: false)
                            //               .selectedRestModel
                            //               .merchantBranchId) {
                            //     if (null != addOnList && addOnList.length > 0) {
                            //       List<Addons> addedMandatoryAddonList = [];
                            //       addedMandatoryAddonList = addOnList
                            //           .where((element) =>
                            //       null != element.addonsType &&
                            //           element.addonsType == 2)
                            //           .toList();
                            //       // if (null != addedMandatoryAddonList &&
                            //       //     addedMandatoryAddonList.length > 0 &&
                            //       //     lastAddonIndex == -1) {
                            //       //   isMandatory = true;
                            //       //   setState(() {});
                            //       // } else {
                            //       itemModel.addonsList = addOnList
                            //           .where((element) =>
                            //       element.isSelected == true)
                            //           .toList();
                                 itemModel.enteredQty = itemModel.enteredQty!+1;
                                  Provider.of<ApplicationProvider>(context,
                                      listen: false)
                                      .updateProduct(
                                      itemModel,true,
                                      true);
                                  Navigator.pop(context);
                            //       isMandatory = false;
                            //       setState(() {});
                            //       // }
                            //     } else {
                            //      itemModel.addonsList = addOnList
                            //           .where((element) =>
                            //       element.isSelected == true)
                            //           .toList();
                            //      itemModel.enteredQty = totalQty;
                            //       Provider.of<ApplicationProvider>(context,
                            //           listen: false)
                            //           .updateProduct(
                            //           itemModel,
                            //           null == itemModel.enteredQty ||
                            //               null !=
                            //                   itemModel
                            //                       .enteredQty &&
                            //                   totalQty >
                            //                      itemModel
                            //                           .enteredQty!,
                            //           false);
                            //       Navigator.pop(context);
                            //     }
                            //   } else {
                            //     showAlertDialog(context);
                            //   }
                            },
                            child: Text(
                              "Repeat Last",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ));
        });
  }
}
