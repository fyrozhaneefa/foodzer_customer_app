import 'package:flutter/material.dart';

class SearchDetails extends StatelessWidget {
  const SearchDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w500),
                  ),
                onTap: (){

                    Navigator.of(context).pop();
                }),
              ))
            ],
          ),
          ListView.separated(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text("Sadaqa",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Price on selection",
                              style: TextStyle(fontWeight: FontWeight.w400)),
                        ),
                        ClipRRect(
                          child: Image(
                              image: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/cardboard-donation-box-icon-cardboard-donation-box-icon-vector-image-isolated-white-background-118402278.jpg"),
                              width: 100),
                        )
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: 5)
        ],
      )),
    );
  }
}
