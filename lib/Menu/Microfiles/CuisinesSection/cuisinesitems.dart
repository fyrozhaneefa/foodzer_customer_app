import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/divider.dart';


import 'checkbox.dart';
class CuisinesItems extends StatefulWidget {
  const CuisinesItems({Key? key}) : super(key: key);

  @override
  _CuisinesItemsState createState() => _CuisinesItemsState();
}

class _CuisinesItemsState extends State<CuisinesItems> {
  var Items = [

    "Acai","Afghani","African","American","Arabic","Arabic sweets","Asian","Bagel","Baked potatos","Bakery","BBQ","Beverages","Biriyni","Bowls",
    "Brazilian","Breakfast","Bubble tea","Burgers","Burrito","Cafe","Cafeteria","Cakes","Dim sum","Doner","Donuts","Dumpling","Egyptian","Falafel",
    "African","American","Arabic","Arabic sweets","Cafe","Cafeteria","Cakes","Dim sum","Doner","Breakfast","Bubble tea","Burgers","Burrito","Cafe",


  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, j) => ListTile(
            title: Text(Items.elementAt(j),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
            trailing: CheckBoxSection()),
        separatorBuilder: (context, _) => Dividersection(),
        itemCount:Items.length);
  }
}
