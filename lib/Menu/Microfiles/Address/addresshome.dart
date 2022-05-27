import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/Address/savedaddress.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  bool isLoading = false;
  UserData userModel = new UserData();
  List<AddressModel> addressList = [];


  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {

      });
      getUserAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: .5,
        backgroundColor: Colors.white,
        leading:InkWell(child: Icon(Icons.keyboard_backspace_outlined, color: Colors.black),onTap: (){

          Navigator.pop(context);
        }),
        title: Text(
          "ADDRESSES",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: isLoading?
      ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: ShimmerWidget.rectangular(
                        height: 20,
                        width: 100,
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ShimmerWidget.rectangular(
                            height: 20,
                            width: 180,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(right: 10, bottom: 10),
                          child: ShimmerWidget.rectangular(
                            height: 80,
                            width: 80,
                          ),
                        )
                      ],
                    )
                  ],
                ));
          })
          : ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("SAVED ADDRESSES",   style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12,fontWeight: FontWeight.w500),),
          ),
          Container(
            color: Colors.white,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            addressList[index].addressTitle == "HOME" ?
                            Icons.home :
                            addressList[index].addressTitle == "WORK" ?
                            Icons.work :

                            addressList[index].addressTitle == "FRIENDS" ?
                            Icons.person_pin :
                            Icons.person_pin,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child:
                              Text(addressList[index].addressTitle.toString(),

                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),


                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Container(
                                  width: Helper.getScreenWidth(context) * .8,
                                  child: Text(
                                    addressList[index].addressBuilding.toString()+" "+
                                        addressList[index].adressApartmentNo.toString()+" "+
                                        addressList[index].addressStreetName.toString()+" "+
                                        addressList[index].currentAddressLine.toString(),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.6),
                                        fontSize: 12),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top:8),
                              child: Text(
                                  "Phone Number : " + addressList[index].addressMobNo!,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontSize: 12)),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GoogleMapScreen(addressList[index],
                                                      true,LatLng(double.parse(addressList[index].addressLat!),
                                                      double.parse(addressList[index].addressLng!))))).then((value){
                                        getUserAddress();
                                      });
                                    },
                                    child: Text(
                                      "EDIT",
                                      style: TextStyle(
                                          color: Colors.orange.shade600,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, bottom: 20),
                                  child: InkWell(
                                    onTap: (){
                                      deleteUserAddress(addressList[index].addressId.toString());
                                    },
                                    child: Text(
                                      "DELETE",
                                      style: TextStyle(
                                          color: Colors.orange.shade600,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       top: 20, left: 20, bottom: 20),
                                //   child: InkWell(
                                //     child: Text(
                                //       "SHARE",
                                //       style: TextStyle(
                                //           color: Colors.orange.shade600,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: addressList.length)

          ),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            top: 10, left: 20, bottom: 10, right: 20),
        child: Container(
          width: Helper.getScreenWidth(context),
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          GoogleMapScreen(new AddressModel(),
                              true,LatLng(0, 0)))).then((value) {
                getUserAddress();
              });
            },
            child: Text(
              "ADD NEW ADDRESS",
              style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.green,width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
      ),
    );
  }
  deleteUserAddress(String addressId) async{
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['address_id'] = addressId;
    var response =
    await http.post(Uri.parse(ApiData.DELETE_ADDRESS), body: map);
    var json = convert.jsonDecode(response.body);
    isLoading = false;
    setState(() {});
    if(json["error_code"] == 0){
      getUserAddress();
    } else{
      print("Some error occured");
    }
  }

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
    if (null != dataList && dataList.length > 0) {
      addressList = dataList
          .map((address) => new AddressModel.fromJson(address))
          .toList();
      setState(() {});
    }

  }
}
