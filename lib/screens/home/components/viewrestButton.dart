import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/allRestaurants.dart';

class ViewRestButton extends StatelessWidget {
  const ViewRestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Container(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    AllRestaurantsScreen()));
          },
          child: Container(
            child: Text(
              "View all restaurants",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),

                // side: BorderSide(color: Colors.grey)
              )),
        ),
      ),
    );
  }
}
