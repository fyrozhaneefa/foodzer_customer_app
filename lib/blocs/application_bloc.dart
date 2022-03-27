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

class ApplicationProvider with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
// final dashboardService = DashboardModelService();
  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;
  // List<CategoryModel>? dashboardResults;
  List<Item> categoryBasedItemList = [];
  List<Item> allItemsList = [];
  List<Item> cartModelList = [];
  List<Item> filteredLoadedProductModelList = [];

  SingleRestModel selectedRestModel = new SingleRestModel();
  List<AddonModel> addonModelList = [];
  int? selectedCategoryIndex;
  String? catName;
// String? itemId;
  List<Category> categoryList=[];
  double? totalCartPrice;
  bool isItemLoading = false;
  ApplicationProvider() {
    setCurrentLocation();
  }
  setTotalCartPrice(double price) async {
    totalCartPrice = price;
    notifyListeners();
  }
  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
  setCategoryList(List<Category> list) async {
    this.categoryList = list;
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

  clearItems() async {
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

  addProductData(List<Item> productList, bool isFilteredList, int position) {
    selectedCategoryIndex = position;

    if (!isFilteredList) {
      allItemsList = productList;
    }
    filteredLoadedProductModelList = productList;
    notifyListeners();
  }

  setCategoryName(String categoryName) {
    catName = categoryName;
    notifyListeners();
  }

  currentSelectedCategory(int selectedIndex) {
    selectedCategoryIndex = selectedIndex;
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

  // getItemId(String addonItemId){
  //   itemId = addonItemId;
  //   notifyListeners();
  // }
  setItemAddons(List<AddonModel> itemAddonModel) {
    addonModelList = itemAddonModel;
    notifyListeners();
  }

  updateProduct(Item product, bool isIncrement, int enteredQty) {
    int index = filteredLoadedProductModelList
        .indexWhere((element) => element.itemId == product.itemId);

    if (index > 0) {
      if (isIncrement) {
        // filteredLoadedProductModelList[index].enteredQty = enteredQty;
        if (null != cartModelList && cartModelList.length > 0) {
          if (!cartModelList.contains(product)) {
            filteredLoadedProductModelList[index]= calculateValue(product, enteredQty);
            cartModelList.add(filteredLoadedProductModelList[index]);
          } else {
            int cartIndex = cartModelList.indexOf(product);
            cartModelList[cartIndex] =  calculateValue(product, enteredQty);
          }
        } else {
          filteredLoadedProductModelList[index] = calculateValue(product, enteredQty);
          cartModelList.add(filteredLoadedProductModelList[index]);
        }
      } else {
        int cartIndex = cartModelList.indexOf(product);

        if (null != product.enteredQty && product.enteredQty! > 1) {
          filteredLoadedProductModelList[index] = calculateValue(product, enteredQty);

          cartModelList[cartIndex]=calculateValue(product, enteredQty);
        } else {
          cartModelList.remove(product);

          filteredLoadedProductModelList[index]=calculateValue(product, enteredQty);
        }
      }
    } else {
      if (isIncrement) {
        if (null != cartModelList && cartModelList.length > 0) {
          if (!cartModelList.contains(product)) {
            product=calculateValue(product, enteredQty);
            cartModelList.add(product);
          } else {
            int cartIndex = cartModelList.indexOf(product);
            cartModelList[cartIndex] = calculateValue(product, enteredQty);
          }
        } else {
          product=calculateValue(product, enteredQty);
          cartModelList.add(product);
        }
      } else {
        int cartIndex = cartModelList.indexOf(product);

        if (null != product.enteredQty && product.enteredQty! > 1) {
          cartModelList[cartIndex] = calculateValue(product, enteredQty);
        } else {
          cartModelList.remove(product);
        }
      }
    }
    int allItemIndex = selectedRestModel.items!
        .indexWhere((element) => element.itemId == product.itemId);
    if (allItemIndex > -1) {

      selectedRestModel.items![allItemIndex] =calculateValue(product, enteredQty);
    }
    notifyListeners();
  }

  Item calculateValue(Item product,int enteredQty) {
    double totalAmt=0;
    product.enteredQty=enteredQty;
    totalAmt = (enteredQty * product.itemPrice!).toDouble();

    if(null!=product.addonsList && product.addonsList!.length>0){
      for(Addons addon in product.addonsList!){
        totalAmt=totalAmt+addon.addonsSubTitlePrice!;
      }
    }
    product.totalPrice=totalAmt;

    return product;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
