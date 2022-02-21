import 'package:flutter/material.dart';
class DividerSection extends StatelessWidget {
  const DividerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),child: Divider());

  }
}
