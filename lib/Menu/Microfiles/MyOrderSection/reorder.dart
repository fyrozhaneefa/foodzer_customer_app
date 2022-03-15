import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReorderButton extends StatelessWidget {
  ReorderButton(
      {Key? key,
      })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
           "REORDER",
            style: TextStyle(color:  Colors.orange.shade800, fontWeight: FontWeight.w600),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color:Colors.orange.shade300, width: 1.5),
            fixedSize: Size(160, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only( top: 10),
          child: Text(
            "You haven't rated",
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only( top: 10),
          child: Text(
            "this delivery yet",
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
