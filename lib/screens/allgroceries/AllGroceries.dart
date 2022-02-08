import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allgroceries/sections/groceryProductDesc.dart';
import 'package:foodzer_customer_app/screens/allgroceries/sections/groceryProductsList.dart';
import 'package:foodzer_customer_app/screens/allgroceries/sections/storeTypeSection.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class AllGroceriesScreen extends StatefulWidget {
  static const routeName = "/AllGroceries";
  const AllGroceriesScreen({Key? key}) : super(key: key);

  @override
  _AllGroceriesScreenState createState() => _AllGroceriesScreenState();
}

class _AllGroceriesScreenState extends State<AllGroceriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivering to',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Al Hilal West',
              style: TextStyle(color: Colors.deepOrange, fontSize: 12),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 70.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
            child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 2.0,
                      ),
                    ]),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.search_outlined, color: Colors.grey.shade500),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search for items or stores',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade500),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoreTypeSection(),
            GroceryProductsList(),
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 20,right: 20.0,bottom: 30),
              width: Helper.getScreenWidth(context),
              child: ElevatedButton(
               onPressed: (){

               },
                child:Text(
                  'View all stores',
                  style:TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                    side:BorderSide(color: Colors.deepOrange),
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



