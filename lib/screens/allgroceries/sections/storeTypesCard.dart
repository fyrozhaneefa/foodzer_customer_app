import 'package:flutter/material.dart';

class StoreTypesCard extends StatelessWidget {
  final String? storeTypes;
  final bool isActive = false;
  final press;
  const StoreTypesCard({
    Key? key,
    required this.storeTypes, this.press,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: 10.0,bottom: 20),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive? Colors.deepOrange:Colors.white,
            border:isActive? Border.all(color: Colors.deepOrange):Border.all(color:Colors.grey.shade600),
            borderRadius: BorderRadius.circular(14)
        ),
        child: Text(
          storeTypes!,
          style: TextStyle(
            color:isActive? Colors.white:Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
