import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/OrderPlaced/orderplaced.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:foodzer_customer_app/utils/paymentUtils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:validators/validators.dart';


class AddNewCard extends StatefulWidget {
  int delType;
  AddNewCard(this.delType);
  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  TextEditingController cardNoController = new TextEditingController();
  TextEditingController validThroughController = new TextEditingController();
  TextEditingController cvvController = new TextEditingController();
  TextEditingController holderNameController = new TextEditingController();
  FocusNode? cardNumberFocus, cardNameFocus, expiryFocus, cvvFocus;
  CardType? cardtype;
  String? cardNumber;
  int? month;
  int? year;
  String? cvv;
  String? cardHolderName;
  bool isLoading = false;
  UserData userModel = new UserData();
  var _selectedApp;

  String? itemOrderId = "";

  @override
  void initState() {
    cardNumberFocus = FocusNode();
    cardNameFocus = FocusNode();
    expiryFocus = FocusNode();
    cvvFocus = FocusNode();

    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        backgroundColor: Colors.white,
        title:Consumer<ApplicationProvider>(builder: (context, provider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Add New Card",
              style: TextStyle(
                  color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3,),
            Text("${provider.cartModelList.length} item . Total: ₹${provider.toPayAmt}",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ))
          ]);
        }),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_rounded, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              child: TextFormField(
                controller: cardNoController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                maxLength: 19,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  MaskedTextInputFormatter(
                    mask: 'xxxx-xxxx-xxxx-xxxx',
                    separator: '-',
                  ),
                  // FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  String displayValue = value!.replaceAll(RegExp('-'), '');

                  Future.delayed(
                      Duration.zero,
                      () => setState(() {
                            cardtype =
                                PaymentUtils().detectCardType(displayValue);
                            String valueCheck =
                                value.replaceAll(RegExp('-'), ' ');
                            cardNumber = valueCheck;
                          }));

                  // print(displayValue);
                  if (displayValue.length > 0) {
                    if (!isNumeric(displayValue)) {
                      return "Card number must be in digit";
                    } else if (displayValue.length < 16) {
                      return "Enter valid card number";
                    }
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  suffixIcon: null != cardtype
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: PaymentUtils().cardImage(cardtype!)),
                        )
                      : null,
                  label: Text("Card Number"),
                  labelStyle: TextStyle(
                    color: Color(0xff557EAE),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent, width: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onFieldSubmitted: (String val) {
                  Navigator.of(context)
                      .focusScopeNode
                      .requestFocus(expiryFocus);
                },
                focusNode: cardNumberFocus,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 30),
                    child: Container(
                      child: TextFormField(
                        controller: validThroughController,
                        maxLength: 7,
                        inputFormatters: [
                          MaskedTextInputFormatter(
                            mask: 'MM/YYYY',
                            separator: '/',
                          ),
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        autovalidateMode: AutovalidateMode.always,
                        validator: validateMonthAndYear,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: 'MM/YYYY',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Color(0xff557EAE),
                          ),
                          labelText: 'Expiry Date',
                          labelStyle: TextStyle(
                            color: Color(0xff557EAE),
                          ),
                          counter: new SizedBox(
                            height: 0.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: .5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepOrangeAccent, width: .5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onFieldSubmitted: (String val) {
                          Navigator.of(context)
                              .focusScopeNode
                              .requestFocus(cvvFocus);
                        },
                        focusNode: expiryFocus,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
                        child: TextFormField(
                      controller: cvvController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        labelText: 'CVV',
                        labelStyle: TextStyle(
                          color: Color(0xff557EAE),
                        ),
                        counter: new SizedBox(
                          height: 0.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepOrangeAccent, width: .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        Future.delayed(
                            Duration.zero,
                            () => setState(() {
                                  cvv = value;
                                }));
                        if (value!.length > 0) {
                          if (!isNumeric(value)) {
                            return "CVV must be in digit";
                          }
                        }
                        return null;
                      },
                      focusNode: cvvFocus,
                      onFieldSubmitted: (String val) {
                        Navigator.of(context)
                            .focusScopeNode
                            .requestFocus(cardNameFocus);
                      },
                    )),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: TextFormField(
                  controller: holderNameController,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    Future.delayed(
                        Duration.zero,
                        () => setState(() {
                              cardHolderName = value;
                            }));
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    labelText: 'Card Holder Name',
                    labelStyle: TextStyle(
                      color: Color(0xff557EAE),
                    ),
                    counter: new SizedBox(
                      height: 0.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepOrangeAccent, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onFieldSubmitted: (String val) {
                    // Navigator.of(context).focusScopeNode.requestFocus(expiryFocus);
                  },
                  focusNode: cardNameFocus,
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  label: Text("Card Nickname (for easy indentification"),
                  labelStyle: TextStyle(
                    color: Color(0xff557EAE),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent, width: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                width: Helper.getScreenWidth(context),
                height: 55,
                child:isLoading?Center(
                  child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),
                ):
                ElevatedButton(
                  onPressed: () {
                    if (cardNoController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter a valid card number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (validThroughController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter a valid expire date",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (cvvController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter a valid cvv",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (holderNameController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter a valid name",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      WidgetsBinding.instance!.focusManager.primaryFocus
                          ?.unfocus();
                      orderCheckout();
                    }
                  },
                  child: Text(
                    "Proceed to Pay",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent..shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
   getUPIApps() async{
    await CashfreePGSDK.getUPIApps().then((value) => {
      if(value != null && value.length > 0) {
        _selectedApp = value[0]
      }
    });
  }
  // Future<void> seamlessUPIIntent() async {
  //   //Replace with actual values
  //   String orderId = "ORDER_ID";
  //   String stage = "PROD";
  //   String orderAmount = "ORDER_AMOUNT";
  //   String tokenData = "TOKEN_DATA";
  //   String customerName = "Customer Name";
  //   String orderNote = "Order_Note";
  //   String orderCurrency = "INR";
  //   String appId = "APP_ID";
  //   String customerPhone = "Customer Phone";
  //   String customerEmail = "sample@gmail.com";
  //   String notifyUrl = "https://test.gocashfree.com/notify";
  //
  //
  //   Map<String, dynamic> inputParams = {
  //     "orderId": orderId,
  //     "orderAmount": orderAmount,
  //     "customerName": customerName,
  //     "orderNote": orderNote,
  //     "orderCurrency": orderCurrency,
  //     "appId": appId,
  //     "customerPhone": customerPhone,
  //     "customerEmail": customerEmail,
  //     "stage": stage,
  //     "tokenData": tokenData,
  //     "notifyUrl": notifyUrl,
  //
  //
  //     // For seamless UPI Intent
  //     "appName": _selectedApp["id"]
  //   };
  //
  //   CashfreePGSDK.doUPIPayment(inputParams)
  //       .then((value) => value?.forEach((key, value) {
  //     print("$key : $value");
  //     //Do something with the result
  //   }));
  // }
  //
  // "notifyUrl": notifyUrl,
  // "card_number": "4706131211212123",
  // "card_expiryMonth": "07",
  // "card_expiryYear": "2023",
  // "card_holder": "Test",
  // "card_cvv": "123"
  Future<void> proceedPayment(String token) async {
    isLoading = true;
    setState(() {});

    String? orderId = itemOrderId;
    String? orderAmount = Provider.of<ApplicationProvider>(context, listen: false)
        .toPayAmt.toString();
    String? stage = "PROD";
    String? tokenData = token;
    String? customerName = userModel.userName;
    String? orderNote = "Test order";
    String? orderCurrency = "INR";
    String? appId = "117476780192ee56b9dad7efbb674711";
    String? customerPhone = userModel.userMobie;
    String? customerEmail = userModel.userEmail;
    // String? notifyUrl = "https://test.gocashfree.com/notify";
    // String orderId = "1154851";
    // String stage = "PROD";
    // String orderAmount = "500";
    // String tokenData = token;
    // String customerName = "Customer Name";
    // String orderNote = "Test order";
    // String orderCurrency = "INR";
    // String appId = "117476780192ee56b9dad7efbb674711";
    // String customerPhone = "9688521025";
    // String customerEmail = "sample@gmail.com";
    // String notifyUrl = "https://test.gocashfree.com/notify";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "tokenData": tokenData,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "paymentOption": "card",
      "card_number": cardNumber!.replaceAll(" ",""),
      "card_expiryMonth": month,
      "card_expiryYear": year,
      "card_holder": cardHolderName,
      "card_cvv": cvv
      // "notifyUrl": notifyUrl,



      // "card_number": "4706131211212123",
      // "card_expiryMonth": "07",
      // "card_expiryYear": "2023",
      // "card_holder": "Test",
      // "card_cvv": "123"


    };

    CashfreePGSDK.doPayment(inputParams).then((value){
      isLoading = false;
      setState(() {});
      if (value!['txStatus'] == "SUCCESS") {
        UserPreference().clearCartPreference();
        Provider.of<ApplicationProvider>(context, listen: false).clearData();
        Provider.of<ApplicationProvider>(context, listen: false).setOrderId(itemOrderId.toString());
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) =>
        //         HomeScreen()), (Route<dynamic> route) => false);
        onPaymentSuccess(value['orderId'],value['signature'],value['referenceId'],value['paymentMode'],value['orderAmount']);
        // showOrderPlaceDialogue();

        Fluttertoast.showToast(
            msg: value['txStatus'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrangeAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: value['txStatus'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      //Do something with the result
    });
  }
  onPaymentSuccess(String orderId, signature, refNo, paymentMode, orderAmount) async {
    var map = {
      "order_id": orderId,
      "signature": signature,
      "ref_no": refNo,
      "payment_mode": paymentMode,
      "order_status": "1",
      "order_amount": orderAmount,
    };
    String body = json.encode(map);
    print('body is $body');
    var response =
    await http.post(Uri.parse(ApiData.ORDER_SUCCESS), body: body);
    print(response.statusCode);
    if(response.statusCode == 200){
      print('response ${response.body}');
      var resp = json.decode(response.body);
      if(resp['errorcode'] == 0){
        showOrderPlaceDialogue();
      } else{
        print('Something went wrong');
      }
    }


  }
  orderCheckout() async {
    setState(() {
      isLoading = true;
    });
    ApplicationProvider provider =
        Provider.of<ApplicationProvider>(context, listen: false);
    String itemJson = "";
    for (Item item in provider.cartModelList) {
      if (null != item.addonsList && item.addonsList!.length > 0) {
        for (Addons addon in item.addonsList!) {
          if (null == item.addonIds) {
            item.addonIds = "";
          }
          item.addonIds = item.addonIds! + addon.itemAddonsSubtitleSubtitleId! + ",";
        }
        if (item.addonIds!.length > 0) {
          item.addonIds =
              item.addonIds!.substring(0, item.addonIds!.length - 1);
        }
      }
      itemJson = itemJson + Item.ToJson(item) + ",";
    }
    itemJson = itemJson.substring(0, itemJson.length - 1);
    itemJson = itemJson.replaceAll('\\', "");
    var map = {
      "lat": provider.selectedAddressModel.addressLat,
      "lng": provider.selectedAddressModel.addressLng,
      "merchant_branch": provider.selectedRestModel.merchantBranchId,
      "payment_mode": "2",
      "delivery_fee": provider.deliveryFee,
      "DEL_TYPE": widget.delType == 1?"delivery":"pickup",
      "address_id": provider.selectedAddressModel.addressId,
      "user_id": userModel.userId,
      "coupon_id": "",
      "special_note": "special entry",
      "wallet_amount": "0",
      "item_list": "[" + itemJson + "]"
    };

    String body = json.encode(map);

    print('body is $body');
    var response =
        await http.post(Uri.parse(ApiData.ORDER_CHECKOUT), body: body);

    setState(() {
      isLoading = false;
    });
    print(response.statusCode);
    print('response ${response.body}');
    var jsonData = json.decode(response.body);
    setState(() {
      itemOrderId = jsonData["order_id"];
    });

    if (jsonData['error_code'] == 0) {
      getPaymentToken();
    } else {
      Fluttertoast.showToast(
          msg: jsonData['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }

  getPaymentToken() async {
    setState(() {
      isLoading = true;
    });
    var map = new Map<String, dynamic>();
    map['amount'] = Provider.of<ApplicationProvider>(context, listen: false)
        .toPayAmt
        .toString();
    map['order_id'] = itemOrderId;

    var response =
        await http.post(Uri.parse(ApiData.GET_PAYMENT_TOKEN), body: map);
    setState(() {
      isLoading = false;
    });
    var json = jsonDecode(response.body);
    if (json['status'] == "OK") {
      proceedPayment(json['cftoken']);
    } else {
      Fluttertoast.showToast(
          msg: json['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }

  String? validateMonthAndYear(String? value) {
    {
      //print('Updated $value');
      List<String> monthAndYear = value!.split("/");
      if (monthAndYear.length > 1) {
        if (value.length > 0) {
          if (!isNumeric(monthAndYear[0])) {
            return "Month must be in digit";
          }
          int monthValue = int.parse(monthAndYear[0]);
          if (monthValue > 12) {
            return "Invalid Month";
          }
          if (monthAndYear.length > 1) {
            String value = monthAndYear[1];
            if (value.length > 0) {
              int yearValue = int.parse(monthAndYear[1]);
              Future.delayed(
                  Duration.zero,
                  () => setState(() {
                        month = monthValue;
                        year = yearValue;
                      }));
              var now = new DateTime.now();
              if (yearValue < now.year) {
                return "Invalid Year";
              }
              // print(yearValue);

            }
          }
        }
      }
      return null;
    }
  }
  showOrderPlaceDialogue(){

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: ClipRRect(
                  child: Image(
                      image: AssetImage(
                          "lib/Menu/Microfiles/assets/images/foodzer.jpg"),
                      width: 60),borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("Thank You",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text("Your order placed successfully",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>
                          OrderPlacedHome()), (Route<dynamic> route) => false);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.orange,
                  fixedSize: Size(120, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    // side: BorderSide(color: Colors.black.withOpacity(.3)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
            ],
          )
        ],
      ),
    );
  }
}
