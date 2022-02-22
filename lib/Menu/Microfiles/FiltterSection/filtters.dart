import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/CuisinesSection/checkbox.dart';

import 'constants/divider.dart';

class FiltterItems extends StatefulWidget {
  const FiltterItems({Key? key}) : super(key: key);

  @override
  State<FiltterItems> createState() => _FiltterItemsState();
}

class _FiltterItemsState extends State<FiltterItems> {
  List<String> _list = [];

  bool? check1 = false;
  bool? check2 = false;
  bool? check3 = false;
  bool? check4 = false;
  bool? check5 = false;
  bool? check6 = false;
  bool? check7 = false;
  bool? check8 = false;
  bool? check9 = false;
  bool? check10 = false;
  bool? check11 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Super Saver",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection()
        ),
        Dividersection(),
        ListTile(
          title: Text("Healthy Deals",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Vegan Options",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Free Delivery",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Dessert Deals",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Double Deal",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Most Loved",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection()
        ),
        Dividersection(),
        ListTile(
          title: Text("Groceries",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing:CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Coffe joy",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing:CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("Newly Added", style: TextStyle(fontSize: 14)),
          trailing: CheckBoxSection(),
        ),
        Dividersection(),
        ListTile(
          title: Text("All Deals",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: CheckBoxSection(),
        ),
      ],
    );
  }
}
