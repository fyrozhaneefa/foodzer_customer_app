import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class loginSection extends StatefulWidget {
  @override
  State<loginSection> createState() => _loginSectionState();
}

class _loginSectionState extends State<loginSection> {


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.deepOrange.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Colors.grey.shade300
          )
      ),
      child: Column(
        children: [
          Container(
            margin:EdgeInsets.only(left:20,top: 15,bottom: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('https://mobirise.com/bootstrap-template/profile-template/assets/images/timothy-paul-smith-256424-1200x800.jpg'
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Text(
                    "Log in or create an account for a faster ordering experience",
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Helper.getScreenWidth(context),
            height: 50,
            child: ElevatedButton(
              onPressed: () {

              },
              child: Container(
                child:  Text("Login",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              style: ElevatedButton.styleFrom(
                  primary:Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)
                    ),
                    // side: BorderSide(color: Colors.grey)
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}