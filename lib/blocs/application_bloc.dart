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
  List<Item> allItemsList=[];
  List<Item> cartModelList=[];
  List<Item> filteredLoadedProductModelList = [];

  SingleRestModel selectedRestModel= new SingleRestModel();
  List<AddonModel> addonModelList =[];
int? isSelectedIndex;
int? isSelectedCategoryIndex;
String? catName;
String? itemId;

  bool isItemLoading = false;
  ApplicationProvider() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
  setItemLoading(bool isLoading) async {
    this.isItemLoading = isLoading;
    notifyListeners();
  }

  setCurrentRestModel(SingleRestModel restModel) async {
    this.selectedRestModel = restModel;
    notifyListeners();
  }

  clearItems() async{
    filteredLoadedProductModelList.clear();
    notifyListeners();
  }
  setAllItems() async {
    allItemsList = selectedRestModel.items!;
    notifyListeners();
  }

  // filterItems(String categoryId) async {
  //   categoryBasedItemList = selectedRestModel.items!.where((item) =>
  //   item.categoryId == categoryId).toList();
  //   notifyListeners();
  // }

  addProductData(
      List<Item> productList, bool isFilteredList, int position) {
    isSelectedIndex = position;

    if (!isFilteredList) {
      allItemsList = productList;
    }
    filteredLoadedProductModelList = productList;
    notifyListeners();
  }

  setCategoryName(String categoryName){
    catName = categoryName;
    notifyListeners();
  }
  currentSelectedCategory(int selectedIndex){
  isSelectedIndex = selectedIndex;
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

  updateProduct(Item product, bool isIncrement,int enteredQty) {
    int index = filteredLoadedProductModelList.indexOf(product);

    if (isIncrement) {
      filteredLoadedProductModelList[index].enteredQty =
          null!=filteredLoadedProductModelList[index].enteredQty?
          filteredLoadedProductModelList[index].enteredQty! + enteredQty:enteredQty;
      if (null != cartModelList && cartModelList.length > 0) {
        if (!cartModelList.contains(product)) {
          filteredLoadedProductModelList[index].enteredQty=enteredQty;
          cartModelList.add(filteredLoadedProductModelList[index]);
        } else {
          int cartIndex = cartModelList.indexOf(product);
          cartModelList[cartIndex].enteredQty =
          null!=filteredLoadedProductModelList[index].enteredQty?
          filteredLoadedProductModelList[index].enteredQty! + enteredQty:enteredQty;
        }
      } else {
        filteredLoadedProductModelList[index].enteredQty=enteredQty;
        cartModelList.add(filteredLoadedProductModelList[index]);
      }

    } else {
      int cartIndex = cartModelList.indexOf(product);

      if (product.enteredQty! > 1) {
        filteredLoadedProductModelList[index].enteredQty =
            filteredLoadedProductModelList[index].enteredQty! - 1;
        cartModelList[cartIndex].enteredQty =
            filteredLoadedProductModelList[index].enteredQty;
      } else {
        cartModelList.remove(product);

        filteredLoadedProductModelList[index].enteredQty = 0;
      }
    }
    int allItemIndex=selectedRestModel.items!.indexWhere((element) =>
    element.itemId==product.itemId);
    if(allItemIndex>-1){
      // double oldQty=null!=selectedRestModel.items![allItemIndex].enteredQty!?
      // selectedRestModel.items![allItemIndex].enteredQty!:0;
      // oldQty=oldQty+enteredQty;
      selectedRestModel.items![allItemIndex].enteredQty!=filteredLoadedProductModelList[index].enteredQty;

    }
    notifyListeners();
  }
  
  
@override
  void dispose() {
    super.dispose();
  }
}