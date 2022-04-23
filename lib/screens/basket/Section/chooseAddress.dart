import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';



class ChooseAddress extends StatefulWidget {
  bool isFromCart;
  List<AddressModel> getAddressList;
 ChooseAddress(this.isFromCart, this.getAddressList);

  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  String? data="";

  @override
  void initState() {
    // TODO: implement initState


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
                    Provider.of<ApplicationProvider>(context, listen: false)
                        .setAddressModel(widget.getAddressList[index]);
                    Navigator.of(context).pop();
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
                          GoogleMapScreen(
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


}