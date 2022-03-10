import 'package:flutter/material.dart';
class ButtonContainer extends StatefulWidget {
  const ButtonContainer({Key? key}) : super(key: key);

  @override
  _ButtonContainerState createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(child:
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(padding: EdgeInsets.all(10),child:ElevatedButton(
            onPressed: () {},
            child: Text(
              "UPDATE",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange.shade300,
              fixedSize: Size(170, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ),
          Padding(padding: EdgeInsets.all(10),child:ElevatedButton(
            onPressed: () {},
            child: Text(
              "CANCEL",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.deepOrange.shade300),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              fixedSize: Size(170, 50),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.deepOrange.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ),

        ],
      ),);
  }
}
