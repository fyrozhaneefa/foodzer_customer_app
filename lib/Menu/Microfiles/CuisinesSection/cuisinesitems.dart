import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/divider.dart';
import 'package:http/http.dart' as http;

import '../../../Api/ApiData.dart';
import '../../../Models/cuisinesmodel.dart';
import 'checkbox.dart';

class CuisinesItems extends StatefulWidget {
  const CuisinesItems({Key? key}) : super(key: key);

  @override
  _CuisinesItemsState createState() => _CuisinesItemsState();
}

class _CuisinesItemsState extends State<CuisinesItems> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ListCuisines().getCuisines(),
        builder: (context, AsyncSnapshot<List<CuisineList>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
          else if (snapshot.hasData) {
            return ListView.separated(
                itemCount: (snapshot.data!.length),
                itemBuilder: (BuildContext context, int index){
                  CuisineList user = snapshot.data!.elementAt(index);
                 return ListTile(
                    title: Text(user.cuisineName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    trailing: CheckBoxSection(),
                  );
                },
                separatorBuilder: (context, index) => Divider());
          }
          else {
            return Center(
              child: Text(" Some errror Occured!! "),
            );
          }
        });
  }
}
class ListCuisines {
  Future<List<CuisineList>?> getCuisines() async {
    final response = await http.post(
        Uri.parse(ApiData.All_Restaurent),
        body: {
          'lat': '10.9760357',
          'lng': '76.22544309999999',
          'delivery_type': 'delivery',
        },
        headers: {
          'Cookie': ' ci_session=445a8129f0edc2b81b72086233c20f2744cc4e92'
        });

    final jsonData = jsonDecode(response.body);
    var data = CuisinesModel.fromJson(jsonData).cuisineList;
    return data;
  }
}
