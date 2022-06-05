import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/cuisinesmodel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/allFlowers/AllFlowersScreen.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurants.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategory.dart';
import 'package:provider/provider.dart';

import '../../../Models/SingleRestModel.dart';

class AllRestaurentSearch extends StatefulWidget {
  const AllRestaurentSearch({Key? key}) : super(key: key);

  @override
  State<AllRestaurentSearch> createState() => _AllRestaurentSearchState();
}

class _AllRestaurentSearchState extends State<AllRestaurentSearch> {
  bool isSwiched = false;
  TextEditingController searchController=new TextEditingController();
  get orientation => null;
  List<String> checkedCuisineList=[];

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ApplicationProvider>(
        builder: (context, provider, child) {
          return WillPopScope(
            onWillPop: () async {
              Provider.of<ApplicationProvider>(context ,listen: false)
                  .filterRestaurants([],"");
              return await true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_back_rounded,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: searchController,
                              onChanged: (val) {
                                Provider.of<ApplicationProvider>(context ,listen: false)
                                    .filterRestaurants(checkedCuisineList,val);
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "Search for restaurants "),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                        itemCount: provider.cuisinesModelList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Card(
                              elevation: provider.cuisinesModelList[index].isChecked!?1:0,
                              color: provider.cuisinesModelList[index].isChecked!?
                              Colors.black:Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ElevatedButton(
                                  onPressed: () {


                                      if(provider.cuisinesModelList[index].isChecked!){
                                        provider.setCuisineChecked(index,false);
                                        provider.cuisinesModelList[index].isChecked=false;
                                        checkedCuisineList.remove(provider.cuisinesModelList[index].cuisineId);
                                      }else{
                                        provider.setCuisineChecked(index,true);
                                        provider.cuisinesModelList[index].isChecked=true;
                                        checkedCuisineList.add(provider.cuisinesModelList[index].cuisineId!);
                                      }

                                      Provider.of<ApplicationProvider>(context ,listen: false)
                                          .filterRestaurants(checkedCuisineList,searchController.text);
                                  },
                                  child: Text(
                                    provider.cuisinesModelList[index].cuisineName!,
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      // side: BorderSide(color: Colors.black.withOpacity(.3)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                    )
                  ),

                  Restaurants()

                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
