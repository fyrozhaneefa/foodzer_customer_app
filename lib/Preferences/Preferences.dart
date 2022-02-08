import 'dart:convert';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreference{

  setUserData(String userJson) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    prefs.setString('userData', userJson);
  }


  Future<userData> getUserData() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String jsonSting=prefs.getString('userData')!;
    if(null!=jsonSting && jsonSting.isNotEmpty) {
      return userData.fromJson(jsonDecode(jsonSting));
    }else{
      return new userData();
    }
  }


  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userData');

  }
}
