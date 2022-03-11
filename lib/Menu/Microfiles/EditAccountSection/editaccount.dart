import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/EditAccountSection/textfield.dart';

import 'buttonContainer.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  bool isname = true;
  bool isphone = true;
  bool isemail = true;
  @override
  void initState() {

    isname= false;
    isphone = false;
    isemail = false;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, icon: Icon(Icons.keyboard_backspace_outlined,color: Colors.black,size: 30,)),
        title: Text("EDIT ACCOUNT",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
      body:SingleChildScrollView(child: Column(
        children: [
          TextSection(
            onpressed: () {
              setState(() {
                isname = !isname;
                isphone =false;
                isemail=false;
              });
            },
            label: "NAME",
          ),
          isname ? ButtonContainer() : Container(),
          TextSection(
              label: "PHONE NUMBER",
              onpressed: () {
                setState(() {
                  isphone = !isphone;
                  isname =false;
                  isemail=false;
                });
              }),
          isphone ? ButtonContainer() : Container(),
          TextSection(
              label: "EMAIL ADDRESS",
              onpressed: () {
                setState(() {
                  isemail = !isemail;
                  isname =false;
                  isphone=false;
                });
              }),
          isemail ? ButtonContainer() : Container(),
        ],
      ),
    ));
  }
}
