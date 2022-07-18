import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Models/offermodel.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart ' as http;

import '../FavoriteSection/itemCard.dart';

class OfferSection extends StatelessWidget {
  const OfferSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(Icons.keyboard_backspace_outlined, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: RichText(
            text: TextSpan(
              text: "Featured Offers",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              // children: [
              //   WidgetSpan(
              //       child: Icon(Icons.keyboard_arrow_down_rounded,
              //           color: Colors.black))
              // ]
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ApplyButton(buttonname: "VIEW ALL", radius: 7)),
        ),
        body: FutureBuilder(future: getOffers(),builder: (context, AsyncSnapshot<List<CouponList>?> snapshot){

          if(snapshot.connectionState==ConnectionState.waiting)

            return Center(child: CircularProgressIndicator());

          else if(snapshot.hasData){


            return ListView(children: [
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  CouponList offer =snapshot.data!.elementAt(index);
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30, left: 20, bottom: 30, right: 10),
                            child: Container(
                              height: 120,
                              width: Helper.getScreenWidth(context) * .28,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://i.pinimg.com/originals/b6/c2/5b/b6c25bbeccd4dabcaf79c2b301747d3f.jpg"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            left: 30,
                            right: 20,
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    color: Colors.white,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.shade200, width: 1),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "50% OFF",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ". UPTO ₹80 .",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Text(
                                  "KFC",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Icon(
                                    Icons.star_outlined,
                                    size: 16,
                                    color: Colors.grey.shade600,
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 5),
                                child: Text(
                                  "3.8",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 5),
                                child: Text(
                                  ". 35 mins .",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 5),
                                child: Text(
                                  "₹400 for two",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 5),
                            child: Text(
                              "American,Snacks,Biriyani",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 5),
                            child: Text(
                              "Rp Mall Calicut",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              // ItemCard(
              //   itemImage:
              //       "https://i.pinimg.com/originals/b6/c2/5b/b6c25bbeccd4dabcaf79c2b301747d3f.jpg",
              //   itemName: "KFC",
              // ),
              // ItemCard(
              //   itemImage:
              //       "https://assets.cntraveller.in/photos/60ba26c0bfe773a828a47146/master/pass/Burgers-Mumbai-Delivery.jpg",
              //   itemName: "Burger Lounge-Beach Road",
              // ),
              // ItemCard(
              //   itemImage:
              //       "https://st.depositphotos.com/1003814/5052/i/950/depositphotos_50523105-stock-photo-pizza-with-tomatoes.jpg",
              //   itemName: "Cafe Pizza Corner",
              // ),
              // ItemCard(
              //   itemImage:
              //       "https://www.vegrecipesofindia.com/wp-content/uploads/2018/09/vegetable-noodles.jpg",
              //   itemName: "Chicken Noodles",
              // ),
              // ItemCard(
              //   itemImage:
              //       "https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg",
              //   itemName: "Fried Rice",
              // ),
              // ItemCard(
              //   itemImage:
              //       "https://static.toiimg.com/thumb/53991492.cms?imgsize=97707&width=800&height=800",
              //   itemName: "Cutlet",
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: ApplyButton(buttonname: "VIEW ALL", radius: 7),
            ]);


          }
          else{

           return Center(child: Text("oops.."));
          }



        })



      );
  }

  Future<List<CouponList>?>getOffers() async {
    final response = await http.post(
        Uri.parse(
            "https://opine.cloud/foodzer_test/Mob_food_new/admin_offers_and_deals"),
        headers: {"Cookie":" ci_session=258bf7450daeb85638ba070dc925917df1070f15"});
    
    final jsonData =jsonDecode(response.body);
    var data =OfferModel.fromJson(jsonData).couponList;
    return data;
    
  }
}
