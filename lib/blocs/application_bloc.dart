import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/itemAddonModel.dart';
import 'package:foodzer_customer_app/Models/place_search.dart';
import 'package:foodzer_customer_app/Models/restaurentmodel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/geolocator_service.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../Models/cuisinesmodel.dart';
import '../Models/popularrestaurentNearmodel.dart';

class ApplicationProvider with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  String? currentAddress;
  List<Item> cartModelList = [];
  List<TodaysTime>todaytime =[];

  List<Item> filteredLoadedProductModelList = [];
  // List<Item> filteredItemList = [];
  List<Item> searchItemList = [];
  SingleRestModel selectedRestModel = new SingleRestModel();
  AddressModel selectedAddressModel = new AddressModel();
  List<AddonModel> addonModelList = [];
  int? selectedCategoryId;
  String? catName;
  List<Category> categoryList = [];
  double? totalWithoutTax;
  double? itemTotal;
  double deliveryFee = 0;
  String orderTime = "";
  bool isItemLoading = false;
  String? currentOrderId = "";
  double totalAmt = 0;
  double toPayAmt = 0;
  int deliveryBoyTip = 0;
  int deliveryType = 0;
  var taxData = {};
  double setTexPercentage = 0;

  bool isFastDelivery=false;
  bool isFreeDelivery=false;
  bool isLowAvgPrice=false;
  bool isTopRated=false;
  bool isNoMinOrder=false;
  List<String> selectedCuisinesIds=[];

  List<RestaurentModel> restaurantList=[];
  List<RestaurentModel> filteredRestaurantList=[];
  List<CuisinesModel> cuisinesModelList=[];
  List<PopularrestNearModel>poplarResList=[];




  setCuisineChecked(int index,bool isChecked){
    cuisinesModelList[index].isChecked=isChecked;
    notifyListeners();
  }
  filterRestaurants(List<String> cuisinesIds,String searchText){
    if(cuisinesIds.length>0) {
      this.selectedCuisinesIds = cuisinesIds;
      filteredRestaurantList = [];

      for (RestaurentModel ss in restaurantList) {
        List<String> cuisionlist = null != ss.merchantBranchCuisine ?
        ss.merchantBranchCuisine!.split(",") : [];

        if (cuisionlist.length > 0) {
          for (String tuple in cuisionlist) {
            if (selectedCuisinesIds.contains(tuple)) {
              filteredRestaurantList.add(ss);
            }
          }
        }
      }
      filteredRestaurantList=filteredRestaurantList.where((element) =>
      element.merchantBranchName!.toLowerCase()
          .contains(searchText.toLowerCase())).toList();
    }else{
      for (CuisinesModel tuple in cuisinesModelList) {
        tuple.isChecked=false;
      }
      if(searchText.isNotEmpty){
        filteredRestaurantList=restaurantList.where((element) =>
            element.merchantBranchName!.toLowerCase()
                .contains(searchText.toLowerCase())).toList();
      }else {

        filteredRestaurantList = restaurantList;
      }
    }


    notifyListeners();
  }
  setAllRestaurant(List<RestaurentModel> list){
    restaurantList=list;
    filteredRestaurantList=list;
  }
  setAllCuisines(List<CuisinesModel> list){
    cuisinesModelList=list;
  }

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
  reloadCart(List<Item> items) async {
    this.cartModelList = items;
    notifyListeners();
  }

  setOrderId(String orderId) async {
    this.currentOrderId = orderId;
  }

  clearSearch() async {
    this.searchItemList = [];
    notifyListeners();
  }

  setSearchItemList(String val) async {
    searchItemList = selectedRestModel.items!
        .where((element) =>
            element.itemName!.toLowerCase().contains(val.toLowerCase()))
        .toList();
    notifyListeners();
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

  setItemTotal(double itemTotal) async {
    this.itemTotal = itemTotal;
    // if (null != selectedAddressModel.addressId &&
    //     selectedAddressModel.addressId!.isNotEmpty) {
      getDeliveryCharge(itemTotal);
    // }

    // notifyListeners();
  }

  clearDeliveryFee() {
    this.deliveryFee = 0;
    calculateTotal();
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
    this.filteredLoadedProductModelList = [];
    // this.categoryList = [];
    this.selectedCategoryId = 0;

    notifyListeners();
  }

  clearItems() async {
    filteredLoadedProductModelList.clear();
    notifyListeners();
  }

  addProductData(List<Item> productList, bool isFilteredList) {
    // selectedCategoryId = categoryId;

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

  currentSelectedCategory(int categoryId) {
    print(categoryId.toString() + "zzzzzzzzzzzzzzzzzzzzzzzzzz");
    selectedCategoryId = categoryId;
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

  updateProduct(Item product, bool isIncrement, bool isRepeatLastItem
      ) {

    if (selectedRestModel.branchDetails!.openStatus != "Open") {
      Fluttertoast.showToast(
          msg: selectedRestModel.branchDetails!.openStatus!,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.red);
    }else {
      if (isRepeatLastItem) {
        product.addonsList = cartModelList
            .where((element) =>
        element.lastItemTempId
            == product.tempId).single.addonsList!;
        //if repeate last item qty is managed from provider
        product.enteredQty = cartModelList
            .where((element) =>
        element.lastItemTempId
            == product.tempId).single.enteredQty! + 1;
      }
      int filteredItemIndex = filteredLoadedProductModelList
          .indexWhere((element) => element.itemId == product.itemId);
      int cartIndex = null != product.tempId && product.tempId!.isNotEmpty
          ? cartModelList
          .indexWhere((element) => element.tempId == product.tempId)
          : -1;
      if (filteredItemIndex != -1) {
        if (isIncrement) {
          // filteredLoadedProductModelList[cartIndex].enteredQty = enteredQty;
          if (null != cartModelList && cartModelList.length > 0) {
            if (cartIndex == -1) {
              product.tempId = getTempId();
              product.lastItemTempId = product.tempId;

            product = calculateValue(product);

            cartModelList.add(product);
          } else {
            cartModelList[cartIndex] = calculateValue(product);
          }
        } else {
          product.tempId = getTempId();
          product.lastItemTempId=product.tempId;

          product = calculateValue(product);
          cartModelList.add(product);
        }
      } else {
        if (null != product.enteredQty && product.enteredQty! > 0) {
          // filteredLoadedProductModelList[filteredItemIndex] =
          //     calculateValue(product, enteredQty);

          cartModelList[cartIndex] = calculateValue(product);
        } else {
          filteredLoadedProductModelList[filteredItemIndex].addonsList = [];
          cartModelList.removeAt(cartIndex);

          // filteredLoadedProductModelList[filteredItemIndex] =
          //     calculateValue(product, enteredQty);
        }
      }
    } else {
      if (isIncrement) {
        if (null != cartModelList && cartModelList.length > 0) {
          if (cartIndex == -1) {
            product.tempId = getTempId();
            product.lastItemTempId=product.tempId;

            product = calculateValue(product);
            cartModelList.add(product);
          } else {
            cartModelList[cartIndex] = calculateValue(product);
          }
        } else {
          product.tempId = getTempId();
          product.lastItemTempId=product.tempId;

          product = calculateValue(product);
          cartModelList.add(product);
        }
      } else {
        if (null != product.enteredQty && product.enteredQty! > 1) {
          cartModelList[cartIndex] = calculateValue(product);
        } else {
          cartModelList.removeAt(cartIndex);
        }
      }
    }
    int allItemIndex = selectedRestModel.items!
        .indexWhere((element) => element.itemId == product.itemId);
    List<Item> items = cartModelList
        .where((element) => element.itemId == product.itemId)
        .toList();
    int qty=0;
    if(null!=items && items.length>0){
      for(Item item in items){
        qty=qty+item.enteredQty!;
      }
    }
    Item item = new Item();
    String kson = Item.toDataJson(product);
    var jsonData = json.decode(kson);
    item = Item.fromJson(jsonData);
    item.lastItemTempId=product.tempId;
    item.enteredQty=qty;

      if (allItemIndex > -1) {
        filteredLoadedProductModelList[filteredItemIndex] =
            calculateValue(item);
        selectedRestModel.items![allItemIndex] =
            calculateValue(item);
      }
      calculateTotal();
    }
    notifyListeners();
  }

  static String getTempId() {
    String date = "";

    DateTime lastUpdateTime = DateTime.now();

    date = (lastUpdateTime.day.toString().length == 1
            ? "0" + lastUpdateTime.day.toString()
            : lastUpdateTime.day.toString()) +
        (lastUpdateTime.hour.toString().length == 1
            ? "0" + lastUpdateTime.hour.toString()
            : lastUpdateTime.hour.toString()) +
        (lastUpdateTime.minute.toString().length == 1
            ? "0" + lastUpdateTime.minute.toString()
            : lastUpdateTime.minute.toString()) +
        (lastUpdateTime.second.toString().length == 1
            ? "0" + lastUpdateTime.second.toString()
            : lastUpdateTime.second.toString()) +
        (lastUpdateTime.millisecond.toString().length == 0
            ? "000"
            : lastUpdateTime.millisecond.toString().length == 1
                ? "00" + lastUpdateTime.millisecond.toString()
                : lastUpdateTime.millisecond.toString().length == 2
                    ? "0" + lastUpdateTime.millisecond.toString()
                    : lastUpdateTime.millisecond.toString());

    return date;
  }

  Item calculateValue(Item product) {
    double totalAmt = 0;
    double itemPrice=0;
    if(null!=product.priceOnId && product.priceOnId!.isNotEmpty){
      itemPrice=product.priceOnItemPrice!;
    }else{
      itemPrice=product.itemPrice!;
    }
    // product.enteredQty = enteredQty;
    totalAmt = (product.enteredQty! * itemPrice).toDouble();

    if (null != product.addonsList && product.addonsList!.length > 0) {
      for (Addons addon in product.addonsList!) {
        totalAmt = totalAmt + (addon.addonsSubTitlePrice! * product.enteredQty!);
      }
    }
    product.totalPrice = totalAmt;

    return product;
  }

  getDeliveryCharge(double total) async {
    if(null!=selectedAddressModel.addressLat) {
      var map = new Map<String, dynamic>();
      map['merchant_branch_id'] = selectedRestModel.merchantBranchId.toString();
      map['lat'] = selectedAddressModel.addressLat;
      map['lng'] = selectedAddressModel.addressLng;
      map['order_amt'] = total.toString();
      var response =
      await http.post(Uri.parse(ApiData.GET_DELIVERY_CHARGE), body: map);
      var jsonData = json.decode(response.body);

      deliveryFee = null != jsonData['delivery_fee']
          ? double.parse(jsonData['delivery_fee'].toString())
          : 0;
      orderTime = jsonData['order_time'];

    }

    if(deliveryType==2){
      deliveryFee=0;
      deliveryBoyTip =0;
    }
    print(deliveryFee.toString() + "del");
    totalAmt = 0;
    for (Item item in cartModelList) {
      totalAmt = totalAmt + item.totalPrice!;
    }

    taxData = calculateTax(setTexPercentage, totalAmt, false);
    toPayAmt = taxData['totalAmtWithTax'] + deliveryBoyTip + deliveryFee;
    totalWithoutTax = totalAmt;
    notifyListeners();
  }
  setDeliveryType(int deliveryType) {
      this.deliveryType = deliveryType;
      calculateTotal();
      notifyListeners();
  }
  setTipValue(int tip) {
      this.deliveryBoyTip = tip;
      calculateTotal();
    notifyListeners();
  }

  setTaxPercentage(double tax) {
    this.setTexPercentage = tax;
    calculateTotal();
    notifyListeners();
  }

  calculateTotal() async {
    totalAmt = 0;
    for (Item item in cartModelList) {
      totalAmt = totalAmt + item.totalPrice!;
    }
    this.setItemTotal(totalAmt);
    taxData = calculateTax(setTexPercentage, totalAmt, false);
    toPayAmt = taxData['totalAmtWithTax'] + deliveryBoyTip + deliveryFee;
    totalWithoutTax = totalAmt;
    notifyListeners();

  }
}
