import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../Models/CategoryModel.dart';
import '../Models/place.dart';
import '../Models/place_search.dart';
import '../Services/dashboardModelService.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
final placesService = PlacesService();
// final dashboardService = DashboardModelService();
  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;
  // List<CategoryModel>? dashboardResults;

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


  // getDashboardResult() async{
  //  dashboardResults = await dashboardService.getDashboardDetails();
  //  notifyListeners();
  // }

  
  
@override
  void dispose() {
    super.dispose();
  }
}