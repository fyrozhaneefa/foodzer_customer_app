import 'package:flutter/material.dart';

class CheckBoxSection extends StatefulWidget {
  const CheckBoxSection({Key? key}) : super(key: key);

  @override
  _CheckBoxSectionState createState() => _CheckBoxSectionState();
}

class _CheckBoxSectionState extends State<CheckBoxSection> {
  List<String> _list = [];

  bool? check11 = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: check11,
      onChanged: (value) {
        setState(() {
          check11 = value;
          String selectVal = "SelectedValues";
          value! ? _list.add(selectVal) : _list.remove(selectVal);
        });
      },
      activeColor: Colors.deepOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      side: BorderSide(width: 1, color: Colors.grey),
    );
  }
}
