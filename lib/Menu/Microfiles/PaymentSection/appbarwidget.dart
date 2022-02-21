import 'package:flutter/material.dart';
class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(tileColor: Colors.white,leading: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Icon(Icons.arrow_back,size: 30,),
    ),title: Text("Payment Option",style: TextStyle(fontWeight: FontWeight.w600),),subtitle: Row(
      children: [
        Text("1 item ."),
        Text("Total:₹212"),
      ],
    ),
    );
  }
}
