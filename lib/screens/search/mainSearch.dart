import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/searchModel.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;

class MainSearchScreen extends StatefulWidget {
  static const routeName = "/mainSearch";

  const MainSearchScreen({Key? key}) : super(key: key);

  @override
  State<MainSearchScreen> createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  TextEditingController? textEditingController = TextEditingController();

  get orientation => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 26,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: 45,
            child: Container(
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for restaurants or ...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Helper.getScreenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Popular searches',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: MainSearch().getMainSearch(),
                    builder: (context, AsyncSnapshot<List<Results>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ));
                      else if (snapshot.hasData) {
                        return Container(
                          height: 150,
                          width: Helper.getScreenHeight(context) * 1,
                          child: GridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 30,
                                    childAspectRatio: 10),
                            itemBuilder: (BuildContext context, int index) {
                              Results data = snapshot.data!.elementAt(index);
                              return InkWell( child:Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8)
                                          .copyWith(top: 0, bottom: 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timeline,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.cuisineName!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),onTap: (){


                              },);
                            },
                          ),
                        );
                      } else {
                        return Text("Some error occured!!");
                      }
                    }),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Text(
                    'Featured restaurants',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                    future: MainSearch().getMainSearch(),
                    builder: (context, AsyncSnapshot<List<Results>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ));
                      else if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Results item = snapshot.data!.elementAt(index);

                            return Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        NetworkImage(item.merchantBranchImage!),
                                    radius: 40,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.merchantBranchName!,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          item.cuisines!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.tag_faces,
                                              color: Colors.orangeAccent,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            item.avgReview == "1"
                                                ? Text("Amazing")
                                                : item.avgReview == "2"
                                                    ? Text("Very Good")
                                                    : item.avgReview == "3"
                                                        ? Text("Good")
                                                        : item.avgReview == "4"
                                                            ? Text("OK")
                                                            : item.avgReview ==
                                                                    "0"
                                                                ? Text(
                                                                    "Not Yet")
                                                                : Container(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: CircleAvatar(
                                                radius: 2,
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.attach_money,
                                              color: Colors.grey.shade400,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              item.merchantBranchOrderTime! +
                                                  ' mins ' +
                                                  "| " +
                                                  item.distance! +
                                                  " km",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              child: CircleAvatar(
                                                radius: 2,
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.delivery_dining,
                                              color: Colors.grey.shade900,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'BD 0.400',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text("Some error occured!!"),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainSearch {
  Future<List<Results>?> getMainSearch() async {
    final response = await http.post(
        Uri.parse(
            "https://opine.cloud/foodzer_test/Mob_food_new/get_search_inner"),
        body: {
          'search': 'foodzer',
          'lat': '10.98065659',
          'lng': '76.19253989',
        },
        headers: {
          'Cookie': 'ci_session=2b2f5ec8d53871bc4fe200eca3777ab613052405'
        });

    final jsonData = jsonDecode(response.body);
    var data = SearchModel.fromJson(jsonData).results;
    return data;
  }
}
