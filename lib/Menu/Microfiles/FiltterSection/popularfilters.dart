import 'package:flutter/material.dart';

import 'constants/divider.dart';

class PopularFilter extends StatefulWidget {
  const PopularFilter({Key? key}) : super(key: key);

  @override
  State<PopularFilter> createState() => _PopularFilterState();
}

class _PopularFilterState extends State<PopularFilter> {


  List Popular = ['Fast delivery (within 30min)','Free delivery','Price:(low average price)','Top rated','No minimum order'];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            "Popular filters",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),

        ListView.separated(shrinkWrap: true,itemBuilder: (context,index){

          return ListTile(
              title: Text(Popular.elementAt(index),

                  style: TextStyle(
                    fontSize: 14,
                  )),
              // trailing: CheckBoxSection()
          );
        }, separatorBuilder:(context,index){

          return Dividersection();
        }, itemCount: Popular.length)
        // ListTile(
        //     title: Text("Fast delivery (within 30min)",
        //         style: TextStyle(
        //           fontSize: 14,
        //         )),
        //     trailing: CheckBoxSection()),
        // Dividersection(),
        // ListTile(
        //   title: Text("Free delivery",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Price:(low average price)",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("Top rated",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
        // Dividersection(),
        // ListTile(
        //   title: Text("No minimum order",
        //       style: TextStyle(
        //         fontSize: 14,
        //       )),
        //   trailing: CheckBoxSection(),
        // ),
      ],
    );
  }
}
