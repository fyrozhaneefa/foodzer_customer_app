import 'package:flutter/material.dart';

import 'Constants/radiobutton.dart';
import 'Constants/sapperator.dart';

class UpiSection extends StatefulWidget {
  int? delType;
  UpiSection(this.delType);

  @override
  State<UpiSection> createState() => _UpiSectionState();
}

class _UpiSectionState extends State<UpiSection> {
  @override
  Widget build(BuildContext context) {






    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Google Pay",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Card(
                      child: Image(
                        image: NetworkImage(
                            "https://1000logos.net/wp-content/uploads/2020/04/Google-Pay-Logo.png"),
                      ),
                    ),
                  ),


              ),
              MySeparator(),
              ListTile(
                subtitle: Text(
                  "You need to have a registered UPI ID.",
                  style: TextStyle(fontSize: 11),
                ),
                title: Text(
                  "Add New UPI ID",
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
            ],
          ),
        ),
      ),
    );
  }

}
