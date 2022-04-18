import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MealsRating extends StatelessWidget {
  const MealsRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,

          elevation: .5,
          leading: InkWell(
              child: Icon(Icons.arrow_back_rounded, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
              }),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RATE YOUR MEAL",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "1 item.₹ 117",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 300,
                  child: Image(
                    image: NetworkImage(
                        "https://cdn.dribbble.com/users/1926893/screenshots/15607636/tastymealsfinal-cmyk_4x.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rate your meal",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Container(
                width: 50,
                child: Divider(
                  thickness: 2.5,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Hotel Rahmath",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.star_border_outlined,
                      color: Colors.grey.shade300, size: 32),
                  Icon(Icons.star_border_outlined,
                      color: Colors.grey.shade300, size: 32),
                  Icon(Icons.star_border_outlined,
                      color: Colors.grey.shade300, size: 32),
                  Icon(Icons.star_border_outlined,
                      color: Colors.grey.shade300, size: 32),
                  Icon(Icons.star_border_outlined,
                      color: Colors.grey.shade300, size: 32),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
