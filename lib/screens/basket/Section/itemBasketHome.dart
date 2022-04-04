import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/payment_home.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/deliveryInstructions.dart';
import 'package:foodzer_customer_app/screens/basket/Section/headerCard.dart';
import 'package:foodzer_customer_app/screens/basket/Section/proceedToPay.dart';

import 'package:foodzer_customer_app/screens/basket/Section/savedcontainer.dart';
import 'package:foodzer_customer_app/screens/basket/Section/tipyourHungerSavior.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';


class ItemBasketHome extends StatefulWidget {

  // dynamic totalPrice;
  //  ItemBasketHome(this.totalPrice);

  @override
  _ItemBasketHomeState createState() => _ItemBasketHomeState();
}

class _ItemBasketHomeState extends State<ItemBasketHome> {

  bool isFromCart = true;
  String? myAddress = "";
  @override
  void initState() {
    // TODO: implement initState
    getCurrentAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Consumer<ApplicationProvider>(
        builder: (context, provider, child)
   {
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: Colors.white,
         leading: IconButton(onPressed: () {
           Navigator.of(context).pop();
         }, icon: Icon(Icons.keyboard_backspace_outlined,
             color: Colors.black.withOpacity(.5), size: 30)),
         title: Text(provider.selectedRestModel.branchDetails!.merchantBranchName.toString(),
             style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
                 fontSize: 16)),
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
                       child: BasketHeader()),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(
                             left: 20, top: 20, bottom: 10),
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
                   Padding(
                     padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                     child: Text(
                       "Tip Your hunger saviour",
                       style:
                       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.only(
                         left: 20, right: 20, top: 10, bottom: 10),
                     child: TipYourHungerSecond(),
                   ),
                   Padding(
                     padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                     child: Text(
                       "Delivery instructions",
                       style:
                       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                     ),
                   ),
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: DeliveryInstructions(),
                   ),
                   Padding(
                     padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                     child: Text(
                       "Bill Details",
                       style:
                       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                     ),
                   ),
                   Padding(
                       padding: EdgeInsets.only(
                           top: 10, left: 10, right: 10, bottom: 50),
                       child:summaryView()),
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
  Widget summaryView(){
    double totalAmt=0;
    double deliveryFee =0;
    double deliveryTip =0;
    double taxAndCharges =0;
    double alltotal =0;
    return Consumer<ApplicationProvider>(
        builder: (context, provider, child) {
          for(Item item in provider.cartModelList){
            totalAmt=totalAmt+item.totalPrice!;
            alltotal=totalAmt+deliveryFee+deliveryTip+taxAndCharges;
            provider.setTotalCartPrice(alltotal);
          }

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
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15, top: 15),
                          // child: Text("Delivery Fee | 1.7 kms"),
                          child: Tooltip(
                            preferBelow: false,
                            message: 'Delivery Fee break up for this order',
                            triggerMode: TooltipTriggerMode.tap,
                            child: Text('Delivery Fee',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.deepOrangeAccent,
                                )),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(right: 15, top: 15),
                          child: Text("₹$deliveryFee"),
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
                    style:
                    TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20),
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
                      child: Text("₹$deliveryTip"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      child: Tooltip(
                        preferBelow: false,
                        message: 'Tax and charges',
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
                      child: Text("₹$taxAndCharges"),
                    ),
                  ],
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20),
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
                      child: Text("₹$alltotal",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.6))),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
  Widget proceedToPay(){
    return Consumer<ApplicationProvider>(
        builder: (context, provider, child) {
          // for(Item item in provider.cartModelList){
          //   totalAmt=totalAmt+item.totalPrice!;
          //   alltotal=totalAmt+deliveryFee+deliveryTip+taxAndCharges;
          // }
          return
            Container(
              width: Helper.getScreenWidth(context) * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20

                  ),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: null!= myAddress && myAddress!.isNotEmpty?ListTile(
                          title: Text(
                            "Deliver to Home | 21 MINS",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.6),
                            ),
                          ),
                          subtitle: Text(
                            myAddress.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 12),
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

                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                              Icon(Icons.home,color: Colors.deepOrange),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoogleMapScreen(isFromCart)));
                                },
                                  child: Icon(
                                      Icons.keyboard_arrow_down_rounded ,
                                      size: 20,color: Colors.deepOrange)
                              ),


                            ]
                            ),

                          ),
                        ):InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoogleMapScreen(isFromCart)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.deepOrange,
                                ),
                                SizedBox(width: 5,),
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
                                        color: Colors.black.withOpacity(.6),
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
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20, right: 20,),
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
                      style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 12,fontWeight: FontWeight.w600),
                    ),
                    trailing: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            if(null!=myAddress && myAddress!.isNotEmpty){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentSection()));
                            } else{
                              Fluttertoast.showToast(
                                  msg: "Select a delivery address to continue",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.deepOrange,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          },
                          child: Text(
                            "Proceed to Pay",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: null!=myAddress && myAddress!.isNotEmpty?
                                  Colors.deepOrange
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
        }
    );
  }
  getCurrentAddress() async{
    UserPreference().getDeliveryAddress().then((value) => {
      print('address is $value'),
      setState(() {
        myAddress = value;
      })
    });
  }
}
