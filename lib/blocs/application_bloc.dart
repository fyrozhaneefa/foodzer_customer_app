import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';

import '../Models/place_search.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
final placesService = PlacesService();

  //Variables

  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;


  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
  getCurrentAddress() async {
    currentAddress = await geoLocatorService.getCurrentAddress();
    notifyListeners();
  }
}