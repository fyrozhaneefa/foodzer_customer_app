import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/sizedbox.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/Swidth.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.070),
          borderRadius: BorderRadius.circular(30),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close_sharp),
        ),
      ),
      title: Center(
        child: Text("Filters",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            )),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(top: 15),
          child: Text(
            "Clear all",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.deepOrangeAccent),
          ),
        ),
    );
  }
}
