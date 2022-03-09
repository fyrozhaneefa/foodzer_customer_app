import 'package:flutter/material.dart';
class ReviewSection extends StatefulWidget {

 const ReviewSection({Key? key}) : super(key: key);

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
    title: Text("Amazing",style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),),
    subtitle: Text("Great",style: TextStyle(color: Colors.black)),
   leading: Icon(Icons.emoji_emotions_outlined), );

  }
}
