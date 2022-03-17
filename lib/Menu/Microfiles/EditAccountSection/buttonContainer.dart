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
              onPressed: () {},
              child: Text(
                "UPDATE",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.deepOrangeAccent,
                fixedSize: Size(155, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  // side: BorderSide(color: Colors.black.withOpacity(.3)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
              child:ElevatedButton(
              onPressed: () {},
              child: Text(
                "CANCEL",
                style: TextStyle(fontWeight: FontWeight.w600,color: Colors.deepOrangeAccent),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.white,
                fixedSize: Size(155, 50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.deepOrange.shade300),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
