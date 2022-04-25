import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategory.dart';
import 'package:provider/provider.dart';

import '../../../Models/SingleRestModel.dart';

class AllRestaurentSearch extends StatefulWidget {
  const AllRestaurentSearch({Key? key}) : super(key: key);

  @override
  State<AllRestaurentSearch> createState() => _AllRestaurentSearchState();
}

class _AllRestaurentSearchState extends State<AllRestaurentSearch> {
  bool isSwiched = false;
  List<Category> categoryList = [];

  get orientation => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back_rounded,
                      )),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search for restaurants or dishes"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Restaurants",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          // side: BorderSide(color: Colors.black.withOpacity(.3)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Dishes",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          // side: BorderSide(color: Colors.black.withOpacity(.3)),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Featured restaurants",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:2,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext contex, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12)),
                              width: 85,
                              height: 85,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, bottom: 5),
                                child: Image.network(
                                  'https://d1h79zlghft2zs.cloudfront.net/uploads/2019/07/2285-768x1004.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dar Al Atta',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Charity',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.tag_faces,
                                    size: 20,
                                    color: Colors.orangeAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Amazing',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    'Within 30 mins',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.delivery_dining, size: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Free delivery',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
