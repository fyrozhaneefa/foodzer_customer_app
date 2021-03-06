import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/home/components/viewrestButton.dart';

import 'package:foodzer_customer_app/screens/home/sections/homeLogin.dart';
import 'package:foodzer_customer_app/screens/home/sections/itemCategory.dart';
import 'package:foodzer_customer_app/screens/home/sections/otherCategoriesSection.dart';
import 'package:foodzer_customer_app/screens/home/sections/popularBrandSection.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';

import 'groceriesSection.dart';
import 'imageSlider.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loginSection(),
            SizedBox(height: 15,),
            ItemCategory(),
            ImageSlider(),
            PopularBrandSection(),
            GroceriesSection(),
            OtherCategoriesSection(),
            ViewRestButton()
          ],
        ),
      );
  }
}


