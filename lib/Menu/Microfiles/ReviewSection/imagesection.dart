import 'package:flutter/material.dart';

class ImagesSection extends StatelessWidget {
  const ImagesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width:  60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
    child: Image(image: NetworkImage("https://st.depositphotos.com/1026166/3160/v/600/depositphotos_31605339-stock-illustration-restaurant-food-quality-badge.jpg")),);
  }
}
