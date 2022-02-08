import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPaswwordScreen extends StatefulWidget {
  static const routeName = "/forgotPassword";

  @override
  _ForgotPaswwordScreenState createState() => _ForgotPaswwordScreenState();
}

class _ForgotPaswwordScreenState extends State<ForgotPaswwordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              size: 26,
              color: Colors.black,)
            , onPressed: () {
            Navigator.pop(context);
          },),
          title: Text(
            "Forgotten password",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:25.0, right:20.0,left:20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      child:  Text("Reset your password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary:Colors.deepOrange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          // side: BorderSide(color: Colors.grey)
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
