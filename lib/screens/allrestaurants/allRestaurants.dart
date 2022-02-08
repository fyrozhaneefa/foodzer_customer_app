import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/popularRestNear.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurantServiceList.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurants.dart';




class AllRestaurantsScreen extends StatefulWidget {
  static const routeName = "/allRestaurants";
  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  _AllRestaurantsScreenState createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back,
          color: Colors.black,
          size: 30,),
        ),
        centerTitle: true,
        title:Column(
          children: [
            Text(
              'Delivering to',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Al Hilal West',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined,
                color: Colors.deepOrange,)
              ],
            )
          ],
        ),
        bottom: PreferredSize(
          child:Column(
            children: [
              Divider(thickness: 1,),
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15,bottom: 10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.filter_list,
                            size: 25,),
                            SizedBox(width: 10,),
                            Text(
                              'Filters',
                              style: TextStyle(
                                fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.fastfood_outlined,
                              ),
                            SizedBox(width: 10,),
                            Text(
                              'Cuisines',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.search_outlined),
                            SizedBox(width: 10,),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size(0.0, 50.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RestaurantServicesList(),
            PopularRestNearSection(),
            Restaurants()
          ],
        ),
      ),

    );
  }
}

