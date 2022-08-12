import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/ReviewSection/review_section.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import 'dividersection.dart';
import 'emoji.dart';
import 'imagesection.dart';


class ReviewRestaurent extends StatefulWidget {
  const ReviewRestaurent({Key? key}) : super(key: key);

  @override
  State<ReviewRestaurent> createState() => _ReviewRestaurentState();
}

class _ReviewRestaurentState extends State<ReviewRestaurent> {
  @override


  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, _)
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
                    "${provider.selectedRestModel.reviews!.branchAvgRating!.toStringAsFixed(2)} Very good",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                       ),
                  ),
                  subtitle: Text("Based on ${provider.selectedRestModel.reviews!.numOfRows} rating"),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery time",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                      Emoji(provider.selectedRestModel.reviews!.deliveryRating)
                    ],
                  ),
                ),
                // MidListTile(text: "Delivery time"),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Divider(height: 1, thickness: 1,),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quality of food",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right:3),
                                child: Icon(Icons.emoji_emotions_outlined,size: 20,),
                              ),
                            ),
                            TextSpan(text: provider.selectedRestModel.reviews!.avgQuality!.toStringAsFixed(2),style: TextStyle(color: Colors.grey,fontSize: 15)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Divider(thickness: 1,
                    height: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Value for money",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right:3),
                                child: Icon(Icons.emoji_emotions_outlined,size: 20,),
                              ),
                            ),
                            TextSpan(text: provider.selectedRestModel.reviews!.moneyRating!.toStringAsFixed(2),style: TextStyle(color: Colors.grey,fontSize: 15)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Divider(height: 1, thickness: 1),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order packaging",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right:3),
                                child: Icon(Icons.emoji_emotions_outlined,size: 20,),
                              ),
                            ),
                            TextSpan(text: provider.selectedRestModel.reviews!.packageRating!.toStringAsFixed(2),style: TextStyle(color: Colors.grey,fontSize: 15)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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


                ReviewSection(),
                Padding(padding: EdgeInsets.only(left: 72),
                  child: Align(child: Text("Hamden,14 February 2022",
                      style: TextStyle(color: Colors.grey)),
                      alignment: Alignment.bottomLeft),),
                DividerSection(),
                ReviewSection(),
                Padding(padding: EdgeInsets.only(left: 72),
                  child: Align(child: Text("Ahmed,14 February 2022",
                      style: TextStyle(color: Colors.grey)),
                      alignment: Alignment.bottomLeft),),
                DividerSection(),
                ReviewSection(),
                Padding(padding: EdgeInsets.only(left: 72),
                  child: Align(child: Text("shaima,13 February 2022",
                      style: TextStyle(color: Colors.grey)),
                      alignment: Alignment.bottomLeft),),
                DividerSection(),
                ReviewSection(),
                Padding(padding: EdgeInsets.only(left: 72),
                  child: Align(child: Text("Hamden,14 February 2022",
                      style: TextStyle(color: Colors.grey)),
                      alignment: Alignment.bottomLeft),),
                DividerSection(),

              ],
            ),
          ),
        ),
      );
    });
  }
}
