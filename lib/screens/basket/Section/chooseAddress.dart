import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class ChooseAddress extends StatefulWidget {
  bool isFromCart;
  List<AddressModel> getAddressList;
 ChooseAddress(this.isFromCart, this.getAddressList);

  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  String? data="";
  bool isLoading = false;
  int? deliverFromRestaurant;
  AddressModel selectedAddressModel = new AddressModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose your delivery address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 18,
                    ))
              ],
            ),
          ),
          Flexible(
            child: ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.getAddressList.length,
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedAddressModel = widget.getAddressList[index];

                // newly added only for demo remove these 2 lines and enable the below getDeliverableAreaFromRest() to get the delivery charge

                      // Provider.of<ApplicationProvider>(context, listen: false)
                      //     .setAddressModel(selectedAddressModel);
                      // Navigator.of(context).pop();
                    });
                    getDeliverableAreaFromRest(widget.getAddressList[index].addressLat.toString(),widget.getAddressList[index].addressLng.toString());
                  },
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          widget.getAddressList[index].addressTitle == "HOME"?
                          Icons.home:
                          widget.getAddressList[index].addressTitle == "WORK"?
                          Icons.work:
                          widget.getAddressList[index].addressTitle == "FRIENDS"?
                          Icons.person_pin:
                          Icons.person_pin,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.getAddressList[index].addressTitle.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                  widget.getAddressList[index].addressBuilding.toString()+" "+
                  widget.getAddressList[index].adressApartmentNo.toString()+" "+
                      widget.getAddressList[index].addressStreetName.toString()+" "+
                      widget.getAddressList[index].currentAddressLine.toString(),
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis, fontSize: 12),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10,),
          MySeparator(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          GoogleMapScreen(new AddressModel(),
                              widget.isFromCart,LatLng(0, 0))));
            },
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              title: Text(
                'Add new Address',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          )
        ],
      ),
    );
  }

  getDeliverableAreaFromRest(String lat,String lng) async {
    isLoading = true;
    setState(() {

    });
    var map = new Map<String, dynamic>();
    map['merchant_branch_id'] = Provider.of<ApplicationProvider>(context ,listen: false).selectedRestModel.branchDetails!.merchantBranchId;
    map['lat'] = lat;
    map['lng'] = lng;

    var response =
    await http.post(Uri.parse(ApiData.CHECK_DISTANCE_FROM_RESTAURANT), body: map);

    var json = jsonDecode(response.body);
    isLoading =false;
    setState(() {
      // deliverFromRestaurant = json['status'];
      deliverFromRestaurant = json;
    });
    if(deliverFromRestaurant == 0){
      Provider.of<ApplicationProvider>(context, listen: false)
          .setAddressModel(selectedAddressModel);
      Navigator.of(context).pop();
      setState(() {

      });
    } else{
      // AddressModel addressModel = new AddressModel();
      // Provider.of<ApplicationProvider>(context, listen: false)
      //     .setAddressModel(addressModel);
      Fluttertoast.showToast(
          msg: "Selected location is too far from restaurant.",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.red);
    }
  }
}