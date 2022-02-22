import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          trailing: Checkbox(
            value: check1,
            onChanged: (value) {
              setState(() {
                check1 = value;
                String selectVal = "Supersave";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Healthy Deals",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check2,
            onChanged: (value) {
              setState(() {
                check2 = value;
                String selectVal = "deals";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Vegan Options",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check3,
            onChanged: (value) {
              setState(() {
                check3 = value;
                String selectVal = "veganoptions";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Free Delivery",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check4,
            onChanged: (value) {
              setState(() {
                check4 = value;
                String selectVal = "freedelivery";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Dessert Deals",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check5,
            onChanged: (value) {
              setState(() {
                check5 = value;
                String selectVal = "dessertdeals";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Double Deal",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check6,
            onChanged: (value) {
              setState(() {
                check6 = value;
                String selectVal = "doubledeal";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Most Loved",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check7,
            onChanged: (value) {
              setState(() {
                check7 = value;
                String selectVal = "mostloved";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Groceries",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check8,
            onChanged: (value) {
              setState(() {
                check8 = value;
                String selectVal = "groceries";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Coffe joy",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check9,
            onChanged: (value) {
              setState(() {
                check9 = value;
                String selectVal = "Cricket";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("Newly Added", style: TextStyle(fontSize: 14)),
          trailing: Checkbox(
            value: check10,
            onChanged: (value) {
              setState(() {
                check10 = value;
                String selectVal = "newlyadded";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        Dividersection(),
        ListTile(
          title: Text("All Deals",
              style: TextStyle(
                fontSize: 14,
              )),
          trailing: Checkbox(
            value: check11,
            onChanged: (value) {
              setState(() {
                check11 = value;
                String selectVal = "alldeals";
                value! ? _list.add(selectVal) : _list.remove(selectVal);
              });
            },
            activeColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
