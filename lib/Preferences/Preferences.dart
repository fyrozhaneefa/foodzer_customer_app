import 'dart:convert';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreference{

  setUserData(String userJson) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    prefs.setString('userData', userJson);
  }
  setLatLng(String lat, String lng) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('latitude', lat);
    prefs.setString('longitude', lng);
  }
  setCurrentAddress(String address) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    prefs.setString('currentAddress', address);
  }

  Future<String?> getCurrentAddress() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? selectedAddress=prefs.getString('currentAddress');
    return selectedAddress;
  }
  setDeliveryAddress(String address) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('deliveryAddress', address);
  }
  Future<AddressModel>getDeliveryAddress() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? jsonSting=prefs.getString('deliveryAddress');
    if(null!=jsonSting && jsonSting.isNotEmpty) {
      return AddressModel.fromJson(jsonDecode(jsonSting));
    } else{
      return new AddressModel();
    }
  }

  Future<UserData> getUserData() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? jsonSting=prefs.getString('userData');
    if(null!=jsonSting && jsonSting.isNotEmpty) {
      return UserData.fromJson(jsonDecode(jsonSting));
    }else{
      return new UserData();
    }
  }


  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userData');

  }
}
