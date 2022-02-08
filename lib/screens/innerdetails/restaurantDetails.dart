import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/basket/itemBasket.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantInfo.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategoryItem.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/restaurantProductsList.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;

class RestaurantDetailsScreen extends StatefulWidget {
  static const routeName = "/restaurantDetails";
  const RestaurantDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              backgroundColor: Colors.white,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              title: Text(
                'Al Qais Shopping',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Image.network(
                  'https://cdn-prod.medicalnewstoday.com/content/images/articles/314/314819/delicious-buffet-foods.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right:20.0,bottom:60,top:20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Al Qais Shopping',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RestaurantInfoScreen.routeName);
                            },
                            child: Text(
                              'Info',
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Grocery, Convenience Store'),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.tag_faces,
                            color: Colors.grey.shade700,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          RichText(
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: 'Very Good ',
                                  style: new TextStyle(
                                      color: Colors.black,),
                                ),
                                new TextSpan(
                                  text: 'Based on (315) ratings ',
                                  style: new TextStyle(
                                      color: Colors.grey,),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Reviews',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: Colors.grey.shade700,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          RichText(
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: 'Within 32 mins ',
                                  style: new TextStyle(
                                      color: Colors.black),
                                ),
                                new TextSpan(
                                  text: '(OMR 0.590 delivery) ',
                                  style: new TextStyle(
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            color: Colors.pinkAccent,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text('2 RO Off Orders 7 Rials or More!',
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                      Divider(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: Helper.getScreenWidth(context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey.shade100),
                        child: Text(
                          'Delivered by us, with live tracking',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ProductCategoryItem(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Fresh and Frozen',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RestaurantProductsList()
                    ],
                  ),
                ),
              )
            ]))
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ItemBasketScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2, //
                                color: Colors.white,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "0",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'View basket',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'QR 32.00',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
