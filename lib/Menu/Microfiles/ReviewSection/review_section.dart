import 'package:flutter/material.dart';
class ReviewSection extends StatefulWidget {

 const ReviewSection({Key? key}) : super(key: key);

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 8),
      child: Icon(Icons.emoji_emotions_outlined),
    );

  }
}
