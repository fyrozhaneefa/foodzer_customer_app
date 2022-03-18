import 'package:flutter/material.dart';

import '../../../Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import '../../../utils/helper.dart';
class BillDetails extends StatelessWidget {
  const BillDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: Helper.getScreenWidth(context) * 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Text("Item Total"),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15, top: 20),
                child: Text("₹320"),
              )
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    // child: Text("Delivery Fee | 1.7 kms"),
                    child:  Tooltip(
                      preferBelow: false,
                      message: 'Delivery Fee break up for this order',
                      triggerMode: TooltipTriggerMode.tap,
                      child: Text('Delivery Fee',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.deepOrangeAccent,
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: 15, top: 15),
                    child: Text("₹50"),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              top: 10,
            ),
            child: Text(
              "This fee compansates your delivery Partner\nfairly",
              style:
              TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 20, right: 20, top: 20),
            child: MySeparator(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text("Delivery Tip"),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15, top: 10),
                child: Text("₹30.00"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Tooltip(
                  preferBelow: false,
                  message: 'Tax and charges',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Text('Tax and Charges',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.deepOrangeAccent,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15, top: 15),
                child: Text("₹11.3"),
              ),
            ],
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 20, right: 20, top: 20),
            child: MySeparator(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text("To Pay",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.6))),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15, top: 20),
                child: Text("₹411.3",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.6))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
