import 'package:flutter/material.dart';

class RecommededPayments extends StatelessWidget {
  const RecommededPayments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10,bottom: 20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:7),
          child: Column(children: [
            ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Foodzer Pay",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Card(color: Colors.grey.shade300,
                      child: Image(
                          image: NetworkImage(
                              "https://www.foodzer.com/Mob_food_new/uploads/items/noitem_image.png"))),
                ),
                subtitle: Text(
                  "Please complete KYC to enable Foodzer Pay",
                  style: TextStyle(fontSize: 11),
                )),
          ]),
        ),
      ),
    );
  }
}
