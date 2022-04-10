import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/itemAddonModel.dart';
import 'package:foodzer_customer_app/Models/place_search.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApplicationProvider with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;
  List<Item> cartModelList = [];
  List<Item> filteredLoadedProductModelList = [];

  SingleRestModel selectedRestModel = new SingleRestModel();
  AddressModel selectedAddressModel = new AddressModel();
  List<AddonModel> addonModelList = [];
  int? selectedCategoryIndex;
  String? catName;
  List<Category> categoryList = [];
  double? totalCartPrice;
  bool isItemLoading = false;
  ApplicationProvider() {
    setCurrentLocation();
  }

  double getTaxAmtInclusive(double price, double taxPercent) {
    double taxWithoutPrice = price - (price * (100 / (100 + taxPercent)));

    return taxWithoutPrice;
  }

  Map<String, dynamic> calculateTax(
      double taxPercentage, double totalAmt, bool isInclusive) {
    double gstTotalP = taxPercentage;

    double sgstP = gstTotalP / 2;
    double cgstP = gstTotalP / 2;

    double cgstF = 0;
    double sgstF = 0;
    double amount = 0;

    if (isInclusive) {
      cgstF = getTaxAmtInclusive(totalAmt, cgstP);
      sgstF = getTaxAmtInclusive(totalAmt, sgstP);
      amount = totalAmt;
    } else {
      cgstF = totalAmt * (cgstP / 100);
      sgstF = totalAmt * (sgstP / 100);
      amount = totalAmt + (cgstF + sgstF);
    }

    Map<String, dynamic> data = {
      "cgst": cgstF,
      "sgst": sgstF,
      "totalTaxAmt": cgstF + sgstF,
      "totalAmtWithTax": amount,
    };

    return data;
  }

  setAddressModel(AddressModel addressModel) async {
    this.selectedAddressModel = addressModel;
  }

  clearData() async {
    for (Item itemModel in cartModelList) {
      int itemModelIndex = -1;
      int categoryIndex = -1;
      itemModelIndex = selectedRestModel.items!
          .indexWhere((element) => element.itemId == itemModel.itemId);
      if (itemModelIndex != -1) {
        selectedRestModel.items![itemModelIndex].enteredQty = 0;
      }
      categoryIndex = filteredLoadedProductModelList
          .indexWhere((element) => element.itemId == itemModel.itemId);
      if (categoryIndex != -1) {
        filteredLoadedProductModelList[categoryIndex].enteredQty = 0;
      }
    }
    this.cartModelList = [];

    notifyListeners();
  }

  setTotalCartPrice(double totalAmt) async {
    totalCartPrice = totalAmt;
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


  addProductData(List<Item> productList, bool isFilteredList, int position) {
    selectedCategoryIndex = position;

    // if (!isFilteredList) {
    //   allItemsList = productList;
    // }
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
            filteredLoadedProductModelList[index] =
                calculateValue(product, enteredQty);
            cartModelList.add(filteredLoadedProductModelList[index]);
          } else {
            int cartIndex = cartModelList.indexOf(product);
            cartModelList[cartIndex] = calculateValue(product, enteredQty);
          }
        } else {
          filteredLoadedProductModelList[index] =
              calculateValue(product, enteredQty);
          cartModelList.add(filteredLoadedProductModelList[index]);
        }
      } else {
        int cartIndex = cartModelList.indexOf(product);

        if (null != product.enteredQty && product.enteredQty! > 1) {
          filteredLoadedProductModelList[index] =
              calculateValue(product, enteredQty);

          cartModelList[cartIndex] = calculateValue(product, enteredQty);
        } else {
          cartModelList.remove(product);

          filteredLoadedProductModelList[index] =
              calculateValue(product, enteredQty);
        }
      }
    } else {
      if (isIncrement) {
        if (null != cartModelList && cartModelList.length > 0) {
          if (!cartModelList.contains(product)) {
            product = calculateValue(product, enteredQty);
            cartModelList.add(product);
          } else {
            int cartIndex = cartModelList.indexOf(product);
            cartModelList[cartIndex] = calculateValue(product, enteredQty);
          }
        } else {
          product = calculateValue(product, enteredQty);
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
      selectedRestModel.items![allItemIndex] =
          calculateValue(product, enteredQty);
    }
    notifyListeners();
  }

  Item calculateValue(Item product, int enteredQty) {
    double totalAmt = 0;
    product.enteredQty = enteredQty;
    totalAmt = (enteredQty * product.itemPrice!).toDouble();

    if (null != product.addonsList && product.addonsList!.length > 0) {
      for (Addons addon in product.addonsList!) {
        totalAmt = totalAmt + addon.addonsSubTitlePrice!;
      }
    }
    product.totalPrice = totalAmt;

    return product;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
