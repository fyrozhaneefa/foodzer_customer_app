import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dividersection extends StatelessWidget {
  const Dividersection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 10),child: Divider(thickness: 0.8,height:1 ),);
  }
}
