import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Api/ApiData.dart';
import '../../../Models/restaurentmodel.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  bool isSwitchView = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All restaurants',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 5, bottom: 5),
                        child: GestureDetector(
                          onTap: () {
                            isSwitchView = true;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.list,
                            color:
                                isSwitchView ? Colors.deepOrange : Colors.black,
                          ),
                        ),
                      ),
                      VerticalDivider(
                          thickness: 1, color: Colors.grey.shade300),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 5, bottom: 5),
                        child: GestureDetector(
                            onTap: () {
                              isSwitchView = false;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.view_agenda_outlined,
                              color: isSwitchView
                                  ? Colors.black
                                  : Colors.deepOrange,
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          FutureBuilder(
              future: AllRestaurent().getRestaurent(),
              builder: (context, AsyncSnapshot<List<Results>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Results user = snapshot.data!.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            print(index);
                          },
                          child: isSwitchView
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        width: 70,
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            child: Image.network(
                                              (user.merchantBranchImage!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: ProductDesc(
                                          user: user,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        width: Helper.getScreenWidth(context),
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            (user.merchantBranchImage!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      ProductDesc(user: user),
                                    ],
                                  ),
                                ),
                        );
                      });
                } else {
                  return Center(child: Text('some error occured!!'));
                }
              })
        ],
      ),
    );
  }
}

class ProductDesc extends StatelessWidget {
  Results user;

  ProductDesc({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.merchantBranchName!, style: TextStyle(color: Colors.black)),
        SizedBox(
          height: 3,
        ),
        Text(
          user.cuisines!,
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
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(user.avgReview!),
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
              'Within ' + user.merchantBranchOrderTime! + " mins",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: CircleAvatar(
                radius: 2,
                backgroundColor: Colors.grey.shade400,
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
            Text(
              'BD 0.400',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    );
  }
}

class AllRestaurent {
  Future<List<Results>?> getRestaurent() async  {
    final response = await http.post(
        Uri.parse(ApiData.All_Restaurent),
        body: {
          'lat': '10.9760357',
          'lng': '76.22544309999999',
          'delivery_type': 'delivery'
        },
        headers: {
          'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
        });

    final jsonData = jsonDecode(response.body);
    var data = RestaurentModel.fromJson(jsonData).results;
    return data;
  }
}
