import 'package:foodzer_customer_app/Models/geometry.dart';

class Place{
  Geometry? geometry;
  String? name;
  String? vicinity;

  Place({this.geometry, this.name, this.vicinity});
  factory Place.fromJson(Map<String, dynamic> parsedJson) {
    return Place(
      geometry: Geometry.fromJson(parsedJson['geometry']),
      name: parsedJson['formatted_address'],
      vicinity: parsedJson['vicinity']
    );
  }

}