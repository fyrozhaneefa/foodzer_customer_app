import 'package:flutter/material.dart';

class ApplyButton extends StatefulWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  _ApplyButtonState createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Apply",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange,
            fixedSize: Size(320, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ),
    );
  }
}
