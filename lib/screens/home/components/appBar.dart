import 'package:flutter/material.dart';

AppBar homeAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 3,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    title:Column(
      children: [
        Container(
          child:Text(
            "Delivering to",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
            child:Text(
              "Salwa Road Al Miqab",
              style: TextStyle(
                  color:Colors.deepOrange,
                  fontSize: 16
              ),
            )
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed:(){
        },
        icon: Icon(
          Icons.search,
          size: 24,
          color: Colors.black,
        ),
      )
    ],
  );
}
