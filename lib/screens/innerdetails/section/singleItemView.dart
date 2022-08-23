import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/itemAddonModel.dart';
import 'package:foodzer_customer_app/Models/itemPriceOnModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/cartAddons.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SingleItemView extends StatefulWidget {
  Item itemModel;

  SingleItemView(this.itemModel);

  @override
  _SingleItemViewState createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView> {
  final addonKey = GlobalKey();
  final priceOnKey = GlobalKey();

  // List<bool> isChecked = List.generate(
  //     Provider.of<ApplicationProvider>(context, listen: false)
  //         .addonModelList
  //         .length,
  //         (index) => false);
  bool isIncrement = false;
  int totalQty = 1;
  PriceOnItem selectedPriceOnItem = new PriceOnItem();
  int initialQty = 0;
  double itemPrice = 0;
  double totalPrice = 0;
  bool isChecked = false;
  List<Addons> addOnList = [];
  List<PriceOnItem> priceOnItemList = [];

  // List<Addons> mandatoryAddonList = [];
  int lastAddonIndex = -1;
  int lastPriceOnItemIndex = -1;
  bool isLoading = false;
  int? radioValue;
  bool isMandatory = false;
  bool isPOIMandatory = false;

  @override
  void initState() {
    // TODO: implement initState
    if (null != widget.itemModel.enteredQty &&
        null != widget.itemModel.itemPrice) {
      totalPrice = widget.itemModel.itemPrice! * widget.itemModel.enteredQty!;
    } else {
      totalPrice = widget.itemModel.itemPrice!;
    }
    if (null != widget.itemModel.enteredQty &&
        widget.itemModel.enteredQty! > 0) {
      totalQty = widget.itemModel.enteredQty!;
      initialQty = widget.itemModel.enteredQty!;
    } else {
      totalQty = 1;
      setState(() {});
    }
    if (widget.itemModel.isAddon == 1) {
      getAddons();
    }
    if (widget.itemModel.isPriceon == 1) {
      getPriceOnItem();
    }
    itemPrice = widget.itemModel.itemPrice!;
    // totalPrice = widget.itemModel.itemPrice!;

    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future scrollToAddon() async {
    final addonContext = addonKey.currentContext!;
    await Scrollable.ensureVisible(addonContext);
  }

  Future scrollToPriceOn() async {
    final priceOnContext = priceOnKey.currentContext!;
    await Scrollable.ensureVisible(priceOnContext);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
          )
        : Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Helper.getScreenWidth(context),
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          child: Image.network(
                            widget.itemModel.itemImage!,
                            // 'https://mumbaimirror.indiatimes.com/photo/76424716.cms',
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.itemModel.itemName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.itemModel.itemDescription!,
                              // 'Fried puff pastry balls, filled with spiced mashed potatoes and boondi. Served with spiced water and sweet tamarind sauce',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                            null != widget.itemModel.itemDescription
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    widget.itemModel.isPriceon == 0
                                        ? 'INR ' +
                                            widget.itemModel.itemPrice!
                                                .toStringAsFixed(2)
                                        : "Price on selection",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 3.0,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (totalQty == 1) {
                                            Navigator.of(context).pop();
                                          } else {
                                            totalQty = totalQty - 1;
                                            calculatePrice();
                                            // Provider.of<ApplicationProvider>(
                                            //     context,
                                            //     listen: false)
                                            //     .updateProduct( widget.itemModel, false, false);
                                            // setState(() {
                                            //   totalQty = widget.itemModel.enteredQty!;
                                            //   totalPrice = double.parse(
                                            //       totalPrice.toString()) -
                                            //       double.parse(
                                            //           itemPrice.toString());
                                            // });
                                          }

                                          // else {
                                          //   showDeleteDialogForMultipleItem(
                                          //       context);
                                          // }
                                          setState(() {});
                                          // if (totalQty == 1) {
                                          //   // Navigator.of(context).pop();
                                          // } else {
                                          //   setState(() {
                                          //     totalQty--;
                                          //     totalPrice = double.parse(
                                          //             totalPrice.toString()) -
                                          //         double.parse(
                                          //             itemPrice.toString());
                                          //   });
                                          // }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: totalQty == 0
                                              ? Colors.deepOrange.shade100
                                              : Colors.deepOrange,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        totalQty.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          totalQty = totalQty + 1;

                                          calculatePrice();
                                          setState(() {});

                                          // if (Provider.of<ApplicationProvider>(
                                          //             context,
                                          //             listen: false)
                                          //         .cartModelList
                                          //         .isEmpty ||
                                          //     Provider.of<ApplicationProvider>(
                                          //                 context,
                                          //                 listen: false)
                                          //             .cartModelList
                                          //             .first
                                          //             .itemMerchantBranch ==
                                          //         Provider.of<ApplicationProvider>(
                                          //                 context,
                                          //                 listen: false)
                                          //             .selectedRestModel
                                          //             .merchantBranchId) {

                                          // } else {
                                          //   showAlertDialog(context);
                                          // }

                                          // setState(() {
                                          //   itemCount++; //_two => TextEditingController of 2nd TextField
                                          //   totalPrice = double.parse(
                                          //           totalPrice.toString()) +
                                          //       double.parse(
                                          //           itemPrice.toString());
                                          // });
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ),
                      null != priceOnItemList && priceOnItemList.length > 0
                          ? Divider(
                              height: 15,
                              thickness: 6,
                              color: Colors.grey.shade300)
                          : Container(),
                      null != priceOnItemList && priceOnItemList.length > 0
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                key: priceOnKey,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price on Item",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  null != priceOnItemList &&
                                          priceOnItemList.length > 0
                                      ? !isPOIMandatory
                                          ? Text('Choose 1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 14))
                                          : Row(
                                              children: [
                                                Icon(
                                                  Icons.warning_amber_outlined,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text("Choose 1",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.red,
                                                        fontSize: 15))
                                              ],
                                            )
                                      : Container(
                                          height: 0,
                                        ),
                                  ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: priceOnItemList.length,
                                      itemBuilder: (context, index) {
                                        return Visibility(
                                          visible: null != priceOnItemList &&
                                              priceOnItemList.length > 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    priceOnItemList[index]
                                                        .priceonItemTitle
                                                        .toString()),
                                              ),
                                              Text(
                                                  "(+ INR ${priceOnItemList[index].priceonItemPrice.toString()})"),
                                              Radio(
                                                activeColor:
                                                    Colors.deepOrangeAccent,
                                                value: null !=
                                                            priceOnItemList[
                                                                    index]
                                                                .isItemSelected &&
                                                        priceOnItemList[index]
                                                            .isItemSelected!
                                                    ? 1
                                                    : 0,
                                                groupValue: 1,
                                                onChanged: (value) {
                                                  priceOnItemList[index]
                                                      .isItemSelected = true;

                                                  if (lastPriceOnItemIndex !=
                                                      -1) {
                                                    priceOnItemList[
                                                            lastPriceOnItemIndex]
                                                        .isItemSelected = false;
                                                  }

                                                  // totalPrice=totalPrice + priceOnItemList[index]
                                                  //     .priceonItemPrice!;
                                                  // if(lastPriceOnItemIndex!=-1){
                                                  //  totalPrice=totalPrice - priceOnItemList[
                                                  //  lastPriceOnItemIndex].priceonItemPrice!;
                                                  // }
                                                  selectedPriceOnItem =
                                                      priceOnItemList[index];

                                                  lastPriceOnItemIndex = index;
                                                  calculatePrice();
                                                  setState(() {});
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            )
                          : Container(),
                      null != addOnList && addOnList.length > 0
                          ? null != widget.itemModel.isPriceon &&
                                      widget.itemModel.isPriceon == 1 &&
                                      null != selectedPriceOnItem.priceonId &&
                                      selectedPriceOnItem
                                          .priceonId!.isNotEmpty ||
                                  null == widget.itemModel.isPriceon ||
                                  widget.itemModel.isPriceon == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    null !=
                                                addOnList
                                                    .where((element) =>
                                                        null !=
                                                            element
                                                                .addonsType &&
                                                        element.addonsType == 2)
                                                    .toList() &&
                                            addOnList
                                                    .where((element) =>
                                                        null !=
                                                            element
                                                                .addonsType &&
                                                        element.addonsType == 2)
                                                    .toList()
                                                    .length >
                                                0
                                        ? Divider(
                                            height: 15,
                                            thickness: 6,
                                            color: Colors.grey.shade300)
                                        : Container(),
                                    null !=
                                                addOnList
                                                    .where((element) =>
                                                        null !=
                                                            element
                                                                .addonsType &&
                                                        element.addonsType == 2)
                                                    .toList() &&
                                            addOnList
                                                    .where((element) =>
                                                        null !=
                                                            element
                                                                .addonsType &&
                                                        element.addonsType == 2)
                                                    .toList()
                                                    .length >
                                                0
                                        ? Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              key: addonKey,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    null !=
                                                                addOnList
                                                                    .where((element) =>
                                                                        null !=
                                                                            element
                                                                                .addonsType &&
                                                                        element.addonsType ==
                                                                            2)
                                                                    .toList() &&
                                                            addOnList
                                                                    .where((element) =>
                                                                        null !=
                                                                            element
                                                                                .addonsType &&
                                                                        element.addonsType ==
                                                                            2)
                                                                    .toList()
                                                                    .length >
                                                                0
                                                        ? addOnList
                                                            .where((element) =>
                                                                null !=
                                                                    element
                                                                        .addonsType &&
                                                                element.addonsType ==
                                                                    2)
                                                            .toList()
                                                            .first
                                                            .addonsName!
                                                        : "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                null !=
                                                            addOnList
                                                                .where((element) =>
                                                                    null !=
                                                                        element
                                                                            .addonsType &&
                                                                    element.addonsType ==
                                                                        2)
                                                                .toList() &&
                                                        addOnList
                                                                .where((element) =>
                                                                    null !=
                                                                        element
                                                                            .addonsType &&
                                                                    element.addonsType ==
                                                                        2)
                                                                .toList()
                                                                .length >
                                                            0
                                                    ? !isMandatory
                                                        ? Text('Choose 1',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14))
                                                        : Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .warning_amber_outlined,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text("Choose 1",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          15))
                                                            ],
                                                          )
                                                    : Container(
                                                        height: 0,
                                                      ),
                                                ListView.builder(
                                                    physics: ScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: addOnList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Visibility(
                                                        visible: null !=
                                                                addOnList[index]
                                                                    .addonsType &&
                                                            addOnList[index]
                                                                    .addonsType ==
                                                                2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(addOnList[
                                                                      index]
                                                                  .addonsSubTitleName
                                                                  .toString()),
                                                            ),
                                                            Radio(
                                                              activeColor: Colors
                                                                  .deepOrangeAccent,
                                                              value: null !=
                                                                          addOnList[index]
                                                                              .isSelected &&
                                                                      addOnList[
                                                                              index]
                                                                          .isSelected!
                                                                  ? 1
                                                                  : 0,
                                                              groupValue: 1,
                                                              onChanged:
                                                                  (value) {
                                                                addOnList[index]
                                                                        .isSelected =
                                                                    true;

                                                                if (lastAddonIndex !=
                                                                    -1) {
                                                                  addOnList[lastAddonIndex]
                                                                          .isSelected =
                                                                      false;
                                                                }
                                                                lastAddonIndex =
                                                                    index;
                                                                isMandatory =
                                                                    false;
                                                                calculatePrice();
                                                                setState(() {});
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    })
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Divider(
                                        height: 1,
                                        thickness: 6,
                                        color: Colors.grey.shade300),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 15.0),
                                      child: Row(
                                        children: [
                                          Text(
                                              null !=
                                                          addOnList
                                                              .where((element) =>
                                                                  null !=
                                                                      element
                                                                          .addonsType &&
                                                                  element.addonsType ==
                                                                      1)
                                                              .toList() &&
                                                      addOnList
                                                              .where((element) =>
                                                                  null !=
                                                                      element
                                                                          .addonsType &&
                                                                  element.addonsType ==
                                                                      1)
                                                              .toList()
                                                              .length >
                                                          0
                                                  ? addOnList
                                                      .where((element) =>
                                                          null !=
                                                              element
                                                                  .addonsType &&
                                                          element.addonsType ==
                                                              1)
                                                      .toList()
                                                      .first
                                                      .addonsName!
                                                  : "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text('Choose items from the list',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              fontSize: 14)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: addOnList.length,
                                          itemBuilder: (context, index) {
                                            return Visibility(
                                              visible: null !=
                                                      addOnList[index]
                                                          .addonsType &&
                                                  addOnList[index].addonsType ==
                                                      1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(addOnList[index]
                                                        .addonsSubTitleName
                                                        .toString()),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '(+ INR ${addOnList[index].addonsSubTitlePrice})'),
                                                      Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                        activeColor: Colors
                                                            .deepOrangeAccent,
                                                        value: addOnList[index]
                                                            .isSelected,
                                                        onChanged: (checked) {
                                                          setState(
                                                            () {
                                                              addOnList[index]
                                                                      .isSelected =
                                                                  checked;
                                                              calculatePrice();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                )
                              : Container()
                          : Container(),
                      Divider(
                          height: 15,
                          thickness: 6,
                          color: Colors.grey.shade300),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.messenger_outline),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Any special requests?',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => addNote(context),
                                child: Text(
                                  'Add note',
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 60,
                      child: Consumer<ApplicationProvider>(
                          builder: (context, provider, child) {
                        return ElevatedButton(
                          onPressed: () {
                            if (null != widget.itemModel.isPriceon &&
                                widget.itemModel.isPriceon == 1 &&
                                lastPriceOnItemIndex == -1) {
                              isPOIMandatory = true;
                              scrollToPriceOn();
                              setState(() {});
                            } else if (null != widget.itemModel.isAddon &&
                                widget.itemModel.isAddon == 1 &&
                                addOnList
                                        .where((element) =>
                                            null != element.addonsType &&
                                            element.addonsType! == 2)
                                        .length >
                                    0 &&
                                lastAddonIndex == -1) {
                              isMandatory = true;
                              scrollToAddon();
                              setState(() {});
                            } else if (Provider.of<ApplicationProvider>(context,
                                        listen: false)
                                    .cartModelList
                                    .isEmpty ||
                                Provider.of<ApplicationProvider>(context,
                                            listen: false)
                                        .cartModelList
                                        .first
                                        .itemMerchantBranch ==
                                    Provider.of<ApplicationProvider>(context,
                                            listen: false)
                                        .selectedRestModel
                                        .merchantBranchId) {
                              if (null != widget.itemModel.isAddon &&
                                  widget.itemModel.isAddon == 1) {
                                Item item = new Item();
                                // if (widget.isNewItem) {
                                String kson = Item.toDataJson(widget.itemModel);
                                var jsonData = json.decode(kson);
                                item = Item.fromJson(jsonData);
                                item.addonsList = addOnList
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList();
                                item.tempId = null;
                                item.enteredQty = totalQty;
                                if (null != widget.itemModel.isPriceon &&
                                    widget.itemModel.isPriceon == 1) {
                                  item.priceOnItemPrice =
                                      selectedPriceOnItem.priceonItemPrice;
                                  item.priceOnId =
                                      selectedPriceOnItem.priceonId;
                                }

                                Provider.of<ApplicationProvider>(context,
                                        listen: false)
                                    .updateProduct(item, true, false);
                                UserPreference().setCurrentRestaurant(
                                    Provider.of<ApplicationProvider>(context,
                                        listen: false)
                                        .selectedRestModel);

                                Navigator.of(context)
                                    .pop(widget.itemModel.enteredQty);
                              } else {
                                Item item = new Item();
                                // if (widget.isNewItem) {
                                String kson = Item.toDataJson(widget.itemModel);
                                var jsonData = json.decode(kson);
                                item = Item.fromJson(jsonData);

                                item.enteredQty = totalQty;
                                if (null != widget.itemModel.isPriceon &&
                                    widget.itemModel.isPriceon == 1) {
                                  item.priceOnItemPrice =
                                      selectedPriceOnItem.priceonItemPrice;
                                  item.priceOnId =
                                      selectedPriceOnItem.priceonId;
                                }
                                Provider.of<ApplicationProvider>(context,
                                        listen: false)
                                    .updateProduct(
                                        item, totalQty > initialQty, false);
                                UserPreference().setCurrentRestaurant(
                                    Provider.of<ApplicationProvider>(context,
                                        listen: false)
                                        .selectedRestModel);

                                Navigator.of(context)
                                    .pop(widget.itemModel.enteredQty);
                              }
                            } else {
                              showAlertDialog(context);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              provider.selectedRestModel.branchDetails!
                                          .openStatus ==
                                      "Closed"
                                  ? Text(
                                      "CLOSED",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : provider.selectedRestModel.branchDetails!
                                              .openStatus ==
                                          "No-service"
                                      ? Text(
                                          "UNSERVICEABLE",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : provider.selectedRestModel
                                                  .branchDetails!.openStatus ==
                                              "Busy"
                                          ? Text(
                                              "BUSY",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          : Text(
                                              null !=
                                                          widget.itemModel
                                                              .enteredQty &&
                                                      widget.itemModel
                                                              .enteredQty! >
                                                          0
                                                  ? 'Update basket'
                                                  : 'Add to basket',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                              Text(
                                'INR ' + totalPrice.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                // side: BorderSide(color: Colors.grey)
                              )),
                        );
                      }),
                    ))
              ],
            ),
          );
  }

  calculatePrice() {
    totalPrice = 0;

    double itemPrice = 0;
    if (null != widget.itemModel.isPriceon &&
        widget.itemModel.isPriceon == 1 &&
        null != selectedPriceOnItem.priceonItemPrice) {
      itemPrice = selectedPriceOnItem.priceonItemPrice!;
    } else {
      itemPrice = widget.itemModel.itemPrice!;
    }
    itemPrice = itemPrice * totalQty;
    for (Addons addon in addOnList) {
      // if(null!=widget.priceOnId && product.priceOnId!.isNotEmpty){
      //   itemPrice=product.priceOnItemPrice!;
      // }else{
      //   itemPrice=product.itemPrice!;
      // }

      if (null != addon.isSelected && addon.isSelected!) {
        if (null != addon.addonsType && addon.addonsType == 1) {
          totalPrice = totalPrice + (addon.addonsSubTitlePrice! * totalQty);
        }
      }
    }
    totalPrice = totalPrice + itemPrice;
  }

  void addNote(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          TextEditingController itemNoteController =
              new TextEditingController();
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Special request'),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: itemNoteController,
                      maxLength: 200,
                      decoration: InputDecoration(
                          fillColor: Colors.deepOrange,
                          hintText: "No onions please...",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          suffixIcon: Icon(
                            Icons.highlight_remove_outlined,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  width: Helper.getScreenWidth(context),
                  color: Colors.grey.shade300,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Done',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                  ))
            ],
          );
        });
  }

  getPriceOnItem() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['item_id'] = widget.itemModel.itemId!;
    var response = await http.post(Uri.parse(ApiData.ITEM_PRICEON), body: map);
    var json = convert.jsonDecode(response.body);
    isLoading = false;
    setState(() {});
    List priceonItem = json['item_priceon'];
    if (null != priceonItem && priceonItem.length > 0) {
      priceOnItemList = priceonItem
          .map((spacecraft) => new PriceOnItem.fromJson(spacecraft))
          .toList();
    }
  }

  getAddons() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['item_id'] = widget.itemModel.itemId!;
    var response =
        await http.post(Uri.parse(ApiData.GET_ITEM_ADDONS), body: map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['addons'];
    if (null != dataList && dataList.length > 0) {
      // List<Addons> addonList = [];

      addOnList = dataList
          .map((spacecraft) => new Addons.fromJson(spacecraft))
          .toList();

      if (null != widget.itemModel.addonsList &&
          widget.itemModel.addonsList!.length > 0) {
        for (Addons addonModel in widget.itemModel.addonsList!) {
          if (addonModel.isSelected!) {
            if (null != addonModel.addonsType && addonModel.addonsType == 2) {
              lastAddonIndex = addOnList.indexWhere((element) =>
                  element.itemAddonsSubtitleTblid ==
                  addonModel.itemAddonsSubtitleTblid);
              if (lastAddonIndex != -1) {
                addOnList[lastAddonIndex].isSelected = true;
              }
            } else {
              addOnList
                  .where((element) =>
                      element.itemAddonsSubtitleTblid ==
                      addonModel.itemAddonsSubtitleTblid)
                  .first
                  .isSelected = true;
            }
            totalPrice = double.parse(totalPrice.toString()) +
                addonModel.addonsSubTitlePrice!;
            setState(() {});
          }
        }
      }

      isLoading = false;
      setState(() {});
    }
  }

  void showDeleteDialogForMultipleItem(BuildContext context) {
    // set up the buttons
    Widget cancelButton = Container(
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextButton(
        child: Text("No",
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    Widget continueButton = Container(
      width: Helper.getScreenWidth(context) * .3,
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.deepOrange, width: 1)),
      child: TextButton(
        child: Text(
          "Yes",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ItemBasketHome()));
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Remove item from cart?",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
          "The item has multiple customizations added. Proceed to cart to remove item?",
          style: TextStyle(height: 1.3)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = Container(
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextButton(
        child: Text("No",
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    Widget continueButton = Container(
      width: Helper.getScreenWidth(context) * .3,
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.deepOrange, width: 1)),
      child: TextButton(
        child: Text(
          "Replace",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: () {


          if (null != widget.itemModel.isPriceon &&
              widget.itemModel.isPriceon == 1 &&
              lastPriceOnItemIndex == -1) {
            isPOIMandatory = true;
            scrollToPriceOn();
            setState(() {});
          } else if (null != widget.itemModel.isAddon &&
              widget.itemModel.isAddon == 1 &&
              addOnList
                      .where((element) =>
                          null != element.addonsType &&
                          element.addonsType! == 2)
                      .length >
                  0 &&
              lastAddonIndex == -1) {
            isMandatory = true;
            scrollToAddon();
            setState(() {});
          } else {
            Provider.of<ApplicationProvider>(context, listen: false)
                .cartModelList
                .clear();
            if (null != widget.itemModel.isAddon &&
                widget.itemModel.isAddon == 1) {
              Item item = new Item();
              // if (widget.isNewItem) {
              String kson = Item.toDataJson(widget.itemModel);
              var jsonData = json.decode(kson);
              item = Item.fromJson(jsonData);
              item.addonsList = addOnList
                  .where((element) => element.isSelected == true)
                  .toList();
              item.tempId = null;
              item.enteredQty = totalQty;
              if (null != widget.itemModel.isPriceon &&
                  widget.itemModel.isPriceon == 1) {
                item.priceOnItemPrice = selectedPriceOnItem.priceonItemPrice;
                item.priceOnId = selectedPriceOnItem.priceonId;
              }

              Provider.of<ApplicationProvider>(context, listen: false)
                  .updateProduct(item, true, false);
              UserPreference().setCurrentRestaurant(
                  Provider.of<ApplicationProvider>(context, listen: false)
                      .selectedRestModel);
              Navigator.of(context).pop(widget.itemModel.enteredQty);
              Navigator.pop(context);
            } else {
              Item item = new Item();
              // if (widget.isNewItem) {
              String kson = Item.toDataJson(widget.itemModel);
              var jsonData = json.decode(kson);
              item = Item.fromJson(jsonData);

              item.enteredQty = totalQty;
              if (null != widget.itemModel.isPriceon &&
                  widget.itemModel.isPriceon == 1) {
                item.priceOnItemPrice = selectedPriceOnItem.priceonItemPrice;
                item.priceOnId = selectedPriceOnItem.priceonId;
              }
              Provider.of<ApplicationProvider>(context, listen: false)
                  .updateProduct(item, totalQty > initialQty, false);
              UserPreference().setCurrentRestaurant(
                  Provider.of<ApplicationProvider>(context, listen: false)
                      .selectedRestModel);
              Navigator.of(context).pop(widget.itemModel.enteredQty);
              Navigator.pop(context);
            }
          }
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Replace cart item?",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
          "Your cart contains dishes from another restaurant. Do you wish to remove those items from cart?",
          style: TextStyle(height: 1.3)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void addDuplicateItem(context) {
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
                    leading: widget.itemModel.itemVegNonveg == "1"
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
                      widget.itemModel.itemName.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("₹${widget.itemModel.itemPrice.toString()}"),
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
                                    return CartAddons(widget.itemModel, true);
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
                              totalQty++;
                              // widget.itemModel.enteredQty = itemCount;
                              if (Provider.of<ApplicationProvider>(context,
                                          listen: false)
                                      .cartModelList
                                      .isEmpty ||
                                  Provider.of<ApplicationProvider>(context,
                                              listen: false)
                                          .cartModelList
                                          .first
                                          .itemMerchantBranch ==
                                      Provider.of<ApplicationProvider>(context,
                                              listen: false)
                                          .selectedRestModel
                                          .merchantBranchId) {
                                if (null != addOnList && addOnList.length > 0) {
                                  List<Addons> addedMandatoryAddonList = [];
                                  addedMandatoryAddonList = addOnList
                                      .where((element) =>
                                          null != element.addonsType &&
                                          element.addonsType == 2)
                                      .toList();
                                  // if (null != addedMandatoryAddonList &&
                                  //     addedMandatoryAddonList.length > 0 &&
                                  //     lastAddonIndex == -1) {
                                  //   isMandatory = true;
                                  //   setState(() {});
                                  // } else {
                                  widget.itemModel.addonsList = addOnList
                                      .where((element) =>
                                          element.isSelected == true)
                                      .toList();
                                  widget.itemModel.enteredQty = totalQty;
                                  Provider.of<ApplicationProvider>(context,
                                          listen: false)
                                      .updateProduct(
                                          widget.itemModel,
                                          null == widget.itemModel.enteredQty ||
                                              null !=
                                                      widget.itemModel
                                                          .enteredQty &&
                                                  totalQty >
                                                      widget.itemModel
                                                          .enteredQty!,
                                          true);
                                  Navigator.pop(context);
                                  isMandatory = false;
                                  setState(() {});
                                  // }
                                } else {
                                  widget.itemModel.addonsList = addOnList
                                      .where((element) =>
                                          element.isSelected == true)
                                      .toList();
                                  widget.itemModel.enteredQty = totalQty;
                                  Provider.of<ApplicationProvider>(context,
                                          listen: false)
                                      .updateProduct(
                                          widget.itemModel,
                                          null == widget.itemModel.enteredQty ||
                                              null !=
                                                      widget.itemModel
                                                          .enteredQty &&
                                                  totalQty >
                                                      widget.itemModel
                                                          .enteredQty!,
                                          false);
                                  Navigator.pop(context);
                                }
                              } else {
                                showAlertDialog(context);
                              }
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
