import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection/ratedDelivery.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/MyOrderSection/reorder.dart';



import 'divider.dart';
class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Text("Thalassery Restaurant",
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, right: 5),
              child: RichText(
                text: TextSpan(
                    text: "Delivered",
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                          child: Icon(
                            Icons.check_circle,
                            size: 15,
                            color: Colors.green,
                          ))
                    ]),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text("Kozhikode",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "230 ",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.grey, size: 12),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: DividingSection(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            "Fish Pothichoru x 1",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            "February 24, 1:30 PM",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: ReorderButton(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: RateDelivery(),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Divider(color: Colors.black, thickness: 2),
        )
      ],
    );
  }
}
