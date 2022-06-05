import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import '../FiltterSection/constants/sizedbox.dart';

class Headersection extends StatelessWidget {
  const Headersection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: InkWell(
              child: Icon(Icons.close_sharp, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
              }),
          title:
              Text("Cuisines", style: TextStyle(fontWeight: FontWeight.w600)),
          trailing: TextButton(
            onPressed: () {
              Provider.of<ApplicationProvider>(context ,listen: false)
                  .filterRestaurants([],"");
              Navigator.of(context).pop();
            },
            child: Text(
              "Clear all",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrangeAccent),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Container(
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(.7),
                  ),
                  hintText: "Search cuisine"),
            ),
          ),
        )
      ],
    );
  }
}
