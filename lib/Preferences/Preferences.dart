import 'dart:convert';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/restaurentmodel.dart';
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
  setCartItems(List<Item> items) async {
    String data="";
    for(Item item in items){
      data=Item.ToPreferenceJson(item)+",";
    }
    if (null != data &&
        data.length > 0 &&
        data.substring(
            data.length - 1, data.length) ==
            ",") {
      data = data.substring(0, data.length - 1);
    }
    SharedPreferences prefs=await SharedPreferences.getInstance();

    prefs.setString('CartItems', data);
  }

  Future<List<Item>> getCartItems() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? jsonSting=prefs.getString('CartItems');
    if(null!=jsonSting && jsonSting.isNotEmpty) {
      var data=json.decode(jsonSting);
      List<Item> ss=data.map((Json) => Item.fromJson(Json)).toList();
      return List<Item>.from(data.map((x) => Item.fromJson(x)));
    } else{
      return [];
    }
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
  setCurrentRestaurant(SingleRestModel singleRestModel) async {
    if(null!=singleRestModel.merchantBranchId && singleRestModel.merchantBranchId!.isNotEmpty) {
      String data = singleRestModelToJson(singleRestModel);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('CurrentRestaurant', data);
    }
  }
  Future<SingleRestModel> getCurrentRestaurant() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? jsonSting=prefs.getString('CurrentRestaurant');
    if(null!=jsonSting && jsonSting.isNotEmpty) {
      return SingleRestModel.fromJson(jsonDecode(jsonSting));
    } else{
      return new SingleRestModel();
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
