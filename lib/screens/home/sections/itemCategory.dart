import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';

import '../../../blocs/application_bloc.dart';
import 'categoryCard.dart';
import 'categoryItems.dart';

class ItemCategory extends StatefulWidget {
  const ItemCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Helper.getScreenWidth(context),
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top:10.0,right: 20.0,bottom: 5.0,left: 20.0),
            child: Text(
              "What would you like to order?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 20),
          CategoryItems(),
        ],
      ),
    );
  }
}



