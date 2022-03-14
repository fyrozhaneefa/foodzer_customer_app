import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(),
        child: InkWell(
          child: Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.black.withOpacity(.5), size: 30,
          ),
        onTap: (){
          Navigator.pop(context);
        },),
      ),
      title: Text(
        "Payment Option",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          Text("1 item ."),
          Text("Total:₹212"),
        ],
      ),
    );
  }
}
