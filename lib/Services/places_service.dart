import 'package:foodzer_customer_app/Models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
final key = 'AIzaSyBDs6JcB5tld5sodZDpLm6-sQx2XaCx6OI';

  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&language=pt_BR&key=$key';
   var response= await http.get(Uri.parse(url));
   var json = convert.jsonDecode(response.body);
   var jsonResults = json['predictions'] as List;

return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}