import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/CategoryModel.dart';

class DashboardModelService {


  Future<List<CategoryModel>> getDashboardDetails() async {

    var map = new Map<String, dynamic>();
    map['lat'] = '10.9760357';
    map['lng'] = '76.22544309999999';
    var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
    var json = convert.jsonDecode(response.body);
    var catResults = json['main_category'] as List;

    return catResults.map((category) => CategoryModel.fromJson(category)).toList();

  }

}