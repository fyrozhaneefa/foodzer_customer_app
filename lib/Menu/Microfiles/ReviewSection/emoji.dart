import 'package:flutter/material.dart';
class Emoji extends StatefulWidget {

  const Emoji({Key? key}) : super(key: key);

  @override
  State<Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> {


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
          TextSpan(text: "Very good",style: TextStyle(color: Colors.grey,fontSize: 15)),
        ],
      ),
    );

  }
}
