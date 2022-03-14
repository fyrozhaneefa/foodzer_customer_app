import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class ButtonContainer extends StatefulWidget {
  const ButtonContainer({Key? key}) : super(key: key);

  @override
  _ButtonContainerState createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 80,width: Helper.getScreenWidth(context)*1,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
              },
              child: Text(
                "UPDATE",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange.shade300,
                fixedSize: Size(155, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
              child:ElevatedButton(
              onPressed: () {

              },
              child: Text(
                "CANCEL",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.deepOrange.shade300),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                fixedSize: Size(155, 50),
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.deepOrange.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
