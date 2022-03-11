import 'package:flutter/material.dart';

import 'instructionCard.dart';
class DeliveryInstructions extends StatelessWidget {
  const DeliveryInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, bottom: 10),
          child: InsructionCard(
              icon: Icons.door_sliding,
              text: "Leave at\nthe door"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: InsructionCard(
              icon: Icons.directions_sharp,
              text: "Directions\nto reach"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: InsructionCard(
              icon: Icons.security,
              text: "Leave with\nsecurity"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: InsructionCard(
              icon: Icons.notifications_active_sharp,
              text: "Avoid\nringing bell"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10,right: 10),
          child: InsructionCard(
              icon: Icons.phonelink_ring,
              text: "Avoid\ncalling"),
        ),
      ],
    );
  }
}
