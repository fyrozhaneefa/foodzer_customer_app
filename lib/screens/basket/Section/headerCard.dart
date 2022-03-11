import 'package:flutter/material.dart';

import '../../../Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import '../../../utils/helper.dart';
class BasketHeader extends StatefulWidget {
  const BasketHeader({Key? key}) : super(key: key);

  @override
  _BasketHeaderState createState() => _BasketHeaderState();
}

class _BasketHeaderState extends State<BasketHeader> {

  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: Helper.getScreenWidth(context) * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("WELCOME50 eligible items ",
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w500)),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Fish Biriyani (Half)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                flex: 10,
              ),
              Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade400,
                        width: 0.5),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Padding(
                        padding:
                        EdgeInsets.only(left: 5, right: 10),
                        child: InkWell(
                          onTap: () => setState(() =>
                          _itemCount != 0
                              ? _itemCount--
                              : _itemCount),
                          child: Icon(
                            Icons.remove,
                            color: Colors.green[700],
                            size: 20,
                          ),
                        )),
                    Text(_itemCount.toString(),
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () => setState(() {
                          _itemCount++;
                        }),
                        child: Icon(
                          Icons.add,
                          color: Colors.green[700],
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "₹320",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 15),
              child: MySeparator()),
          Container(
            height: 59,
            width: Helper.getScreenWidth(context) * 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child:
                  Text("Write instruction for restaurant"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.add_circle_outline_outlined,
                      size: 20, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
