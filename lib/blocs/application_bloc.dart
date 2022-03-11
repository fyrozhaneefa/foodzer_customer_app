import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/itemAddonModel.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../Models/CategoryModel.dart';
import '../Models/place.dart';
import '../Models/place_search.dart';
import '../Services/dashboardModelService.dart';

class ApplicationProvider with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
final placesService = PlacesService();
// final dashboardService = DashboardModelService();
  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;
  // List<CategoryModel>? dashboardResults;
  List<Item> categoryBasedItemList=[];
  SingleRestModel selectedRestModel= new SingleRestModel();
  List<AddonModel> addonModelList =[];
int? isSelected;
String? catName;
String? itemId;
  ApplicationProvider() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  setCurrentRestModel(SingleRestModel restModel) async {
    this.selectedRestModel = restModel;
    notifyListeners();
  }

  filterItems(String categoryId) async {

    categoryBasedItemList = selectedRestModel.items!.where((item) =>
    item.categoryId == categoryId).toList();
    // categoryBasedItemList = selectedRestModel.items!.map((spacecraft) => new Item.fromJson(spacecraft)).toList();
    // this.selectedRestModel = restModel;
    notifyListeners();
  }
  setCategoryName(String categoryName){
    catName = categoryName;
    notifyListeners();
  }
  currentSelectedCategory(int selectedIndex){
  isSelected = selectedIndex;
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
  getItemId(String addonItemId){
    itemId = addonItemId;
    notifyListeners();
  }
  setItemAddons(List<AddonModel> itemAddonModel) {
    addonModelList = itemAddonModel;
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