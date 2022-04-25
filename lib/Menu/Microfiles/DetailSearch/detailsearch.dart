import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/singleItemView.dart';
import 'package:provider/provider.dart';

class SearchDetails extends StatefulWidget {
  const SearchDetails({Key? key}) : super(key: key);

  @override
  State<SearchDetails> createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {

  Future<bool> _onBackPressed() async {
    Provider.of<ApplicationProvider>(context, listen: false).clearSearch();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<ApplicationProvider>(
        builder: (context, provider, child) {
            return WillPopScope(
              onWillPop: _onBackPressed,
              child: Column(
        children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onChanged: (val){
                          provider.setSearchItemList(val);
                        },
                      ),
                    ),
                    flex: 4,
                  ),
                  InkWell(
                    onTap: () {
                      _onBackPressed();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                child: ListView.separated(
                    physics: ScrollPhysics(),
                  itemCount: provider.searchItemList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return SingleItemView(provider.searchItemList[index]);
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: null!= provider.searchItemList[index].enteredQty?
                              BorderSide(
                                  color: Colors.deepOrangeAccent, width: 7):
                                  BorderSide.none

                            ),
                            // borderRadius: BorderRadius.only( topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Row(
                                  children: [
                                    Text(null != provider.searchItemList[index].enteredQty
                                        ? '${provider.searchItemList[index].enteredQty.toString()}x'
                                        : "",
                                      style:TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepOrange
                                      ),),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Text(provider.searchItemList[index].itemName!,
                                          style: TextStyle(fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(provider.searchItemList[index].isPriceon == 1?
                                        "Price on selection" : "INR "+ provider.searchItemList[index].itemPrice.toString(),
                                        style: TextStyle(fontWeight: FontWeight.w400)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:20.0),
                                    child: ClipRRect(
                                      child: Image(
                                          image: NetworkImage(
                                              provider.searchItemList[index].itemImage.toString()),
                                        width: 120,
                                        fit: BoxFit.cover,
                                         ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },),
              )
        ],
      ),
            );},
          )),
    );
  }
}
