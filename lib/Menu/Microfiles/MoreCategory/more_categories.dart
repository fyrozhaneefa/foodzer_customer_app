import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MoreCategory/more_restaurents.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Services/myGlobalsService.dart';
import '../../../screens/allrestaurants/section/popularRestNear.dart';
import '../../../screens/allrestaurants/section/restaurantServiceList.dart';
import '../../../screens/allrestaurants/section/restaurants.dart';
import '../../../utils/helper.dart';
import '../CuisinesSection/cuisinesheader.dart';
import '../FiltterSection/applybutton.dart';
import '../FiltterSection/dealsandoffers.dart';
import '../FiltterSection/popularfilters.dart';
import '../FiltterSection/sortby.dart';
class MoreHome extends StatefulWidget {
  const MoreHome({Key? key}) : super(key: key);

  @override
  State<MoreHome> createState() => _MoreHomeState();
}

class _MoreHomeState extends State<MoreHome> {

  bool isFromCart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        // leadingWidth: 30,
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    GoogleMapScreen(new AddressModel(),isFromCart, LatLng(0, 0))));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Delivering to",
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Text(
                    null != finalAddress ? finalAddress : 'Select a location',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  ))
            ],
          ),
        ),
        bottom: PreferredSize(
          child: Column(
            children: [
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                filterSheet();
                              },
                              child: Text(
                                'Filters',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.fastfood_outlined,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                cusinesSheet();
                              },
                              child: Text(
                                'Cuisines',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      InkWell(child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.search_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                        onTap: (){

                        },),

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

            SizedBox(height: 50,),
            MoreRestaurents()


          ],
        ),
      ),
    );
  }

  cusinesSheet() {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Headersection(),
            // Expanded(
            //   // child: CuisinesItems(),
            // ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Apply",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  fixedSize: Size(Helper.getScreenWidth(context), 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  filterSheet() {
    showModalBottomSheet(isScrollControlled: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: (context),
        builder: (context) {


          return Column(
            children: [


              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.070),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close_sharp),
                          ),
                        ),
                        Center(
                          child: Text("Filters",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "Clear all",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrangeAccent),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,
                    children: [

                      PopularFilter(),
                      FiltterItems(),

                      SortBy(),
                    ],
                  ),
                ),
              ),
              ApplyButton(buttonname: "Apply", radius:10)
            ],
          );
        });
  }
}
