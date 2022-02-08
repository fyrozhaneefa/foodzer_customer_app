import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:foodzer_customer_app/widget/navigationDrawer.dart';

class FoodzerPayScreen extends StatefulWidget {
  static const routeName = "/foodzerPay";
  const FoodzerPayScreen({Key? key}) : super(key: key);

  @override
  State<FoodzerPayScreen> createState() => _FoodzerPayScreenState();
}

class _FoodzerPayScreenState extends State<FoodzerPayScreen> {
  bool isSwitched  = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            icon: Icon(Icons.arrow_back,
            color: Colors.black,
            size: 30,),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey.shade600),
          title: Text(
            'Foodzer Pay',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 20
            ),
          ),
        ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Image.network('https://icon-library.com/images/cash-payment-icon/cash-payment-icon-26.jpg',
                  fit: BoxFit.fill,),
              ),
              SizedBox(height: 20,),
              Text(
                'Login to access your foodzer credit',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 50,

                width: Helper.getScreenWidth(context)*0.45,
                child: ElevatedButton(
                  onPressed: (){

                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange.shade600,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),),
                ),
              )
            ],
          ),
        )
    );
  }
}
