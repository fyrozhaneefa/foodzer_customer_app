import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/ReviewSection/review_section.dart';
import 'dividersection.dart';
import 'imagesection.dart';
import 'midlisttile_section.dart';


class Reviews extends StatelessWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            ListTile(
              leading: ImagesSection(),
              title: Text(
                "Very good",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "RobotoMono"),
              ),
              subtitle: Text("Based on 145 rating"),
            ),
            MidListTile(text: "Delivery time"),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Divider(height: 1,thickness: 1,),
            ),
            MidListTile(text: "Quality of food"),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Divider(thickness: 1,
                height: 1,
              ),
            ),
            MidListTile(text: "Value for money"),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Divider(height: 1,thickness: 1),
            ),
            MidListTile(text: "Order packaging"),
            SizedBox(
              height: 10,
              child: Container(color: Colors.grey[100]),
            ),
            ListTile(
              title: Text(
                "Reviews",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "RobotoMono"),
              ),
            ),
            Row(
              children: [
                ReviewSection(),
                Expanded(
                  child: ListTile(
                    title: Text("Amazing",style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),),
                    subtitle: Text("Great"),
                  ),
                ),
              ],
            ),
            DividerSection(),
            Row(
              children: [
                ReviewSection(),
                Expanded(
                    child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text("Very good",style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),),
                  ),
                  subtitle: Text(
                      "is the good food hjvjb sgaskxa gddvwhsd nasv whsazxhiuyfty uga"),
                ),
                ),
              ],
            ),
            DividerSection(),
            Row(
              children: [
                ReviewSection(),
                Expanded(
                    child: ListTile(
                  title: Text("Good",style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),),
                  subtitle: Text("Great"),
                ))
              ],
            ),
            DividerSection(),
            Row(
              children: [
                ReviewSection(),
                Expanded(
                    child: ListTile(
                      title: Text("Good",style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),),
                      subtitle: Text("Great"),
                    )),
                DividerSection(),
              ],
            ),DividerSection(),
            Row(
              children: [
                ReviewSection(),
                Expanded(
                    child: ListTile(
                      title: Text("Good",style: TextStyle(fontFamily: "RobotoMono",fontSize: 15,fontWeight: FontWeight.w400),),
                      subtitle: Text("Great"),
                    ))
              ],
            ),
          ],
        )),
      ),
    );
  }
}
