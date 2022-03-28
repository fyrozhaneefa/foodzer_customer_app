import 'package:flutter/material.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.home_outlined,
            size: 25,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Home",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                  "Kottarakkara,Mavoor Road,Calicut ,kerala,\n673004,india",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text("Phone Number:8943123253",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 12)),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: InkWell(
                    child: Text(
                      "EDIT",
                      style: TextStyle(
                          color: Colors.orange.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: InkWell(
                    child: Text(
                      "DELETE",
                      style: TextStyle(
                          color: Colors.orange.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: InkWell(
                    child: Text(
                      "SHARE",
                      style: TextStyle(
                          color: Colors.orange.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
