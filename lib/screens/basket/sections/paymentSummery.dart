import 'package:flutter/material.dart';

class PaymentSummery extends StatefulWidget {
  const PaymentSummery({Key? key}) : super(key: key);

  @override
  _PaymentSummeryState createState() => _PaymentSummeryState();
}

class _PaymentSummeryState extends State<PaymentSummery> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Payment summery',
              style:TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20
              )
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Subtotal',
                  style:TextStyle(
                      fontWeight: FontWeight.w500
                  )
              ),
              Text(
                  'QR 18.00',
                  style:TextStyle(
                      fontWeight: FontWeight.w500
                  )
              )
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Service Charge',
                  style:TextStyle(
                      fontWeight: FontWeight.w500
                  )
              ),
              Text(
                  'QR 10.00',
                  style:TextStyle(
                      fontWeight: FontWeight.w500
                  )
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Total amount',
                  style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  )
              ),
              Text(
                  'QR 18.00',
                  style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}