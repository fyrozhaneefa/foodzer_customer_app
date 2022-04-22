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

class _ItemBasketHomeState extends State<ItemBasketHome> {
  bool isLoadingDeliveryCharge = false;
  int? deliveryType = 1;
  bool isFromCart = true;
  bool isLoading = false;
  UserData userModel = new UserData();
  List<AddressModel> getAddressList = [];
  double taxPercentage = 0;
  double toPayAmt = 0;
  double tipAmount = 0;
  List<String> tips = ["1", "5", "10", "20"];
  int? selectedTip = -1;
  int tipValue = 0;

  @override
  void initState() {
    getMerchantTaxPercentage();
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
      getUserAddress();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.keyboard_backspace_outlined,
                  color: Colors.black.withOpacity(.5), size: 30)),
          title: Text(
            provider.selectedRestModel.branchDetails!.merchantBranchName
                .toString(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
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
        ),
        body: SafeArea(
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
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            deliveryType = 1;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: deliveryType == 1
                                                    ? Colors.deepOrangeAccent
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade100,
                                                  spreadRadius: 1,
                                                  blurRadius: 1)
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                'https://www.pngall.com/wp-content/uploads/11/Fast-Delivery-PNG.png',
                                                width: 50,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Delivery',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      deliveryType == 1
                                          ? Align(
                                              child: Icon(
                                                Icons.check_circle,
                                                size: 16,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          tipValue = 0;
                                          selectedTip =-1;
                                          setState(() {
                                            deliveryType = 2;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: deliveryType == 2
                                                    ? Colors.deepOrangeAccent
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade100,
                                                  spreadRadius: 1,
                                                  blurRadius: 1)
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                'https://www.pngall.com/wp-content/uploads/11/Fast-Delivery-PNG.png',
                                                width: 50,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Pick up',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      deliveryType == 2
                                          ? Align(
                                              child: Icon(
                                                Icons.check_circle,
                                                size: 16,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            BasketHeader(),
                          ],
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 20, bottom: 10),
                          child: Text(
                            "Offers & Benefits",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
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
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing:
                              Icon(Icons.arrow_forward_ios_rounded, size: 15),
                        ),
                      ),
                    ),
                   deliveryType == 1?Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                         child: Text(
                           "Tip Your hunger saviour",
                           style: TextStyle(
                               fontSize: 16, fontWeight: FontWeight.w600),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(
                             left: 20, right: 20, top: 10, bottom: 10),
                         child: deliveryBoyTip(),
                       ),
                       Padding(
                         padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                         child: Text(
                           "Delivery instructions",
                           style: TextStyle(
                               fontSize: 16, fontWeight: FontWeight.w600),
                         ),
                       ),
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: DeliveryInstructions(),
                       ),
                     ],
                   ):Container(),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
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
        ),
        backgroundColor: Colors.grey.shade200,
      );
    });
  }

  Widget deliveryBoyTip() {
    return Container(
      height: 120,
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
          Container(
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
                        if(selectedTip == index){
                          selectedTip = -1;
                          tipValue = 0;
                              setState(() {

                              });
                        } else{
                          selectedTip = index;
                          tipValue = int.parse(tips[index]);
                          setState(() {

                          });
                        }


                      },
                      child: Container(
                          width: 65,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(color: Colors.grey.shade100,spreadRadius: 1,blurRadius: 1)
                          ],
                            color: index==selectedTip?Colors.deepOrange.shade50:Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: index==selectedTip?Colors.deepOrangeAccent
                                :
                            Colors.grey.shade200,width: 1),
                          ),
                          child: Center(child:Text('₹${tips[index]}'),))
                    ),
                  );
                }),
          ),

        ],
      ),
    );
  }

  Widget summaryView() {
    double totalAmt = 0;
    double deliveryTip = 0;

    var taxData = {};
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      // if(null!=provider.selectedAddressModel.addressId && provider.selectedAddressModel.addressId!.isNotEmpty){
      //   getDeliveryCharge();
      // }
      for (Item item in provider.cartModelList) {
        totalAmt = totalAmt + item.totalPrice!;
        provider.setItemTotal(totalAmt);
      }
      taxData = provider.calculateTax(taxPercentage, totalAmt, false);
      toPayAmt = taxData['totalAmtWithTax']+tipValue+provider.deliveryFee;
      provider.setTotalCartPrice(toPayAmt);
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
                  child: Text('₹${totalAmt.toStringAsFixed(2)}'),
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
                      child: Tooltip(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          // border: Border.all(color: Colors.black)
                        ),
                        preferBelow: false,
                        margin: EdgeInsets.only(left: 20),
                        height: 50,
                        message: 'Delivery Fee : ₹'+provider.deliveryFee.toString(),
                        textStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        triggerMode: TooltipTriggerMode.tap,
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
                      child: Text("₹"+provider.deliveryFee.toString()),
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
                  child: Tooltip(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(color: Colors.black)
                    ),
                    preferBelow: false,
                    margin: EdgeInsets.only(left: 20),
                    height: 50,
                    message:
                        'Restaurant GST : ₹${taxData['totalTaxAmt'].toStringAsFixed(2)}',
                    textStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    triggerMode: TooltipTriggerMode.tap,
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
                  child: Text('₹${taxData['totalTaxAmt'].toStringAsFixed(2)}'),
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
                  child: Text('₹${provider.totalCartPrice}',
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
                        child: null !=
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
                                  provider.selectedAddressModel.addressBuilding! +
                                      ", " +
                                      provider.selectedAddressModel
                                          .adressApartmentNo! +
                                      ", " +
                                      provider.selectedAddressModel
                                          .addressBuilding! +
                                      ", " +
                                      provider.selectedAddressModel
                                          .addressStreetName!,
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
                                                    // getDeliveryCharge();
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
                                    // getDeliveryCharge();
                                    setState(() {});
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.deepOrange,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: Helper.getScreenWidth(context),
                                          height: 40,
                                          child: Text(
                                            "Add a delivery address",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(.6),
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
              title: Text(
                "₹${provider.totalCartPrice}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.6),
                ),
              ),
              subtitle: Text(
                "View Detailed Bill",
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      if (null != provider.selectedAddressModel.addressId &&
                          provider.selectedAddressModel.addressId!.isNotEmpty &&
                          deliveryType == 1 || deliveryType == 2) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentSection(deliveryType!)));
                      }

                      else
                      {
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
                      "Proceed to Pay",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary:
                          null != provider.selectedAddressModel.addressId &&
                                  provider.selectedAddressModel.addressId!
                                      .isNotEmpty &&
                                  deliveryType == 1 || deliveryType == 2
                              ? Colors.deepOrange
                              : Colors.deepOrange.shade100,
                      fixedSize: Size(190, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
    setState(() {});
  }
}
