import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {
  String? locality, currentAddress;
  AddressModel addressModel=new AddressModel();
  AddDeliveryAddress(this.locality, this.latLongCurrent, this.currentAddress,this.addressModel);
  LatLng latLongCurrent = LatLng(0, 0);

  @override
  _AddDeliveryAddressState createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {

  TextEditingController streetController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController placeController = new TextEditingController();
  TextEditingController directionController = new TextEditingController();
  FocusNode directionToReachNode=new FocusNode();
  bool isLoading = false;
  UserData userModel = new UserData();
  List<String> addressTitle = ["HOME", "WORK", "FRIENDS", "OTHER"];
  int? selectedIndex;
  String? addressType;

  @override
  void initState() {
print("asdhajsgdhjasgdhjasgdjhgasd${widget.locality},${widget.currentAddress}");
    if(null!=widget.addressModel.addressId && widget.addressModel.addressId!.isNotEmpty){
      addressController.text=widget.addressModel.addressBuilding!;
      placeController.text=widget.addressModel.adressApartmentNo!;
      directionController.text=widget.addressModel.addressDirection!;
      addressType=widget.addressModel.addressTitle;
      selectedIndex=addressTitle.indexWhere((element) => element.toLowerCase()==addressType!.toLowerCase());
      directionToReachNode.requestFocus();

    }
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
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
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'ADD YOUR ADDRESS DETAILS',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Flexible(
              child: ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.black,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.locality.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.currentAddress.toString(),
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                height: 1.3),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: Helper.getScreenWidth(context),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.orange.shade100,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.orange[50]),
                        child: Text(
                          'A detailed address will help our Delivery Partner reach your doorstep easily',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.deepOrange[800],
                              height: 1.3),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Visibility(
                        visible: null==widget.locality,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: streetController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepOrangeAccent, width: 2.0),
                                  ),
                                  labelText: 'STREET NAME',
                                  labelStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: addressController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2.0),
                            ),
                            labelText: 'HOUSE / FLAT / BLOCK NO.',
                            labelStyle:
                            TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: placeController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepOrangeAccent, width: 2.0),
                            ),
                            labelText: 'APARTMENT / ROAD / AREA (OPTIONAL)',
                            labelStyle:
                            TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'DIRECTION TO REACH (OPTIONAL)',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                          textInputAction: TextInputAction.done,
                          maxLength: 200,
                          controller: directionController,
                          focusNode: directionToReachNode,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.all(10),
                            hintText: "eg: Ring the bell on the red gate.",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey)
                              // width: 0.0 produces a thin "hairline" border
                              // borderSide:  BorderSide(color: HexColor("#557EAE"), width: 0.0),
                            ),
                            // labelStyle: new TextStyle(color: HexColor("#557EAE")),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(200),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'SAVE THIS ADDRESS AS',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: addressTitle.length,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      addressType = addressTitle[index];
                                    });
                                  },
                                  child: Container(
                                      margin:
                                      EdgeInsets.only(left: 10, right: 20),
                                      padding:
                                      EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade100,
                                              spreadRadius: 1,
                                              blurRadius: 1)
                                        ],
                                        color: selectedIndex == index
                                            ? Colors.deepOrange.shade50
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: selectedIndex == index
                                              ? Colors.deepOrange
                                              : Colors.grey.shade200,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            addressTitle[index] == "HOME"
                                                ? Icons.home
                                                : addressTitle[index] == "WORK"
                                                ? Icons.work
                                                : addressTitle[index] ==
                                                "FRIENDS"
                                                ? Icons.person_pin
                                                : Icons.person_pin,
                                            size: 14,
                                            color: selectedIndex == index
                                                ? Colors.deepOrange
                                                : Colors.black,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            addressTitle[index].toString(),
                                            style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors.deepOrange
                                                    : Colors.black,
                                                fontSize: 12),
                                          )
                                        ],
                                      )),
                                )),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 45,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: () {
                  if(null!=widget.locality && widget.locality!.isNotEmpty){
                    if (addressController.text.length > 0 &&
                        addressController.text.isNotEmpty &&
                        null != addressType) {
                      saveAddress();
                    }
                  } else{
                    if (streetController.text.isNotEmpty && addressController.text.length > 0 &&
                        addressController.text.isNotEmpty &&
                        null != addressType) {
                      saveAddress();
                    }
                  }

                },
                child: Container(
                  child: Text(
                    null==widget.locality&&streetController.text.isEmpty?"Enter Street Name":
                    null!=widget.addressModel.addressId && widget.addressModel.addressId!.isNotEmpty?
                        "UPDATE ADDRESS":
                    addressController.text.length > 0 &&
                        null != addressType
                        ? "SAVE AND PROCEED"
                        : addressController.text.isEmpty
                        ? "Enter House/Flat/Block No."
                        : "Choose address name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: addressController.text.length > 0 &&
                        null != addressType
                        ? Colors.deepOrange
                        : Colors.deepOrangeAccent.shade100,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      // side: BorderSide(color: Colors.grey)
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveAddress() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    if( null!=widget.addressModel.addressId && widget.addressModel.addressId!.isNotEmpty) {
      map['user_id'] = userModel.userId;
      map['user_name'] = userModel.userName;
      map['submit_type'] = "edit";
      map['property_type'] = "1";
      map['address_title'] = addressType;
      map['street'] = null!=widget.locality?widget.locality:streetController.text;
      map['floor'] = "";
      map['building'] = addressController.text;
      map['apartment_no'] = placeController.text;
      map['additional_direction'] = directionController.text;
      map['mob_no'] = userModel.userMobie;
      map['address_lat'] = widget.latLongCurrent.latitude.toString();
      map['address_lng'] = widget.latLongCurrent.longitude.toString();
      map['address_id'] = widget.addressModel.addressId;
      map['current_addressline'] = widget.currentAddress.toString();
    }else{
      map['user_id'] = userModel.userId;
      map['user_name'] = userModel.userName;
      map['submit_type'] = "add";
      map['property_type'] = "1";
      map['address_title'] = addressType;
      map['street'] = null!=widget.locality?widget.locality:streetController.text;
      map['floor'] = "";
      map['building'] = addressController.text;
      map['apartment_no'] = placeController.text;
      map['additional_direction'] = directionController.text;
      map['mob_no'] = userModel.userMobie;
      map['address_lat'] = widget.latLongCurrent.latitude.toString();
      map['address_lng'] = widget.latLongCurrent.longitude.toString();
      map['address_id'] = "";
      map['current_addressline'] = widget.currentAddress.toString();
    }

    String api="";
    if( null!=widget.addressModel.addressId && widget.addressModel.addressId!.isNotEmpty) {
      api=ApiData.EDIT_ADDRESS;
    }else{
      api=ApiData.ADD_ADDRESS;
    }

    var response = await http.post(Uri.parse(api), body: map);

    var json = convert.jsonDecode(response.body);
    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      int errorCode = json['error_code'];

      if (errorCode == 0) {
        AddressModel addressModel = AddressModel.fromJson(json['address_list']);
        Provider.of<ApplicationProvider>(context, listen: false)
            .setAddressModel(addressModel);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "Something happened please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
      }
      setState(() {

      });
    }
  }
}
