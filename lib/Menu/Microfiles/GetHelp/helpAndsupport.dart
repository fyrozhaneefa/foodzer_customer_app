import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Models/getHelpmodel.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "HELP & SUPPORT",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
        elevation: .5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Container(
                width: Helper.getScreenWidth(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                      child: Text(
                        "You have 0 active refund",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "VIEW MY REFUNDS",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(150, 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "RECENT ORDER",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: Helper.getScreenWidth(context),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
                    child: Text(
                      "Arya Bhavan",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Text(
                      "Mavoor",
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text("₹90",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade500)),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10,
                          color: Colors.grey.shade600,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: MySeparator(height: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Puttu (1 Pc) (2)",
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text(
                      "Apr 02,2022.09:38 AM",
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "HELP WITH OTHER QUERIES",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            FutureBuilder(
                future: GetHelp().gethelp(),
                builder:
                    (context, AsyncSnapshot<List<IssueCategory>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  else if (snapshot.hasData) {
                    return Container(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            IssueCategory item =
                                snapshot.data!.elementAt(index);

                            return Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(item.issueCategory!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child:
                                          Icon(Icons.arrow_forward_ios_rounded,size: 15,color: Colors.grey,),
                                    ),
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return Divider(thickness: .5,);
                          },
                          itemCount: snapshot.data!.length),
                      height: Helper.getScreenHeight(context),
                      decoration: BoxDecoration(color: Colors.white),
                    );
                  } else {
                    return Center(
                      child: Text("Some Eroor Occured!!"),
                    );
                  }
                })
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}

class GetHelp {
  Future<List<IssueCategory>?> gethelp() async {
    final response = await http.post(
        Uri.parse("https://www.foodzer.com/Mob_food_new/get_help"),
        headers: {
          "Cookie": "ci_session=bc80efca67175946a5930832b77052939362357a"
        });

    final jsonData = jsonDecode(response.body);
    var data = GetHelpModel.fromJson(jsonData).issueCategory;
    return data;
  }
}
