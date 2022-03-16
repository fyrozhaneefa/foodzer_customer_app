import 'package:flutter/material.dart';

class ApplyButton extends StatefulWidget {
  ApplyButton({Key? key,required this.buttonname, required this.radius}) : super(key: key);
  String buttonname;
  double radius;


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
          child: Text(widget.buttonname
            ,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange,
            fixedSize: Size(320, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        ),
      ),
    );
  }
}
