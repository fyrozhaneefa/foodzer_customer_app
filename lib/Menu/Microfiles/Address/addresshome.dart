import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/Address/savedaddress.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class Address extends StatelessWidget {
  const Address({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: .5,
        backgroundColor: Colors.white,
        leading:InkWell(child: Icon(Icons.keyboard_backspace_outlined, color: Colors.black),onTap: (){

          Navigator.pop(context);
        }),
        title: Text(
          "ADDRESSES",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("SAVED ADDRESSES",   style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12,fontWeight: FontWeight.w500),),
            ),
            Container(
                color: Colors.white,
                width: Helper.getScreenWidth(context) * 1,
                height: Helper.getScreenHeight(context),
                child: Column(
                  children: [
                    SavedAddress(),


                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 20, bottom: 10, right: 20),
                      child: Container(
                        width: Helper.getScreenWidth(context),
                        child: OutlinedButton(
                          onPressed: () {

                          },
                          child: Text(
                            "ADD NEW ADDRESS",
                            style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.green,width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
