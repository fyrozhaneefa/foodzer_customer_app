import 'package:flutter/material.dart';

class InsructionCard extends StatelessWidget {
   InsructionCard({Key? key,required this.text,required this.icon}) : super(key: key);

  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Icon(icon,size: 20,

              color: Colors.black.withOpacity(.6),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 10,top: 10),child:Text(text,style: TextStyle(fontSize: 12,color: Colors.grey.shade600),) ,)

        ],
      ),
    );
  }
}
