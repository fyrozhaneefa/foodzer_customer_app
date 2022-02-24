import 'package:flutter/material.dart';

class CreditDebit extends StatelessWidget {
  const CreditDebit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: ListTile(subtitle: Text("Save and Pay via Cards.",style: TextStyle(fontSize:11),),
          title: Text(
            "Add New Card",
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.w600),
          ),
          leading: Container(
            height: 24,
            width: 35,
            child: Icon(
              Icons.add,
              size: 15,
              color: Colors.deepOrange,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade300)),
          ),
        ),
      ),
    );
  }
}
