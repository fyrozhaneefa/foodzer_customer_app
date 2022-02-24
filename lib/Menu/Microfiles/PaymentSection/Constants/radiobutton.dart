import 'package:flutter/material.dart';

import '../check.dart';
class RadioSection extends StatefulWidget {
  const RadioSection({Key? key}) : super(key: key);

  @override
  State<RadioSection> createState() => _RadioSectionState();
}

class _RadioSectionState extends State<RadioSection> {
  int value = 3;
  @override
  Widget build(BuildContext context) {
    return Radio<int>(
      value: 2,
      groupValue: value,
      onChanged: (newvalue) {
        setState(
              () {
               value= newvalue!;

          },
        );
      },
      activeColor: Colors.green,
    );
  }

}
