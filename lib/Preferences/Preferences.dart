import 'dart:convert';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/restaurentmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  setUserData(String userJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userData', userJson);
  }

  setLatLng(String lat, String lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('latitude', lat);
    prefs.setString('longitude', lng);
  }

  setCurrentAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentAddress', address);
  }

  Future<String?> getCurrentAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedAddress = prefs.getString('currentAddress');
    return selectedAddress;
  }

  setCartItems(List<Item> items) async {
    final String encodedData = Item.encode(items);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('CartItems', encodedData);
  }

  Future<List<Item>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSting = prefs.getString('CartItems');
    if (null != jsonSting && jsonSting.isNotEmpty) {
      List responseModel = json.decode(jsonSting);
      List<Item> list =
          responseModel.map((item) => new Item.fromJson(item)).toList();

      return list;
    } else {
      return [];
    }
  }

  setDeliveryAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deliveryAddress', address);
  }

  Future<AddressModel> getDeliveryAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSting = prefs.getString('deliveryAddress');
    if (null != jsonSting && jsonSting.isNotEmpty) {
      return AddressModel.fromJson(jsonDecode(jsonSting));
    } else {
      return new AddressModel();
    }
  }

  setCurrentRestaurant(SingleRestModel singleRestModel) async {
    if (null != singleRestModel.merchantBranchId &&
        singleRestModel.merchantBranchId!.isNotEmpty) {
      String data = singleRestModelToJson(singleRestModel);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('CurrentRestaurant', data);
    }
  }

  Future<SingleRestModel> getCurrentRestaurant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSting = prefs.getString('CurrentRestaurant');
    if (null != jsonSting && jsonSting.isNotEmpty) {
      return SingleRestModel.fromJson(jsonDecode(jsonSting));
    } else {
      return new SingleRestModel();
    }
  }

  Future<UserData> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSting = prefs.getString('userData');
    if (null != jsonSting && jsonSting.isNotEmpty) {
      return UserData.fromJson(jsonDecode(jsonSting));
    } else {
      return new UserData();
    }
  }
void clearCartPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("CartItems");
}
  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userData');
  }
}
