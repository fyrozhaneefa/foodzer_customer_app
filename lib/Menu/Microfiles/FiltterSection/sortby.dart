import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/radiobutton.dart';

import 'constants/divider.dart';

class SortBy extends StatefulWidget {
  const SortBy({Key? key}) : super(key: key);

  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<int>(
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text("Recommendation",
              style: TextStyle(
                fontSize: 14,
              )),
          value: 2,
          groupValue: value,
          onChanged: (newvalue) {
            setState(() {
              value = newvalue!;
            });
          },
          activeColor: Colors.deepOrange,
        ),
        Dividersection(),
        RadioListTile<int>(
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text("Min.Order Amount",
              style: TextStyle(
                fontSize: 14,
              )),
          value: 3,
          groupValue: value,
          onChanged: (newvalue) {
            setState(() {
              value = newvalue!;
            });
          },
          activeColor: Colors.deepOrange,
        ),
        Dividersection(),
        RadioListTile<int>(
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text("Fastest Delivery",
              style: TextStyle(
                fontSize: 14,
              )),
          value: 4,
          groupValue: value,
          onChanged: (newvalue) {
            setState(() {
              value = newvalue!;
            });
          },
          activeColor: Colors.deepOrange,
        ),
        Dividersection(),
        RadioListTile<int>(
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text("A to Z",
              style: TextStyle(
                fontSize: 14,
              )),
          value: 5,
          groupValue: value,
          onChanged: (newvalue) {
            setState(() {
              value = newvalue!;
            });
          },
          activeColor: Colors.deepOrange,
        ),
        Dividersection(),
        RadioListTile<int>(
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text("Rating",
              style: TextStyle(
                fontSize: 14,
              )),
          value: 6,
          groupValue: value,
          onChanged: (newvalue) {
            setState(() {
              value = newvalue!;
            });
          },
          activeColor: Colors.deepOrange,
        ),
      ],
    );
  }
}
