import 'package:flutter/material.dart';

import '../../../Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import '../../../Menu/Microfiles/PaymentSection/payment_home.dart';
import '../../../utils/helper.dart';
class ProceedToPay extends StatelessWidget {
  const ProceedToPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.getScreenWidth(context) * 1,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20

          ),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              Expanded(
                child: ListTile(
                  title: Text(
                    "Deliver to Home | 21 MINS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                  subtitle: Text(
                    "Kozhikode Mavoor,Mavoor Road...",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: Container(
                    width: 65,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.grey.shade300, width: 1),
                    ),

                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                      Icon(Icons.home,color: Colors.deepOrange),
                      Icon(Icons.keyboard_arrow_down_rounded ,size: 20,color: Colors.deepOrange),


                    ]
                    ),

                  ),
                ),
              )
            ],
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 20, right: 20,),
            child: MySeparator(),
          ),




          ListTile(
            title: Text(
              "₹411.3",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            subtitle: Text(
              "View Detailed Bill",
              style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 12,fontWeight: FontWeight.w600),
            ),
            trailing: Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentSection()));
                  },
                  child: Text(
                    "Proceed to Pay",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    fixedSize: Size(190, 58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),






        ],
      ),
    );
  }
}
