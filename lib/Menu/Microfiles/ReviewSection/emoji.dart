import 'package:flutter/material.dart';
class Emoji extends StatefulWidget {
  double? rating;
   Emoji(this.rating);

  @override
  State<Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> {
  String? review;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(right:3),
              child: Icon(Icons.emoji_emotions_outlined,size: 20,),
            ),
          ),
          TextSpan(text: widget.rating!.toStringAsFixed(2),style: TextStyle(color: Colors.grey,fontSize: 15)),
        ],
      ),
    );

  }
  // ConvertRating() {
  //   switch (widget.rating) {
  //     case 1:
  //     setState(() {
  //   review == "GOOD";
  //     });
  //     // do something
  //       break;
  //
  //   }
  // }
}
