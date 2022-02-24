import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  TextSection({Key? key, required this.label, required this.onpressed})
      : super(key: key);
  String label;
  final onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey,fontSize: 14),
          suffixIcon: TextButton(
            onPressed: onpressed,
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange.withOpacity(.2)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
