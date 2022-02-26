import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/CategoryModel.dart';

class DashboardModelService {


  // Future<List<CategoryModel>> getDashboardDetails() async {
  //
  //   var map = new Map<String, dynamic>();
  //   map['lat'] = '10.9760357';
  //   map['lng'] = '76.22544309999999';
  //   var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
  //   var json = convert.jsonDecode(response.body);
  //   var catResults = json['main_category'] as List;
  //   return catResults.map((category) => CategoryModel.fromJson(category)).toList();
  //
  // }

  // getSliderList({String token}) async {
  //   List<SliderModel> data = List<SliderModel>();
  //   try {
  //     final response = await http.get(
  //         Utils.baseUrl + "get_all_sliders",
  //         headers: {"Authorization": "$token"}).timeout(TimeoutDuration);
  //     print(response.body);
  //
  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(response.body);
  //       print(result.length);
  //       for (int i = 0; i < result.length; i++) {
  //         final obj = SliderModel.fromJson(result[i]);
  //         data.add(obj);
  //         print(obj);
  //       }
  //       return ApiResponse(haserror: false, data: data, errormessage: '');
  //
  //       //final data = RestaurantModel.fromJson(json:result );
  //
  //     }
  //     return ApiResponse(haserror: true, errormessage: 'error occured');
  //   } on TimeoutException {
  //     return ApiResponse(haserror: true, errormessage: 'Timeout');
  //   } on SocketException {
  //     return ApiResponse(haserror: true, errormessage: 'Network error');
  //   } catch (e) {
  //     return ApiResponse(haserror: true, errormessage: e);
  //   }
  // }
}