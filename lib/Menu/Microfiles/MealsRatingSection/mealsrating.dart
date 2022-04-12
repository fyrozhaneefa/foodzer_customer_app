import 'package:flutter/material.dart';

class MealsRating extends StatelessWidget {
  const MealsRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child:Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: .5,
        title: Text("RATE YOUR MEAL"),
      ),
    ));
  }
}
