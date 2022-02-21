import 'package:flutter/material.dart';

import 'emoji.dart';
class MidListTile extends StatefulWidget {
  String text;

   MidListTile({Key? key,required this.text}) : super(key: key);

  @override
  _MidListTileState createState() => _MidListTileState();
}

class _MidListTileState extends State<MidListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(widget.text,style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),), trailing: Emoji());
  }
}
