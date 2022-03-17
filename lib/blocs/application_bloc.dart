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
  List<Item> filteredLoadedProductModelList = [];

  SingleRestModel selectedRestModel= new SingleRestModel();
  List<AddonModel> addonModelList =[];
int? isSelected;
int? isSelectedCategoryIndex;
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
    isSelectedCategoryIndex = position;

    if (!isFilteredList) {
      allItemsList = productList;
    }
    categoryBasedItemList = productList;
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

  // updateProduct(ProductModel product, bool isIncrement) {
  //   int index = categoryBasedProductModelList.indexOf(product);
  //
  //   if (isIncrement) {
  //     categoryBasedProductModelList[index].enteredQty =
  //         categoryBasedProductModelList[index].enteredQty + 1;
  //     if (null != cartModelList && cartModelList.length > 0) {
  //       if (!cartModelList.contains(product)) {
  //         cartModelList.add(categoryBasedProductModelList[index]);
  //       } else {
  //         int cartIndex = cartModelList.indexOf(product);
  //         cartModelList[cartIndex].enteredQty =
  //             categoryBasedProductModelList[index].enteredQty;
  //       }
  //     } else {
  //       cartModelList.add(categoryBasedProductModelList[index]);
  //     }
  //   } else {
  //     int cartIndex = cartModelList.indexOf(product);
  //
  //     if (product.enteredQty > 1) {
  //       categoryBasedProductModelList[index].enteredQty =
  //           categoryBasedProductModelList[index].enteredQty - 1;
  //       cartModelList[cartIndex].enteredQty =
  //           categoryBasedProductModelList[index].enteredQty;
  //     } else {
  //       cartModelList.remove(product);
  //
  //       categoryBasedProductModelList[index].enteredQty = 0;
  //     }
  //   }
  //   notifyListeners();
  // }
  
  
@override
  void dispose() {
    super.dispose();
  }
}