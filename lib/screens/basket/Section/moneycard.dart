import 'package:flutter/material.dart';

class MoneyCard extends StatefulWidget {
   MoneyCard({Key? key,required this.text}) : super(key: key);
  String text;

  @override
  State<MoneyCard> createState() => _MoneyCardState();
}

class _MoneyCardState extends State<MoneyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 30,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey.shade100,spreadRadius: 1,blurRadius: 1)
      ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200,width: 1),
      ),
    child: Center(child:Text(widget.text),));
  }
}
