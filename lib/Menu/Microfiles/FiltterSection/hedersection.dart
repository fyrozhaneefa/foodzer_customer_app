import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/sizedbox.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.070),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close_sharp),
            ),
          ),
        ),
        Swidth(),
        Text(
          "Filters",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Swidth(),
        TextButton(
          onPressed: () {},
          child: Text(
            "Clear all",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.deepOrangeAccent),
          ),
        ),
      ],
    );
  }
}
