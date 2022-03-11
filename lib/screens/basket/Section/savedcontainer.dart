import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
class SavedContainer extends StatelessWidget {
   SavedContainer({Key? key,required this.child}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        height:60,
        width: Helper.getScreenWidth(context)*1,
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
    ),
    child: child);
  }
}
