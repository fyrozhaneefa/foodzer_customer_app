import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';

import '../Models/place.dart';
import '../Models/place_search.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
final placesService = PlacesService();

  //Variables

  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;
  StreamController<Place> selectedLocation = StreamController<Place>();


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

  setSelectedLocation(String placeId) async {
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null;
    notifyListeners();
  }

@override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}