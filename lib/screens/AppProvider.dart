import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppProvider extends ChangeNotifier {
bool isLoggedIn = false;

 getUserData(bool isLogin) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    var user= prefs.getString('userData');
    if(null!= user) {
      isLoggedIn = isLogin;
    }
    notifyListeners();
  }



}
