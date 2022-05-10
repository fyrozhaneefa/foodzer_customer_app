import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/ReviewSection/dividersection.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/cartAddons.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/restaurantProductsList.dart';
import 'package:provider/provider.dart';

import '../../../Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import '../../../utils/helper.dart';

class BasketHeader extends StatefulWidget {
  // dynamic totalPrice;
  // BasketHeader(this.totalPrice);
  @override
  _BasketHeaderState createState() => _BasketHeaderState();
}

class _BasketHeaderState extends State<BasketHeader> {
  bool isAddons = false;
  bool isClick = false;
  int selectedCartItemIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      return Container(
        width: Helper.getScreenWidth(context) * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Text("WELCOME50 eligible items",
            //       style: TextStyle(
            //           color: Colors.deepOrangeAccent,
            //           fontWeight: FontWeight.w500)),
            // ),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.cartModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                        Container(
                          padding:EdgeInsets.only(left: 15),
                          child:   provider.cartModelList[index].itemVegNonveg ==
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
                        ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: InkWell(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.cartModelList[index].itemName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          height: 1.3),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            flex: 10,
                          ),
                          Container(
                            height: 30,
                            width: 90,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 0.5),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding:
                                    EdgeInsets.only(left: 5, right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Provider.of<ApplicationProvider>(
                                            context,
                                            listen: false)
                                            .updateProduct(
                                            provider.cartModelList[index],
                                            false,
                                            provider.cartModelList[index]
                                                .enteredQty! -
                                                1);
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.green[700],
                                        size: 20,
                                      ),
                                    )),
                                Text(
                                    provider.cartModelList[index].enteredQty
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<ApplicationProvider>(context,
                                          listen: false)
                                          .updateProduct(
                                          provider.cartModelList[index],
                                          true,
                                          provider.cartModelList[index]
                                              .enteredQty! +
                                              1);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.green[700],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  // "₹320",
                                  ('₹${provider.cartModelList[index].totalPrice
                                      .toString()}'),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      null != provider.cartModelList[index].isAddon &&
                          provider.cartModelList[index].isAddon == 1
                          ? InkWell(
                        child: Row(children: [
                          Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Text(
                              "Customize",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, size: 17,)
                        ]),
                        onTap: () {
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
                                return CartAddons(provider.cartModelList[index],false,
                                );
                              });

                          // showModalBottomSheet(
                          //   isScrollControlled: false,
                          //   context: context,
                          //   builder: (context) {
                          //     return Column(
                          //       mainAxisAlignment:
                          //       MainAxisAlignment.center,
                          //       children: [
                          //         Row(
                          //           crossAxisAlignment:
                          //           CrossAxisAlignment.start,
                          //           children: [
                          //             Padding(
                          //               padding: EdgeInsets.only(
                          //                   top: 25,
                          //                   bottom: 10,
                          //                   left: 20,
                          //                   right: 10),
                          //               child: InkWell(
                          //                   child: Icon(
                          //                       Icons.clear_outlined),
                          //                   onTap: () {
                          //                     Navigator.pop(context);
                          //                   }),
                          //             ),
                          //             Container(child: Column(
                          //               crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 25, bottom: 10),
                          //                   child: Text(
                          //                     provider
                          //                         .cartModelList[index]
                          //                         .itemName
                          //                         .toString(),
                          //                     style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight:
                          //                         FontWeight.w600),
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   ('₹${provider.cartModelList[index]
                          //                       .totalPrice.toString()}'),
                          //                   style:
                          //                   TextStyle(fontSize: 13),
                          //                 ),
                          //
                          //               ],
                          //             ),
                          //             ),
                          //           ],),
                          //         SizedBox(height: 10,),
                          //         MySeparator(),
                          //         Flexible(
                          //           child: ListView.builder(
                          //               physics: ScrollPhysics(),
                          //               itemCount: provider
                          //                   .cartModelList[index]
                          //                   .addonsList!
                          //                   .length,
                          //               itemBuilder: (context, position) {
                          //                 return ListTile(
                          //                   leading: IconButton(
                          //                       alignment:
                          //                       Alignment.centerLeft,
                          //                       padding: EdgeInsets.zero,
                          //                       onPressed: () {
                          //                         setState(() {
                          //                           provider
                          //                               .cartModelList[
                          //                           index]
                          //                               .addonsList!
                          //                               .removeAt(
                          //                               position);
                          //                           Provider.of<
                          //                               ApplicationProvider>(
                          //                               context,
                          //                               listen: true)
                          //                               .updateProduct(
                          //                               provider.cartModelList[
                          //                               index],
                          //                               false,
                          //                               provider
                          //                                   .cartModelList[
                          //                               index]
                          //                                   .enteredQty!);
                          //                         });
                          //                       },
                          //                       icon: Icon(
                          //                         Icons
                          //                             .remove_circle_outline,
                          //                         color: Colors.red,
                          //                         size: 20,
                          //                       )),
                          //                   title: new Text(provider
                          //                       .cartModelList[index]
                          //                       .addonsList![position]
                          //                       .addonsSubTitleName
                          //                       .toString()),
                          //                   trailing: Text(
                          //                       '₹${provider
                          //                           .cartModelList[index]
                          //                           .addonsList![position]
                          //                           .addonsSubTitlePrice
                          //                           .toString()}'),
                          //                   style: ListTileStyle.drawer,
                          //                 );
                          //               }),
                          //         ),
                          //         Container(height: 55,
                          //             width: Helper.getScreenWidth(context) * 1,
                          //             child: ApplyButton(
                          //                 buttonname: "Update Item",
                          //                 radius: 8)
                          //         )
                          //       ],
                          //     );
                          //   },
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(20),
                          //       topRight: Radius.circular(20),
                          //     ),
                          //   ),
                          // );
                        },
                      )
                          : Container()
                      // ? ListView.builder(
                      //     physics: ScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: provider
                      //         .cartModelList[index].addonsList!.length,
                      //     itemBuilder: (context, position) {
                      //       return  ListTile(
                      //         leading: IconButton(
                      //             alignment: Alignment.centerLeft,
                      //             padding: EdgeInsets.zero,
                      //             onPressed: () {
                      //               setState(() {
                      //                 provider
                      //                     .cartModelList[index].addonsList!
                      //                     .removeAt(position);
                      //                 Provider.of<ApplicationProvider>(
                      //                         context,
                      //                         listen: false)
                      //                     .updateProduct(
                      //                         provider.cartModelList[index],
                      //                         false,
                      //                         provider.cartModelList[index]
                      //                             .enteredQty!);
                      //               });
                      //             },
                      //             icon: Icon(
                      //               Icons.remove_circle_outline,
                      //               color: Colors.red,
                      //               size: 20,
                      //             )),
                      //         title: new Text(provider.cartModelList[index]
                      //             .addonsList![position].addonsSubTitleName
                      //             .toString()),
                      //         trailing: Text(
                      //             '₹${provider.cartModelList[index].addonsList![position].addonsSubTitlePrice.toString()}'),
                      //         style: ListTileStyle.drawer,
                      //       );
                      //     })
                      // : Container()
                    ],
                  );
                }),
            // Padding(padding: EdgeInsets.only(top: 15), child: MySeparator()),
            // Container(
            //   height: 59,
            //   width: Helper.getScreenWidth(context) * 2,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(10),
            //         bottomRight: Radius.circular(10)),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Text("Write instruction for restaurant"),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(right: 10),
            //         child: Icon(Icons.add_circle_outline_outlined,
            //             size: 20, color: Colors.grey),
            //       ),
            //     ],
            //   ),
            // ),

          ],
        ),
      );
    });
  }

}
