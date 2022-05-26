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
        padding: EdgeInsets.all(10),
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
                  List<String>? addonNameList=[];
                  if(provider.cartModelList[index].isAddon == 1 &&
                      null!=provider.cartModelList[index].addonsList &&provider.cartModelList[index].addonsList!.length >0) {
                    for (Addons addon in provider.cartModelList[index]
                        .addonsList!) {
                      addonNameList.add(addon.addonsSubTitleName.toString());
                    }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5,top:2),
                            child: provider
                                        .cartModelList[index].itemVegNonveg ==
                                    "1"
                                ? Image.asset(
                                    Helper.getAssetName("veg.png", "virtual"),
                                    height: 15,
                                  )
                                : Image.asset(
                                    Helper.getAssetName(
                                        "non-veg.png", "virtual"),
                                    height: 15,
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.cartModelList[index].itemName
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      height: 1.3),
                                ),
                                SizedBox(height: 5,),
                                null != provider.cartModelList[index].isAddon &&
                                    provider.cartModelList[index].isAddon == 1
                                    ? Text(addonNameList.join(", "),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12,color: Colors.grey),):Container(height: 0,),
                                SizedBox(height: 5,),
                                null != provider.cartModelList[index].isAddon &&
                                    provider.cartModelList[index].isAddon == 1
                                    ? InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                    Text(
                                      "Customize",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 17,
                                    )
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
                                          return CartAddons(
                                            provider.cartModelList[index],
                                            false,
                                          );
                                        });
                                  },
                                )
                                    : Container()
                              ],
                            ),
                          ),
                          Container(
                            height:24,
                            margin:EdgeInsets.only(top:2,left: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 0.5),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 5,),
                                    child: InkWell(
                                      onTap: () {
                                        Item item =
                                            provider.cartModelList[index];
                                        item.enteredQty = item.enteredQty! - 1;
                                        Provider.of<ApplicationProvider>(
                                                context,
                                                listen: false)
                                            .updateProduct(item, false, false);
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.green[700],
                                        size: 18,
                                      ),
                                    )),
                                Text(
                                    provider.cartModelList[index].enteredQty
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.only(left: 5,right: 4),
                                  child: InkWell(
                                    onTap: () {
                                      if (null !=
                                              provider.cartModelList[index]
                                                  .isAddon &&
                                          provider.cartModelList[index]
                                                  .isAddon ==
                                              1) {

                                        addDuplicateItem(context,provider.cartModelList[index]);

                                      }else{
                                        provider.cartModelList[index].enteredQty = provider.cartModelList[index].enteredQty!+1;
                                        Provider.of<ApplicationProvider>(
                                            context,
                                            listen: false)
                                            .updateProduct(
                                            provider.cartModelList[index],
                                            true,
                                            false);
                                      }

                                      // provider.cartModelList[index]
                                      //     .enteredQty! +
                                      //     1;
                                      // Provider.of<ApplicationProvider>(context,
                                      //     listen: false)
                                      //     .updateProduct(
                                      //     provider.cartModelList[index],
                                      //     true,
                                      //     false);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.green[700],
                                      size:18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:EdgeInsets.only(top: 6,left: 5),
                                child: Text(
                                  // "₹320",
                                  ('₹${provider.cartModelList[index].totalPrice.toString()}'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // null != provider.cartModelList[index].isAddon &&
                      //         provider.cartModelList[index].isAddon == 1
                      //     ? InkWell(
                      //         child: Row(children: [
                      //           Padding(
                      //             padding: EdgeInsets.only(left: 13),
                      //             child: Text(
                      //               "Customize",
                      //               style: TextStyle(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //           Icon(
                      //             Icons.keyboard_arrow_down,
                      //             size: 17,
                      //           )
                      //         ]),
                      //         onTap: () {
                      //           showModalBottomSheet(
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(14),
                      //                   topRight: Radius.circular(14),
                      //                 ),
                      //               ),
                      //               isScrollControlled: true,
                      //               context: context,
                      //               builder: (context) {
                      //                 return CartAddons(
                      //                   provider.cartModelList[index],
                      //                   false,
                      //                 );
                      //               });
                      //         },
                      //       )
                      //     : Container()
                    ],
                  );
                }),
          ],
        ),
      );
    });
  }

  void addDuplicateItem(context, Item itemModel) {
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
                                    return CartAddons(itemModel, true);
                                  }).then((value) {});
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
                              //qty will be incremented from cart
                              Provider.of<ApplicationProvider>(context,
                                      listen: false)
                                  .updateProduct(itemModel, true, true);
                              Navigator.of(context).pop();
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
