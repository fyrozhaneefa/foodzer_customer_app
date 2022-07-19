import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Models/sortandfilttermodel.dart';
import 'constants/divider.dart';
import 'package:http/http.dart' as http;

class FiltterItems extends StatefulWidget {
  const FiltterItems({Key? key}) : super(key: key);

  @override
  State<FiltterItems> createState() => _FiltterItemsState();
}

class _FiltterItemsState extends State<FiltterItems> {
  List<String> Deals = [
     "Super Saver",
    "Healthy Deals",
    "Vegan Option",
    "Free Delivery",
    "Dessert Deals",
    "Double Deal",
    "Most Loved",
    "Groceries",
    "Coffe Joy",
    "Newly Added",
    "All Deals"
  ];

  bool? check1 = false;
  bool? check2 = false;
  bool? check3 = false;
  bool? check4 = false;
  bool? check5 = false;
  bool? check6 = false;
  bool? check7 = false;
  bool? check8 = false;
  bool? check9 = false;
  bool? check10 = false;
  bool? check11 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            "Deals and offers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),

        ListView.builder(physics: ScrollPhysics(),shrinkWrap: true,itemCount: Deals.length,itemBuilder: (context,index){



          return ListTile(
              title: Text(Deals.elementAt(index),
                  style: TextStyle(
                    fontSize: 14,
                  )),
              // trailing: CheckBoxSection()
          );

        }),
        // ListTile(
        //     title: Text("Super Saver",
        //         style: TextStyle(
        //           fontSize: 14,
        //         )),
        //     trailing: CheckBoxSection()),
        // Dividersection(),
        // ListTile(
        //   title: Text("Healthy Deals",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Vegan Options",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Free Delivery",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Dessert Deals",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Double Deal",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //     title: Text("Most Loved",
        //         style: TextStyle(
        //           fontSize: 14,
        //         )),
        //     trailing: CheckBoxSection()),
        // Dividersection(),
        // ListTile(
        //   title: Text("Groceries",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Coffe joy",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Newly Added", style: TextStyle(fontSize: 14)),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("All Deals",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
      ],
    );
  }
}

class GetFilter {
  Future<SortAndFiltterModel> getFilter() async {
    var response = await http.post(
        Uri.parse("https://www.foodzer.com/Mob_food_new/filter"),
        headers: {
          'Cookie': 'ci_session=9ac58a3de1c4ad2d2c0d86cec5e3f9b86e7db259'
        },
        body: {
          'lat': '10.9760357',
          'lng': '76.22544309999999'
        });

    final jsonData = jsonDecode(response.body);
    var data = SortAndFiltterModel.fromJson(jsonData);
    return data;
  }
}
