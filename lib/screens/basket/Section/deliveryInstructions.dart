import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/addDeliveryAddress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'instructionCard.dart';
class DeliveryInstructions extends StatefulWidget {
  const DeliveryInstructions({Key? key}) : super(key: key);

  @override
  State<DeliveryInstructions> createState() => _DeliveryInstructionsState();
}

class _DeliveryInstructionsState extends State<DeliveryInstructions> {
  List<String> delInst = ['Leave at the door', 'Direction to reach', 'Leave with security', 'Avoid ringing bell', 'Avoid calling'];
  List<IconData> delInstIcons = [Icons.door_sliding, Icons.directions_sharp, Icons.security,Icons.notifications_active_sharp,Icons.phonelink_ring];
  List<ListItem> _items = [
    ListItem(title: 'Leave at the door', isSelected: false, icon: Icons.door_sliding),
    ListItem(title: 'Direction to reach', isSelected: false, icon: Icons.directions_sharp),
    ListItem(title: 'Leave with security', isSelected: false, icon: Icons.security),
    ListItem(title: 'Avoid ringing bell', isSelected: false, icon: Icons.notifications_active_sharp),
    ListItem(title: 'Avoid calling', isSelected: false, icon: Icons.phonelink_ring),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
     return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index){
        return  InkWell(
          onTap: () {
            if(index == 1){
              if(null!=provider.selectedAddressModel.addressId && provider.selectedAddressModel.addressId!.isNotEmpty) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        AddDeliveryAddress("locality",
                            LatLng(double.parse(
                                provider.selectedAddressModel.addressLat!),
                                double.parse(
                                    provider.selectedAddressModel.addressLng!)),
                            provider.selectedAddressModel.currentAddressLine,
                            provider.selectedAddressModel)));
              }
            } else {
              _items[index].isSelected = !_items[index].isSelected!;
              setState(() {

              });
            }
          },
          child: Container(
            height: 85,
            width: 90,
            margin: EdgeInsets.only(right:10),
            decoration: BoxDecoration(
              color:index == 1 || _items[index].isSelected!?Colors.deepOrange.shade100: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border:Border.all(color:index ==1 || _items[index].isSelected!?Colors.deepOrangeAccent
                  :
              Colors.grey.shade200,width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Icon(_items[index].icon,size: 20,

                    color: Colors.black.withOpacity(.6),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10,top: 10),child:Text(_items[index].title.toString(),style: TextStyle(fontSize: 12,color: Colors.grey.shade600),) ,)

              ],
            ),
          ),
        );
      },

    );
    });
  }
}
class ListItem {
  String? title;
  bool? isSelected;
  IconData? icon;
  ListItem({
    this.title,
    this.isSelected,
    this.icon,
  });
}