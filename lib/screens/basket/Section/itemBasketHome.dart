import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/Address/addresshome.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/payment_home.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/chooseAddress.dart';
import 'package:foodzer_customer_app/screens/basket/Section/deliveryInstructions.dart';
import 'package:foodzer_customer_app/screens/basket/Section/headerCard.dart';
import 'package:foodzer_customer_app/screens/basket/Section/moneycard.dart';
import 'package:foodzer_customer_app/screens/basket/Section/proceedToPay.dart';

import 'package:foodzer_customer_app/screens/basket/Section/savedcontainer.dart';
import 'package:foodzer_customer_app/screens/basket/Section/tipyourHungerSavior.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:foodzer_customer_app/screens/loginScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ItemBasketHome extends StatefulWidget {
  // dynamic totalPrice;
  //  ItemBasketHome(this.totalPrice);

  @override
  _ItemBasketHomeState createState() => _ItemBasketHomeState();
}

class _ItemBasketHomeState extends State<ItemBasketHome>
    with WidgetsBindingObserver {
  TextEditingController tipController = new TextEditingController();
  bool isLoadingDeliveryCharge = false;
  int? deliveryType = 1;
  bool isFromCart = true;
  bool isLoading = false;
  UserData userModel = new UserData();
  List<AddressModel> getAddressList = [];
  double taxPercentage = 0;
  double toPayAmt = 0;
  double tipAmount = 0;
  List<String> tips = ["20", "30", "50", "Other"];
  int? selectedTip = -1;
  int tipValue = 0;
  bool isLoggedIn = false;
  bool customTip = false;
  var _selectedApp;
  SingleRestModel selectedRestDetails = new SingleRestModel();
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    getMerchantTaxPercentage();
    UserPreference().getCurrentRestaurant().then((value) {
      if(null!=value.merchantBranchId && value.merchantBranchId!.isNotEmpty) {
        selectedRestDetails = value;
      }
      setState(() {});
    });
    UserPreference().getUserData().then((value) {

      if (null != value.userId && value.userId!.isNotEmpty) {
        userModel = value;
        getUserAddress();
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: null != provider.cartModelList &&
                  provider.cartModelList.length > 0
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.keyboard_backspace_outlined,
                          color: Colors.black.withOpacity(.5), size: 30)),
                  title: Text(
                      null!=selectedRestDetails.branchDetails?
                      selectedRestDetails.branchDetails!.merchantBranchName.toString():"",
                    // null!=provider.selectedRestModel.branchDetails!.merchantBranchName
                    //     && provider.selectedRestModel.branchDetails!.merchantBranchName!.isNotEmpty? provider.selectedRestModel.branchDetails!.merchantBranchName
                    //     .toString():"",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  //     bottom:null!=provider.selectedRestModel.offerDetails? PreferredSize(
                  //       preferredSize: Size.fromHeight(80.0),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           width: Helper.getScreenWidth(context),
                  //           decoration: BoxDecoration(
                  //             color: Colors.deepOrange.shade100,
                  //             borderRadius: BorderRadius.circular(20)
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(12.0),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   'Rs.131 total savings',
                  //                   style: TextStyle(
                  //                     color: Colors.deepOrange,
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.w600
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: 7,),
                  //                 Text('indluding Rs.100 with WELCOME50 coupon',
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontSize: 13,
                  //                   fontWeight: FontWeight.w500
                  //                 ),)
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ) ):PreferredSize(
                  // preferredSize: Size.fromHeight(0.0), child: Container(),),
                )
              : AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  toolbarHeight: 0,
                  toolbarOpacity: 0,
                ),
          body: null != provider.cartModelList &&
                  provider.cartModelList.length > 0
              ? SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Choose your delivery type",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                deliveryType = 1;
                                              });
                                              provider.setDeliveryType(1);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: deliveryType == 1
                                                        ? Colors
                                                            .deepOrangeAccent
                                                        : Colors
                                                            .transparent),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                color: deliveryType == 1
                                                    ? Colors
                                                        .deepOrange.shade50
                                                    : Colors.grey.shade100,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors
                                                          .grey.shade100,
                                                      spreadRadius: 1,
                                                      blurRadius: 1)
                                                ],
                                              ),
                                              child:ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12),
                                                child: Image.asset(
                                                  Helper.getAssetName("delivery.png", "virtual"),
                                                ),
                                              )
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              tipValue = 0;
                                              selectedTip = -1;
                                              setState(() {
                                                deliveryType = 2;
                                              });
                                              provider.setDeliveryType(2);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: deliveryType == 2
                                                        ? Colors
                                                            .deepOrangeAccent
                                                        : Colors
                                                            .transparent),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                color: deliveryType == 2
                                                    ? Colors
                                                        .deepOrange.shade50
                                                    : Colors.grey.shade100,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors
                                                          .grey.shade100,
                                                      spreadRadius: 1,
                                                      blurRadius: 1)
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12),
                                                child: Image.asset(
                                                  Helper.getAssetName("pickup.png", "virtual"),
                                                ),
                                              )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    itemList(),
                                  ],
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 20, bottom: 10),
                                  child: Text(
                                    "Offers & Benefits",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: SavedContainer(
                                child: ListTile(
                                  title: Text(
                                    "Apply Coupon",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15),
                                ),
                              ),
                            ),
                            deliveryType == 1
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 20, bottom: 10),
                                        child: Text(
                                          "Tip Your hunger saviour",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: deliveryBoyTip(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 20, bottom: 10),
                                        child: Text(
                                          "Delivery instructions",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            top: 20,
                                            bottom: 10,
                                            right: 20),
                                        child: Container(
                                            height: 100,
                                            child: DeliveryInstructions()),
                                      ),
                                    ],
                                  )
                                : Container(),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, top: 20, bottom: 10),
                              child: Text(
                                "Bill Details",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 50),
                                child: summaryView()),
                          ],
                        ),
                      ),
                      // ProceedToPay(),
                      proceedToPay(),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: cartEmpty(context)),
          backgroundColor: Colors.grey.shade200,
        ),
      );
    });
  }

  Widget deliveryBoyTip() {
    return Container(
      // height: 140,
      width: Helper.getScreenWidth(context) * 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(),
              child: Text(
                "Thank your delivery partner by leaving them a tip.\n"
                "100% of the tip will go to your delivery partner ",
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tips.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: GestureDetector(
                            onTap: () {
                              if (tips[index] == "Other") {
                                if (selectedTip == index) {
                                  selectedTip = -1;
                                  tipValue = 0;
                                  customTip = false;
                                } else {
                                  selectedTip = index;
                                  tipValue = 0;
                                  customTip = true;
                                }
                                setState(() {});
                              } else {
                                if (selectedTip == index) {
                                  selectedTip = -1;
                                  tipValue = 0;
                                  customTip = false;
                                  setState(() {});
                                } else {
                                  selectedTip = index;
                                  tipValue = int.parse(tips[index]);
                                  customTip = false;
                                  setState(() {});
                                }
                              }

                              Provider.of<ApplicationProvider>(context,
                                      listen: false)
                                  .setTipValue(tipValue);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                    width: 65,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade100,
                                            spreadRadius: 1,
                                            blurRadius: 1)
                                      ],
                                      color: index == selectedTip
                                          ? Colors.deepOrange.shade50
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: index == selectedTip
                                              ? Colors.deepOrangeAccent
                                              : Colors.grey.shade200,
                                          width: 1),
                                    ),
                                    child: Center(
                                      child: Text('₹${tips[index]}'),
                                    )),
                                index == 1
                                    ? Positioned(
                                        bottom: -5,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8)),
                                          ),
                                          child: Text(
                                            "Most Tipped",
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.white),
                                            maxLines: 1,
                                            softWrap: true,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                      )
                              ],
                            )),
                      );
                    }),
              ),
              Visibility(
                visible: customTip,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                  child: TextFormField(
                      controller: tipController,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          counterText: "",
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepOrangeAccent, width: 2.0),
                          ),
                          labelText: 'Enter Tip Amount',
                          labelStyle: TextStyle(color: Colors.grey)),
                      onChanged: (value) async {
                        if (null != value && value.isNotEmpty) {
                          tipValue = int.parse(value);
                          setState(() {});
                          Provider.of<ApplicationProvider>(context,
                                  listen: false)
                              .setTipValue(tipValue);
                        } else {
                          tipValue = 0;
                          setState(() {});
                          Provider.of<ApplicationProvider>(context,
                                  listen: false)
                              .setTipValue(tipValue);
                        }
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemList() {
    if (null !=
            Provider.of<ApplicationProvider>(context, listen: false)
                .cartModelList &&
        Provider.of<ApplicationProvider>(context, listen: false)
                .cartModelList
                .length >
            0) {
      UserPreference().setCartItems(
          Provider.of<ApplicationProvider>(context, listen: false)
              .cartModelList);
    }
    return BasketHeader();
  }

  Widget summaryView() {
    double totalAmt = 0;
    double deliveryTip = 0;

    var taxData = {};
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      // if(null!=provider.selectedAddressModel.addressId && provider.selectedAddressModel.addressId!.isNotEmpty){
      //   getDeliveryCharge();
      // }
      // provider.calculateTotal();
      // for (Item item in provider.cartModelList) {
      //   totalAmt = totalAmt + item.totalPrice!;
      //   provider.setItemTotal(totalAmt);
      // }
      // taxData = provider.calculateTax(taxPercentage, totalAmt, false);
      // toPayAmt = taxData['totalAmtWithTax']+tipValue+provider.deliveryFee;
      // provider.setTotalCartPrice(toPayAmt);
      return Container(
        height: 270,
        width: Helper.getScreenWidth(context) * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 20),
                  child: Text("Item Total"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, top: 20),
                  child: Text('₹${provider.totalWithoutTax}'),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      // child: Text("Delivery Fee | 1.7 kms"),
                      child: InkWell(
                        onTap: () {
                          deliverFeeDialog(context);
                        },
                        child: Text('Delivery Fee',
                            style: TextStyle(
                              decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.deepOrangeAccent,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, top: 15),
                      child: Text("₹" + provider.deliveryFee.toString()),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: 10,
              ),
              child: Text(
                "This fee compansates your delivery Partner\nfairly",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: MySeparator(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text("Delivery Tip"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, top: 10),
                  child: Text("₹$tipValue"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: InkWell(
                    onTap: () {
                      taxAndChargeDialog(context);
                    },
                    child: Text('Tax and Charges',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.deepOrangeAccent,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, top: 15),
                  child: Text(
                      '₹${provider.taxData['totalTaxAmt'].toStringAsFixed(2)}'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: MySeparator(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text("To Pay",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.6))),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, top: 20),
                  child: Text('₹${provider.toPayAmt.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.6))),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  deliverFeeDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
          titlePadding: EdgeInsets.zero,
          elevation: 5,
          contentPadding: EdgeInsets.all(40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Delivery Fee',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 15.0, left: 15.0, right: 15.0),
                child: Text(
                  'Delivery fee : ₹${Provider.of<ApplicationProvider>(context, listen: false).deliveryFee}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  taxAndChargeDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(top: 170, left: 50, right: 50),
          titlePadding: EdgeInsets.zero,
          elevation: 5,
          contentPadding: EdgeInsets.all(40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Tax and charges',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 15.0, left: 15.0, right: 15.0),
                child: Text(
                  'Restaurant GST : ₹${Provider.of<ApplicationProvider>(context, listen: false).taxData['totalTaxAmt'].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget proceedToPay() {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      // for(Item item in provider.cartModelList){
      //   totalAmt=totalAmt+item.totalPrice!;
      //   alltotal=totalAmt+deliveryFee+deliveryTip+taxAndCharges;
      // }
      return Container(
        width: Helper.getScreenWidth(context) * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            deliveryType == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: isLoggedIn &&
                                null !=
                                    provider.selectedAddressModel.addressId &&
                                provider
                                    .selectedAddressModel.addressId!.isNotEmpty
                            ? ListTile(
                                title: Text(
                                  "Deliver to " +
                                      provider
                                          .selectedAddressModel.addressTitle!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.6),
                                  ),
                                ),
                                subtitle: Text(
                                  provider.selectedAddressModel
                                          .addressBuilding! +
                                      ", " +
                                      provider.selectedAddressModel
                                          .adressApartmentNo! +
                                      ", " +
                                      provider.selectedAddressModel
                                          .addressStreetName! +
                                      ", " +
                                      provider.selectedAddressModel
                                          .currentAddressLine!,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                trailing: Container(
                                  width: 65,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.home,
                                            color: Colors.deepOrange),
                                        InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(14),
                                                      topRight:
                                                          Radius.circular(14),
                                                    ),
                                                  ),
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return ChooseAddress(
                                                        isFromCart,
                                                        getAddressList);
                                                  }).then((value) {
                                                Provider.of<ApplicationProvider>(
                                                        context,
                                                        listen: false)
                                                    .calculateTotal();
                                                setState(() {});
                                              });
                                            },
                                            child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 20,
                                                color: Colors.deepOrange)),
                                      ]),
                                ),
                              )
                            : !isLoggedIn
                                ? Container()
                                : InkWell(
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
                                            return ChooseAddress(
                                                isFromCart, getAddressList);
                                          }).then((value) {
                                        //qty will be incremented from cart
                                        Provider.of<ApplicationProvider>(
                                                context,
                                                listen: false)
                                            .calculateTotal();
                                        setState(() {});
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: Helper.getScreenWidth(
                                                  context),
                                              child: Text(
                                                "Add a delivery address",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.deepOrange,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                      )
                    ],
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: MySeparator(),
            ),
            ListTile(
              title: Container(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if(null!= selectedRestDetails && selectedRestDetails.merchantBranchId!.isNotEmpty){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RestaurantDetailsScreen(
                                        selectedRestDetails.merchantBranchId,
                                        selectedRestDetails.branchDetails!.lat,
                                        selectedRestDetails.branchDetails!.lng)));
                    }
                    // if (null !=
                    //         Provider.of<ApplicationProvider>(context,
                    //                 listen: false)
                    //             .categoryList &&
                    //     Provider.of<ApplicationProvider>(context, listen: false)
                    //             .categoryList
                    //             .length >
                    //         0 && null !=
                    //     Provider.of<ApplicationProvider>(context,
                    //         listen: false)
                    //         .cartModelList &&
                    //     Provider.of<ApplicationProvider>(context, listen: false)
                    //         .cartModelList
                    //         .length > 0  &&  Provider.of<ApplicationProvider>(context, listen: false)
                    //     .cartModelList[0].itemMerchantBranch== Provider.of<ApplicationProvider>(context, listen: false)
                    //     .selectedRestModel.merchantBranchId) {
                    //
                    //   Navigator.of(context).pop();
                    // } else {
                    //
                    //
                    //   UserPreference().getCurrentRestaurant().then((value) {
                    //
                    //     if (null != value.merchantBranchId &&
                    //         value.merchantBranchId!.isNotEmpty) {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (BuildContext context) =>
                    //               RestaurantDetailsScreen(
                    //                   value.branchDetails!.merchantBranchId,
                    //                   value.branchDetails!.lat,
                    //                   value.branchDetails!.lng)));
                    //     }else{
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (BuildContext context) =>
                    //               HomeScreen()));
                    //     }
                    //   });
                    // }
                  },
                  child: Text(
                    "Add Items",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              // Text(
              //   "₹${provider.toPayAmt}",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.black.withOpacity(.6),
              //   ),
              // ),
              // subtitle: Text(
              //   "View Detailed Bill",
              //   style: TextStyle(
              //       color: Colors.deepOrangeAccent,
              //       fontSize: 12,
              //       fontWeight: FontWeight.w600),
              // ),
              trailing: Container(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    if (isLoggedIn &&
                            null != provider.selectedAddressModel.addressId &&
                            provider
                                .selectedAddressModel.addressId!.isNotEmpty &&
                            deliveryType == 1 ||
                        isLoggedIn && deliveryType == 2) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentSection(deliveryType!)));
                    } else if (!isLoggedIn) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(isFromCart)));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Select a delivery address to continue",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepOrange,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Text(
                    isLoggedIn ? "Proceed to Pay" : "Log in to continue",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: isLoggedIn &&
                                null !=
                                    provider.selectedAddressModel.addressId &&
                                provider.selectedAddressModel.addressId!
                                    .isNotEmpty &&
                                deliveryType == 1 ||
                            deliveryType == 2
                        ? Colors.deepOrange
                        : !isLoggedIn
                            ? Colors.deepOrange
                            : Colors.deepOrange.shade100,
                    fixedSize: Size(Helper.getScreenWidth(context) / 2, 58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // getDeliveryCharge() async {
  //
  //   isLoadingDeliveryCharge =true;
  //   setState(() {
  //
  //   });
  //   var map = new Map<String, dynamic>();
  //   map['merchant_branch_id'] =  Provider.of<ApplicationProvider>(context, listen: false)
  //       .selectedRestModel.merchantBranchId;
  //   map['lat'] =  Provider.of<ApplicationProvider>(context, listen: false)
  //       .selectedAddressModel.addressLat;
  //   map['lng'] =  Provider.of<ApplicationProvider>(context, listen: false)
  //       .selectedAddressModel.addressLng;
  //   map['order_amt'] = "1";
  //
  //
  //   var response =
  //   await http.post(Uri.parse(ApiData.GET_DELIVERY_CHARGE), body: map);
  //
  //   var json = convert.jsonDecode(response.body);
  //   isLoadingDeliveryCharge =false;
  //   setState(() {
  //
  //   });
  //   if(response.statusCode==200) {
  //     int errorCode = json['error_code'];
  //
  //
  //     if (errorCode== 0) {
  //
  //     } else{
  //       Fluttertoast.showToast(
  //           msg: "Delivery charge fetch failed",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 15.0
  //       );
  //     }
  //   }
  // }

  getUserAddress() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['user_id'] = userModel.userId;

    var response =
        await http.post(Uri.parse(ApiData.GET_USER_ADDRESS), body: map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['address_list'];
    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      if (null != dataList && dataList.length > 0) {
        getAddressList = dataList
            .map((address) => new AddressModel.fromJson(address))
            .toList();
        setState(() {});
      }
    }
  }

  getMerchantTaxPercentage() async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = Provider.of<ApplicationProvider>(context, listen: false)
        .selectedRestModel
        .merchantBranchId
        .toString();

    var response =
        await http.post(Uri.parse(ApiData.MERCHANT_BRANCH_TAX), body: map);
    var json = convert.jsonDecode(response.body);
    taxPercentage = double.parse(json['tax_details']);
    Provider.of<ApplicationProvider>(context, listen: false)
        .setTaxPercentage(taxPercentage);
    setState(() {});
  }
}

Widget? cartEmpty(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: Image.asset(
            Helper.getAssetName('empty-cart.png', 'virtual'),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Your Cart is Empty',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Looks like you haven't added anything to your cart yet",
          textAlign: TextAlign.center,
          maxLines: 2,
          textScaleFactor: 1,
          style: TextStyle(
              height: 1.3,
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 50,
          width: Helper.getScreenWidth(context) * 0.45,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Back to menu',
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange.shade600,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
